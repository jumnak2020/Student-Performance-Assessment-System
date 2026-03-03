from flask import Flask, render_template, request, redirect, url_for, session, send_file
import mysql.connector
import joblib
import numpy as np
import os
from io import BytesIO
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score, mean_squared_error
import matplotlib
matplotlib.use('Agg')

app = Flask(__name__)
app.secret_key = 'your_secret_key_here'

def get_db_connection():
    try:
        connection = mysql.connector.connect(
            host="localhost", user="root",
            password="ashfaq123@2005",
            database="student_performance_db"
        )
        if connection.is_connected():
            print("MySQL Connected")
            return connection
        return None
    except mysql.connector.Error as e:
        print("Database Error:", e)
        return None

MODEL_PATH = 'student_performance_model.pkl'
model = joblib.load(MODEL_PATH)

def get_model():
    if os.path.exists(MODEL_PATH):
        return joblib.load(MODEL_PATH)
    return None

def get_institution_scope(role):
    if role in ('School Admin', 'School Teacher'):
        return 'school'
    elif role in ('College Admin', 'College Teacher'):
        return 'college'
    return None

def generate_student_id(cursor, institution_type):
    prefix = 'SCH' if institution_type == 'school' else 'COL'
    cursor.execute(
        "SELECT student_id FROM students WHERE student_id LIKE %s ORDER BY student_id DESC LIMIT 1",
        (f"{prefix}%",)
    )
    last = cursor.fetchone()
    if last:
        last_id = last['student_id'] if isinstance(last, dict) else last[0]
        num = int(last_id[3:]) + 1
    else:
        num = 1
    return f"{prefix}{num:03d}"

def ensure_student_exists(cursor, student_id, student_name):
    try:
        cursor.execute("SELECT student_id FROM students WHERE student_id = %s", (student_id,))
        if cursor.fetchone() is None:
            name_parts = student_name.strip().split()
            first_name = name_parts[0] if name_parts else "Unknown"
            last_name  = " ".join(name_parts[1:]) if len(name_parts) > 1 else ""
            cursor.execute(
                "INSERT INTO students (student_id, admission_number, first_name, last_name, class_grade) VALUES (%s, %s, %s, %s, %s)",
                (student_id, student_id, first_name, last_name, "N/A")
            )
            print(f"Created student: {student_name} ({student_id})")
        return True
    except Exception as e:
        print(f"Error ensuring student exists: {e}")
        return False

@app.route('/')
def home():
    return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        role    = request.form.get('role')
        user_id = request.form.get('user_id')
        if role and user_id:
            session['role']               = role
            session['user_id']            = user_id
            session['institution_scope']  = get_institution_scope(role)
            if role == 'Student':
                session['student_id'] = user_id
                return redirect(url_for('view_results'))
            else:
                return redirect(url_for('dashboard'))
    return render_template('login.html')

@app.route('/student_result')
def student_result():
    if 'role' not in session or session['role'] != 'Student':
        return redirect(url_for('login'))
    student_id = session.get('student_id')
    if not student_id:
        return redirect(url_for('login'))
    try:
        conn   = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM performance_results WHERE student_id = %s ORDER BY assessment_date DESC LIMIT 1", (student_id,))
        result = cursor.fetchone()
    except Exception as e:
        result = None
    finally:
        cursor.close()
        conn.close()
    return render_template('result.html', **result) if result else render_template('result.html', error="No results found")

@app.route('/dashboard')
def dashboard():
    if 'role' not in session:
        return redirect(url_for('login'))
    error             = session.pop('error', None)
    institution_scope = session.get('institution_scope')
    return render_template('dashboard.html', error=error, institution_scope=institution_scope)

