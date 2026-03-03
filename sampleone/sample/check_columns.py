
import mysql.connector

try:
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="ashfaq123@2005",
        database="student_performance_db"
    )
    cursor = db.cursor()
    cursor.execute("SHOW COLUMNS FROM student_performance")
    columns = cursor.fetchall()
    print("Columns in student_performance:")
    for col in columns:
        print(col[0])
        
except Exception as e:
    print(e)