@app.route('/result', methods=['POST'])
def result():
    try:
        conn   = get_db_connection()
        if not conn:
            raise Exception("Failed to connect to database")
        cursor = conn.cursor(dictionary=True)
    except Exception as e:
        return render_template('dashboard.html', error=f"Database Connection Failed: {str(e)}")
    try:
        institution_type = request.form.get('institution_type')
        student_name     = request.form.get("student_name")
        name             = student_name
        if not institution_type or not student_name:
            raise ValueError("Missing required fields")

        student_id = generate_student_id(cursor, institution_type)
        print(f"Auto-generated Student ID: {student_id}")

        if institution_type == 'school':
            marks                 = float(request.form.get('marks', 0))
            attendance            = float(request.form.get('attendance', 0))
            assignment_timeliness = float(request.form.get('semester', 0))
            semester              = None
            prior_gpa             = None
            behavior_score        = ((marks * 0.6) + (attendance * 0.4)) / 10
            ml_marks              = marks
            ml_attendance         = attendance
            ml_behavior           = behavior_score
            performance_score     = behavior_score
        else:
            prior_gpa         = float(request.form.get('marks', 0))
            attendance        = float(request.form.get('attendance', 0))
            semester_raw      = request.form.get('semester', '1').strip()
            semester_clean    = ''.join(filter(str.isdigit, semester_raw))
            semester          = int(semester_clean) if semester_clean else 1
            sem_val           = float(semester)
            semester_pct      = (sem_val / 8) * 100
            performance_score = ((prior_gpa*10*0.5) + (attendance*0.4) + (semester_pct*0.1)) / 10
            ml_marks          = prior_gpa * 10
            ml_attendance     = attendance
            ml_behavior       = (performance_score * 10) / 10
            behavior_score    = performance_score
            marks             = None
            assignment_timeliness = None

        features = np.array([[ml_marks, ml_attendance, ml_behavior]])
        ml_model = get_model()
        if ml_model:
            prediction = ml_model.predict(features)[0]
        else:
            avg_score = (ml_marks + ml_attendance + (ml_behavior * 10)) / 3
            prediction = "Fast Learner" if avg_score >= 75 else ("Average Learner" if avg_score >= 50 else "Slow Learner")

        if prediction == 'Slow Learner':
            suggestions = ["Arrange remedial classes.", "Provide extra learning materials.", "Monitor attendance strictly."]
        elif prediction == 'Average Learner':
            suggestions = ["Encourage participation in group studies.", "Focus on weak subject areas."]
        else:
            suggestions = ["Assign advanced projects.", "Encourage peer tutoring."]

        if not ensure_student_exists(cursor, student_id, student_name):
            raise ValueError(f"Failed to create student: {student_name}")

        assignments = assignment_timeliness if institution_type == 'school' else None

        if institution_type == 'school':
            sp_values = (student_id, "General", marks, attendance, assignment_timeliness, None, None, None, institution_type)
        else:
            sp_values = (student_id, "General", None, attendance, None, None, prior_gpa, semester, institution_type)

        cursor.execute(
            "INSERT INTO student_performance (student_id, subject, marks, attendance_percentage, assignment_timeliness, participation_score, prior_gpa, semester, institution_type) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)",
            sp_values
        )
        conn.commit()

        display_marks = prior_gpa if institution_type == 'college' else marks
        cursor.execute(
            "INSERT INTO performance_results (student_id, student_name, marks, attendance, assignments, performance_score, learner_type) VALUES (%s,%s,%s,%s,%s,%s,%s)",
            (student_id, student_name, display_marks if display_marks is not None else 0, attendance, assignments if assignments is not None else 0, performance_score, prediction)
        )
        conn.commit()
        cursor.close()
        conn.close()

        return render_template('result.html',
            name=name, student_id=student_id,
            marks=marks if institution_type == 'school' else prior_gpa,
            attendance=attendance, behavior=behavior_score,
            prediction=prediction, suggestions=suggestions,
            institution_type=institution_type)

    except Exception as e:
        import traceback
        print(f"ERROR: {e}\n{traceback.format_exc()}")
        try:
            cursor.close()
            conn.close()
        except:
            pass
        session['error'] = f"Database Error: {str(e)}"
        return redirect(url_for('dashboard'))

@app.route('/view_results')
def view_results():
    if 'role' not in session:
        return redirect(url_for('login'))
    role              = session.get('role')
    institution_scope = session.get('institution_scope')
    institution       = request.args.get('institution')
    if institution_scope:
        institution = institution_scope
    try:
        conn   = get_db_connection()
        cursor = conn.cursor(dictionary=True)
    except Exception as e:
        return render_template('view_results.html', results=[], institution=None, error=str(e))

    base_q = """
    SELECT sp.student_id,
           TRIM(CONCAT(s.first_name,' ',COALESCE(NULLIF(s.last_name,'Unknown'),''))) AS student_name,
           s.class_grade,
           s.semester,
           sp.marks, sp.prior_gpa, sp.attendance_percentage,
           sp.assignment_timeliness, sp.participation_score,
           sp.created_at, sp.institution_type
    FROM student_performance sp
    JOIN students s ON sp.student_id = s.student_id
"""
    if role == 'Student':
        student_id = session.get('student_id')
        if not student_id:
            cursor.close(); conn.close()
            return redirect(url_for('login'))
        query  = base_q + " WHERE sp.student_id = %s ORDER BY sp.created_at DESC"
        params = (student_id,)
    else:
        query  = base_q
        params = ()
        if institution:
            query  += " WHERE LOWER(sp.institution_type) = LOWER(%s)"
            params  = (institution,)
        query += " ORDER BY sp.created_at DESC"

    try:
        cursor.execute(query, params)
        results = cursor.fetchall()
    except Exception as e:
        print(f"DB Error: {e}")
        results = []
    finally:
        cursor.close()
        conn.close()

    return render_template("view_results.html", results=results, institution=institution)
@app.route('/history', methods=['GET', 'POST'])
def history():
    if 'role' not in session:
        return redirect(url_for('login'))
    institution_scope = session.get('institution_scope')
    history_data      = []
    student_id        = None

    try:
        conn   = get_db_connection()
        cursor = conn.cursor(dictionary=True)
    except Exception as e:
        return render_template('history.html', history=[], student_id=None, error=str(e))

    base_q = """
        SELECT sp.performance_id AS id, sp.student_id,
               TRIM(CONCAT(s.first_name,' ',COALESCE(NULLIF(s.last_name,'Unknown'),''))) AS student_name,
               sp.marks AS previous_term_percentage,
               sp.attendance_percentage,
               s.class_grade,
               s.semester,
               sp.prior_gpa AS prior_gpa_cgpa,
               sp.created_at, LOWER(sp.institution_type) AS institution_type
        FROM student_performance sp
        JOIN students s ON sp.student_id = s.student_id
    """

    if session['role'] == 'Student':
        student_id = session.get('student_id')
        if not student_id:
            cursor.close(); conn.close()
            return redirect(url_for('login'))
        try:
            cursor.execute(base_q + " WHERE sp.student_id = %s ORDER BY sp.created_at DESC", (student_id,))
            history_data = cursor.fetchall()
        except Exception as e:
            print(f"DB Error: {e}")
    else:
        if request.method == 'POST':
            student_id = request.form.get('student_id')
            if student_id:
                if institution_scope:
                    q = base_q + " WHERE sp.student_id=%s AND LOWER(sp.institution_type)=LOWER(%s) ORDER BY sp.created_at DESC"
                    p = (student_id, institution_scope)
                else:
                    q = base_q + " WHERE sp.student_id=%s ORDER BY sp.created_at DESC"
                    p = (student_id,)
                try:
                    cursor.execute(q, p)
                    history_data = cursor.fetchall()
                except Exception as e:
                    print(f"DB Error: {e}")

    cursor.close()
    conn.close()
    return render_template('history.html', history=history_data, student_id=student_id)
@app.route('/update_record/<int:performance_id>', methods=['GET', 'POST'])
def update_record(performance_id):
    try:
        conn   = get_db_connection()
        cursor = conn.cursor()
    except Exception as e:
        return render_template('update_record.html', record=None, error=str(e))

    if request.method == 'POST':
        institution_type = request.form.get('institution_type')
        attendance       = float(request.form['attendance'])
        
        # Get student_id to update students table
        cursor_temp = conn.cursor(dictionary=True)
        cursor_temp.execute("SELECT student_id FROM student_performance WHERE performance_id=%s", (performance_id,))
        perf_rec = cursor_temp.fetchone()
        cursor_temp.close()
        
        if not perf_rec:
            cursor.close(); conn.close()
            return render_template('update_record.html', record=None, error="Record not found")
        
        student_id = perf_rec['student_id']
        
        if institution_type == 'school':
            marks = float(request.form['marks'])
            class_grade = request.form.get('class_grade')  # Get class_grade
            prior_gpa = None
            semester = None
            
            # Update student_performance
            cursor.execute(
                "UPDATE student_performance SET marks=%s, attendance_percentage=%s, institution_type=%s WHERE performance_id=%s",
                (marks, attendance, institution_type, performance_id)
            )
            
            # Update students table with class_grade
            if class_grade:
                cursor.execute(
                    "UPDATE students SET class_grade=%s WHERE student_id=%s",
                    (class_grade, student_id)
                )
        else:
            prior_gpa = float(request.form['prior_gpa'])
            semester  = request.form.get('semester')
            marks = None
            
            # Update student_performance
            cursor.execute(
                "UPDATE student_performance SET prior_gpa=%s, attendance_percentage=%s, institution_type=%s WHERE performance_id=%s",
                (prior_gpa, attendance, institution_type, performance_id)
            )
            
            # Update students table with semester
            if semester:
                cursor.execute(
                    "UPDATE students SET semester=%s WHERE student_id=%s",
                    (semester, student_id)
                )
        
        try:
            conn.commit()
        except Exception as e:
            cursor.close(); conn.close()
            return render_template('update_record.html', record=None, error=str(e))
        
        cursor.close(); conn.close()
        return redirect(url_for('history'))

    # GET request - fetch record with class_grade and semester from students table
    try:
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT sp.*, s.class_grade, s.semester as student_semester
            FROM student_performance sp
            JOIN students s ON sp.student_id = s.student_id
            WHERE sp.performance_id=%s
        """, (performance_id,))
        record = cursor.fetchone()
    except Exception as e:
        record = None
    finally:
        cursor.close(); conn.close()
    
    return render_template('update_record.html', record=record)
@app.route('/delete_record/<int:performance_id>', methods=['POST'])
def delete_record(performance_id):
    try:
        conn   = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM student_performance WHERE performance_id=%s", (performance_id,))
        conn.commit()
    except Exception as e:
        print(f"Delete Error: {e}")
    finally:
        cursor.close(); conn.close()
    return redirect(url_for('history'))

@app.route('/student_graph', methods=['GET', 'POST'])
def student_graph():
    if 'role' not in session:
        return redirect(url_for('login'))
    student_id    = None
    no_data       = False
    accuracy_text = None

    if session['role'] == 'Student':
        student_id = session.get('student_id')
        if not student_id:
            return render_template('student_graph.html', error="Please log in to view your graphs.")
    elif request.method == 'POST':
        student_id = request.form.get('student_id')

    if student_id:
        try:
            conn   = get_db_connection()
            cursor = conn.cursor(dictionary=True)
        except Exception as e:
            return render_template('student_graph.html', error=str(e), student_id=student_id, no_data=False)

        institution_scope = session.get('institution_scope')
        if institution_scope:
            q = "SELECT created_at,marks,prior_gpa,attendance_percentage,assignment_timeliness,institution_type FROM student_performance WHERE student_id=%s AND LOWER(institution_type)=LOWER(%s) ORDER BY created_at ASC"
            p = (student_id, institution_scope)
        else:
            q = "SELECT created_at,marks,prior_gpa,attendance_percentage,assignment_timeliness,institution_type FROM student_performance WHERE student_id=%s ORDER BY created_at ASC"
            p = (student_id,)

        try:
            cursor.execute(q, p)
            data = cursor.fetchall()
        except Exception as e:
            data = []
        finally:
            cursor.close(); conn.close()

        if not data:
            if institution_scope:
                try:
                    conn2   = get_db_connection()
                    cursor2 = conn2.cursor(dictionary=True)
                    cursor2.execute("SELECT institution_type FROM student_performance WHERE student_id=%s LIMIT 1", (student_id,))
                    any_rec = cursor2.fetchone()
                    cursor2.close(); conn2.close()
                    if any_rec:
                        wi = any_rec['institution_type'].capitalize()
                        return render_template('student_graph.html',
                            error=f"Student ID {student_id} belongs to a {wi} student. As {session.get('role')}, you can only view {institution_scope.capitalize()} student graphs.",
                            student_id=student_id, no_data=False)
                except Exception as e:
                    print(f"Cross-check error: {e}")
            no_data = True
        elif len(data) < 2:
            return render_template("student_graph.html",
                error="Not enough data to generate graph (need at least 2 records)",
                student_id=student_id, no_data=False)
        else:
            import plotly.graph_objects as go
            dates      = [row["created_at"] for row in data]
            attendance = [row["attendance_percentage"] for row in data]
            marks      = [row["marks"] if row["marks"] is not None else (row["prior_gpa"]*10 if row["prior_gpa"] else 0) for row in data]
            valid_m    = [m for m in marks if m and m > 0]
            valid_a    = [a for a in attendance if a is not None]
            if not valid_m or not valid_a:
                return render_template("student_graph.html", error="Insufficient valid data", student_id=student_id, no_data=False)
            avg_marks = sum(valid_m)/len(valid_m)
            avg_att   = sum(valid_a)/len(valid_a)
            X = np.arange(len(marks)).reshape(-1,1)
            y = np.array(marks)
            lm = LinearRegression(); lm.fit(X,y)
            y_pred = lm.predict(X)
            r2     = r2_score(y,y_pred)
            mse    = mean_squared_error(y,y_pred)
            accuracy_text = f"Prediction Accuracy (R² Score): {r2:.2f} | MSE: {mse:.2f}"
            future_X = np.arange(len(marks), len(marks)+3).reshape(-1,1)
            pred_m   = lm.predict(future_X)
            ds       = [d.strftime('%Y-%m-%d') for d in dates]
            fl       = ["Future 1","Future 2","Future 3"]
            al       = ds + fl

            fig_ml = go.Figure()
            fig_ml.add_trace(go.Scatter(x=list(range(len(marks))),y=marks,mode='lines+markers',name='Actual',hovertemplate='<b>%{text}</b><br>%{y:.1f}%<extra></extra>',text=ds))
            fig_ml.add_trace(go.Scatter(x=list(range(len(marks),len(marks)+3)),y=pred_m.tolist(),mode='lines+markers',name='Predicted',line=dict(dash='dash',color='red'),hovertemplate='<b>%{text}</b><br>%{y:.1f}%<extra></extra>',text=fl))
            fig_ml.update_layout(title='ML Prediction',xaxis=dict(title='Assessment',ticktext=al,tickvals=list(range(len(al)))),yaxis_title='Score',hovermode='closest',height=400,modebar_remove=['select','lasso2d'])
            ml_html = fig_ml.to_html(full_html=False,include_plotlyjs='cdn')

            fig_p = go.Figure()
            fig_p.add_trace(go.Scatter(x=ds,y=marks,mode='lines+markers',name='Performance',hovertemplate='<b>%{x}</b><br>%{y:.1f}%<extra></extra>'))
            fig_p.update_layout(title='Performance Over Time',xaxis_title='Date',yaxis_title='Score',hovermode='closest',height=400,modebar_remove=['select','lasso2d'])
            perf_html = fig_p.to_html(full_html=False,include_plotlyjs=False)

            fig_a = go.Figure()
            fig_a.add_trace(go.Scatter(x=ds,y=attendance,mode='lines+markers',name='Attendance',line=dict(color='green'),marker=dict(color='green'),hovertemplate='<b>%{x}</b><br>%{y:.1f}%<extra></extra>'))
            fig_a.update_layout(title='Attendance Over Time',xaxis_title='Date',yaxis_title='Attendance (%)',hovermode='closest',height=400,modebar_remove=['select','lasso2d'])
            att_html = fig_a.to_html(full_html=False,include_plotlyjs=False)

            fig_b = go.Figure()
            fig_b.add_trace(go.Bar(x=['Avg Performance','Avg Attendance'],y=[avg_marks,avg_att],hovertemplate='<b>%{x}</b><br>%{y:.1f}%<extra></extra>'))
            fig_b.update_layout(title='Average Comparison',yaxis_title='Value',hovermode='closest',height=400,modebar_remove=['select','lasso2d'])
            bar_html = fig_b.to_html(full_html=False,include_plotlyjs=False)

            return render_template('student_graph.html',
                ml_graph_html=ml_html, perf_graph_html=perf_html,
                att_graph_html=att_html, bar_graph_html=bar_html,
                accuracy_text=accuracy_text, student_id=student_id, no_data=False)

    return render_template('student_graph.html', student_id=student_id, no_data=no_data)

@app.route('/download_graph/<student_id>')
def download_graph(student_id):
    from reportlab.lib.pagesizes import A4
    from reportlab.lib import colors
    from reportlab.lib.units import inch
    from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, Image as RLImage
    from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
    from reportlab.lib.enums import TA_CENTER
    import matplotlib; matplotlib.use('Agg')
    import matplotlib.pyplot as plt
    import io
    from datetime import datetime

    if 'role' not in session:
        return redirect(url_for('login'))

    conn = get_db_connection()
    if not conn:
        return "Database connection failed", 500
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT sp.created_at,sp.marks,sp.prior_gpa,sp.attendance_percentage,
               sp.assignment_timeliness,sp.institution_type,sp.semester,
               TRIM(CONCAT(s.first_name,' ',COALESCE(NULLIF(s.last_name,''),''))) AS student_name
        FROM student_performance sp JOIN students s ON sp.student_id=s.student_id
        WHERE sp.student_id=%s ORDER BY sp.created_at ASC
    """, (student_id,))
    data = cursor.fetchall()
    cursor.execute("SELECT learner_type,performance_score FROM performance_results WHERE student_id=%s ORDER BY assessment_date DESC LIMIT 1", (student_id,))
    res = cursor.fetchone()
    learner_type      = res['learner_type'] if res else 'N/A'
    performance_score = res['performance_score'] if res else 0
    cursor.close(); conn.close()

    institution_scope = session.get('institution_scope')
    if institution_scope and data:
        si = data[0]['institution_type'].lower() if data[0]['institution_type'] else ''
        if si != institution_scope.lower():
            return (f"Access Denied: Student {student_id} is a {si.capitalize()} student. "
                    f"As {session.get('role')}, you can only download {institution_scope.capitalize()} reports."), 403
    if institution_scope and not data:
        return (f"Access Denied: No {institution_scope.capitalize()} records for Student ID {student_id}."), 403

    if not data or len(data) < 2:
        return "Not enough data for PDF (need at least 2 records)", 404

    student_name     = data[0]['student_name']
    institution_type = data[0]['institution_type']
    dates            = [row["created_at"] for row in data]
    attendance       = [row["attendance_percentage"] for row in data]
    dates_str        = [d.strftime('%Y-%m-%d') for d in dates]
    marks            = [float(row["marks"]) if row["marks"] is not None else (float(row["prior_gpa"])*10 if row["prior_gpa"] else 0) for row in data]
    avg_marks        = sum(marks)/len(marks)
    avg_att          = sum(attendance)/len(attendance)

    X  = np.arange(len(marks)).reshape(-1,1); y = np.array(marks)
    lm = LinearRegression(); lm.fit(X,y)
    y_pred = lm.predict(X); r2 = r2_score(y,y_pred); mse = mean_squared_error(y,y_pred)
    pred_m = lm.predict(np.arange(len(marks),len(marks)+3).reshape(-1,1))

    graphs = []
    fl = ["Future 1","Future 2","Future 3"]; al = dates_str + fl
    for fn, title, xd, yd, extra in [
        (1,'ML Prediction of Student Performance', None, None, True),
        (2,'Performance Over Time', dates_str, marks, False),
        (3,'Attendance Over Time', dates_str, attendance, False),
        (4,'Average Performance Comparison', None, None, False),
    ]:
        fig, ax = plt.subplots(figsize=(8,4) if fn!=4 else (6,4))
        if fn == 1:
            ax.plot(range(len(marks)),marks,marker='o',label='Actual',color='blue')
            ax.plot(range(len(marks),len(marks)+3),pred_m,marker='x',linestyle='--',color='red',label='Predicted')
            ax.set_xticks(range(len(al))); ax.set_xticklabels(al,rotation=45,ha='right')
            ax.legend()
        elif fn == 4:
            ax.bar(['Avg Performance','Avg Attendance'],[avg_marks,avg_att],color=['blue','green'])
        else:
            ax.plot(xd,yd,marker='o',color='blue' if fn==2 else 'green')
            plt.xticks(rotation=45,ha='right')
        ax.set_title(title)
        ax.set_ylabel('Performance Score' if fn in (1,2) else ('Attendance (%)' if fn==3 else 'Value (%)'))
        if fn in (1,2): ax.set_xlabel('Assessment' if fn==1 else 'Date')
        plt.tight_layout()
        buf = io.BytesIO(); plt.savefig(buf,format='png',dpi=150,bbox_inches='tight'); buf.seek(0)
        graphs.append(buf); plt.close()

    pdf_buf = io.BytesIO()
    doc     = SimpleDocTemplate(pdf_buf,pagesize=A4,rightMargin=0.5*inch,leftMargin=0.5*inch,topMargin=0.5*inch,bottomMargin=0.5*inch)
    styles  = getSampleStyleSheet()
    ts = ParagraphStyle('T',parent=styles['Title'],fontSize=20,textColor=colors.HexColor('#2c7be5'),spaceAfter=10,alignment=TA_CENTER)
    hs = ParagraphStyle('H',parent=styles['Heading2'],fontSize=14,textColor=colors.HexColor('#2c7be5'),spaceBefore=15,spaceAfter=8)
    ns = ParagraphStyle('N',parent=styles['Normal'],fontSize=11,spaceAfter=5)
    cs = ParagraphStyle('C',parent=styles['Normal'],fontSize=11,alignment=TA_CENTER)

    content = [Paragraph("Student Performance Assessment System",ts), Paragraph("Performance Report",ts), Spacer(1,0.2*inch)]
    content.append(Paragraph("Student Information",hs))
    it = Table([['Student ID:',str(student_id),'Report Date:',datetime.now().strftime('%Y-%m-%d')],['Student Name:',student_name,'Institution:',institution_type.capitalize()],['Learner Type:',learner_type,'Total Records:',str(len(data))]],colWidths=[1.5*inch,2*inch,1.5*inch,2*inch])
    it.setStyle(TableStyle([('BACKGROUND',(0,0),(0,-1),colors.HexColor('#2c7be5')),('BACKGROUND',(2,0),(2,-1),colors.HexColor('#2c7be5')),('TEXTCOLOR',(0,0),(0,-1),colors.white),('TEXTCOLOR',(2,0),(2,-1),colors.white),('FONTNAME',(0,0),(-1,-1),'Helvetica'),('FONTSIZE',(0,0),(-1,-1),10),('PADDING',(0,0),(-1,-1),8),('GRID',(0,0),(-1,-1),0.5,colors.grey)]))
    content += [it, Spacer(1,0.2*inch)]

    content.append(Paragraph("Performance Summary",hs))
    st = Table([['Metric','Value','Status'],['Average Performance',f'{avg_marks:.1f}%','Good' if avg_marks>=70 else 'Needs Improvement'],['Average Attendance',f'{avg_att:.1f}%','Good' if avg_att>=75 else 'Needs Improvement'],['R² Score',f'{r2:.2f}','Good' if r2>=0.7 else 'Moderate' if r2>=0.5 else 'Irregular'],['MSE',f'{mse:.2f}','-'],['Learner Type',learner_type,'-']],colWidths=[2.5*inch,2*inch,2.5*inch])
    st.setStyle(TableStyle([('BACKGROUND',(0,0),(-1,0),colors.HexColor('#2c7be5')),('TEXTCOLOR',(0,0),(-1,0),colors.white),('FONTNAME',(0,0),(-1,0),'Helvetica-Bold'),('FONTNAME',(0,1),(-1,-1),'Helvetica'),('FONTSIZE',(0,0),(-1,-1),10),('PADDING',(0,0),(-1,-1),8),('GRID',(0,0),(-1,-1),0.5,colors.grey),('ALIGN',(1,0),(-1,-1),'CENTER')]))
    content += [st, Spacer(1,0.2*inch)]

    content.append(Paragraph("Recommendations",hs))
    recs = (["Excellent! Keep up the great work.","Consider advanced topics.","Join academic competitions."] if learner_type=='Fast Learner'
        else (["Good progress! Room to improve.","Focus on weak areas.","Participate in group studies."] if learner_type=='Average Learner'
        else ["Immediate attention needed.","Arrange remedial classes.","Monitor attendance strictly."]))
    for r in recs: content.append(Paragraph(r,ns))
    content.append(Spacer(1,0.2*inch))

    content.append(Paragraph("Performance Graphs",hs))
    for buf,gt in zip(graphs,["Graph 1: ML Prediction","Graph 2: Performance Over Time","Graph 3: Attendance Over Time","Graph 4: Average Comparison"]):
        content.append(Paragraph(gt,ns))
        content.append(RLImage(buf,width=6*inch,height=3*inch))
        content.append(Spacer(1,0.1*inch))

    content += [Spacer(1,0.2*inch), Paragraph(f"Generated by Student Performance Assessment System | {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",cs)]
    doc.build(content)
    pdf_buf.seek(0)

    from flask import make_response
    resp = make_response(pdf_buf.read())
    resp.headers['Content-Type'] = 'application/pdf'
    resp.headers['Content-Disposition'] = f'attachment; filename=student_{student_id}_report.pdf'
    return resp

@app.route('/model_comparison')
def model_comparison():
    if 'role' not in session:
        return redirect(url_for('login'))
    
    # Block students from accessing Model Comparison
    if session.get('role') == 'Student':
        return redirect(url_for('dashboard'))
    
    import json
    import os
    from model_comparison import save_both_comparisons

    # ── ALL roles can freely switch between school and college ──
    # Model comparison is analytical content, not private student
    # data, so no institution_scope restriction applies here.
    institution = request.args.get('institution', 'school')
    # ────────────────────────────────────────────────────────────

    json_path = os.path.join(os.path.dirname(__file__), 'model_comparison_results.json')

    try:
        print(f"\n🔄 Auto-updating Model Comparison for {institution}...")
        all_data = save_both_comparisons()
        if all_data and institution in all_data:
            comparison_data = all_data[institution]
            comparison_data['selected_institution'] = institution
            print(f"✅ Model Comparison updated successfully!")
        else:
            with open(json_path, 'r') as f:
                all_data = json.load(f)
            comparison_data = all_data.get(institution)
            if comparison_data:
                comparison_data['selected_institution'] = institution
    except Exception as e:
        print(f"❌ Auto-update error: {e}")
        try:
            with open(json_path, 'r') as f:
                all_data = json.load(f)
            comparison_data = all_data.get(institution)
            if comparison_data:
                comparison_data['selected_institution'] = institution
        except FileNotFoundError:
            comparison_data = None

    return render_template('model_comparison.html',
                           data=comparison_data,
                           institution=institution)
@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('home'))

if __name__ == '__main__':
    app.run(debug=True)