# model_comparison.py
# This file trains and compares 3 ML models for EACH institution type separately

import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestRegressor
from sklearn.svm import SVR
from sklearn.model_selection import cross_val_score, KFold
from sklearn.metrics import r2_score, mean_squared_error
from sklearn.preprocessing import StandardScaler
import mysql.connector
import json
import os

def get_db_connection():
    """Same database connection as your main app"""
    try:
        conn = mysql.connector.connect(
            host='localhost',
            user='root',
            password='ashfaq123@2005',
            database='student_performance_db'
        )
        return conn
    except Exception as e:
        print(f"Database Error: {e}")
        return None

def fetch_training_data(institution_filter=None):
    """
    Fetch data from database for model training
    institution_filter: 'school', 'college', or None (all data)
    """
    conn = get_db_connection()
    if not conn:
        print("❌ Database connection failed!")
        return None, None, None
    
    cursor = conn.cursor(dictionary=True)
    
    if institution_filter == 'school':
        # Fetch ONLY school data - CALCULATE behavior score from marks and attendance
        cursor.execute("""
            SELECT marks as performance, 
                   attendance_percentage as attendance, 
                   ((marks + attendance_percentage) / 20) as behavior,
                   'school' as institution_type
            FROM student_performance
            WHERE institution_type = 'school'
            AND marks IS NOT NULL
            AND attendance_percentage IS NOT NULL
        """)
        data = cursor.fetchall()
        
    elif institution_filter == 'college':
        # Fetch ONLY college data - CALCULATE behavior score from GPA and attendance
        cursor.execute("""
            SELECT (prior_gpa * 10) as performance, 
                   attendance_percentage as attendance,
                   ((prior_gpa + (attendance_percentage / 10)) / 2) as behavior,
                   'college' as institution_type
            FROM student_performance
            WHERE institution_type = 'college'
            AND prior_gpa IS NOT NULL
            AND attendance_percentage IS NOT NULL
        """)
        data = cursor.fetchall()
    else:
        # Fetch both (for debugging only)
        cursor.execute("""
            SELECT marks as performance, 
                   attendance_percentage as attendance, 
                   ((marks + attendance_percentage) / 20) as behavior,
                   'school' as institution_type
            FROM student_performance
            WHERE institution_type = 'school'
            AND marks IS NOT NULL
            AND attendance_percentage IS NOT NULL
        """)
        school_data = cursor.fetchall()
        
        cursor.execute("""
            SELECT (prior_gpa * 10) as performance, 
                   attendance_percentage as attendance,
                   ((prior_gpa + (attendance_percentage / 10)) / 2) as behavior,
                   'college' as institution_type
            FROM student_performance
            WHERE institution_type = 'college'
            AND prior_gpa IS NOT NULL
            AND attendance_percentage IS NOT NULL
        """)
        college_data = cursor.fetchall()
        
        data = school_data + college_data
    
    cursor.close()
    conn.close()
    
    if not data:
        print(f"❌ No data found for filter: {institution_filter}")
        return None, None, institution_filter
    
    print(f"✅ Found {len(data)} records for {institution_filter or 'all'}")
    
    # Convert to numpy arrays
    X = np.array([[row['performance'], row['attendance'], row['behavior']] 
              for row in data])

    # Generate labels based on performance score
    # Classification thresholds: Slow <50%, Average 50-74%, Fast >=75%
    y = []
    for row in data:
        performance = row['performance']
    
        if performance >= 75:
            y.append(2)  # Fast Learner
        elif performance >= 50:
            y.append(1)  # Average Learner
        else:
            y.append(0)  # Slow Learner

    y = np.array(y)

    return X, y, institution_filter
def compare_models(institution_filter=None):
    """
    Compare 3 ML models for specific institution type
    institution_filter: 'school' or 'college'
    """
    institution_label = institution_filter.capitalize() if institution_filter else "Combined"
    
    print("\n" + "="*60)
    print(f"   MODEL COMPARISON - {institution_label} Students")
    print("="*60)
    
    X, y, inst_type = fetch_training_data(institution_filter)
    
    if X is None or y is None:
        return None
    
    if len(X) < 5:
        print(f"⚠️ Only {len(X)} records found. Need at least 5 for comparison.")
        print("Please add more student records first!")
        return None
    
    print(f"\n📊 Dataset: {len(X)} records, {len(np.unique(y))} classes")
    print(f"Classes: Slow(0)={np.sum(y==0)}, Average(1)={np.sum(y==1)}, Fast(2)={np.sum(y==2)}")
    
    # Scale features for SVM
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)
    
    # Define 3 models to compare
    models = {
        'Linear Regression': LinearRegression(),
        'Random Forest': RandomForestRegressor(
            n_estimators=100,
            random_state=42,
            max_depth=5
        ),
        'Support Vector Machine': SVR(
            kernel='rbf',
            C=1.0,
            epsilon=0.1
        )
    }
    
    # K-Fold Cross Validation
    kf = KFold(n_splits=min(5, len(X)), shuffle=True, random_state=42)
    
    results = {}
    
    print("\n📈 Training and Evaluating Models...")
    print("-"*60)
    
    for model_name, model in models.items():
        print(f"\n🔄 Testing {model_name}...")
        
        # Use scaled data for SVM, original for others
        X_use = X_scaled if model_name == 'Support Vector Machine' else X
        
        try:
            # Cross-validation scores
            cv_scores = cross_val_score(
                model, X_use, y,
                cv=kf,
                scoring='r2'
            )
            
            # Fit on all data for final metrics
            model.fit(X_use, y)
            y_pred = model.predict(X_use)
            
            # Calculate metrics
            r2 = r2_score(y, y_pred)
            mse = mean_squared_error(y, y_pred)
            rmse = np.sqrt(mse)
            cv_mean = cv_scores.mean()
            cv_std = cv_scores.std()
            
            results[model_name] = {
                'r2_score': round(float(r2), 4),
                'mse': round(float(mse), 4),
                'rmse': round(float(rmse), 4),
                'cv_mean': round(float(cv_mean), 4),
                'cv_std': round(float(cv_std), 4),
                'cv_scores': [round(float(s), 4) for s in cv_scores]
            }
            
            print(f"   ✅ R² Score: {r2:.4f}")
            print(f"   ✅ MSE: {mse:.4f}")
            print(f"   ✅ RMSE: {rmse:.4f}")
            print(f"   ✅ CV Mean: {cv_mean:.4f} (±{cv_std:.4f})")
            
        except Exception as e:
            print(f"   ❌ Error: {e}")
            results[model_name] = {
                'r2_score': 0,
                'mse': 999,
                'rmse': 999,
                'cv_mean': 0,
                'cv_std': 0,
                'cv_scores': []
            }
    
    # Find best model
    best_model = max(results.items(), key=lambda x: x[1]['r2_score'])
    best_model_name = best_model[0]
    
    print("\n" + "="*60)
    print(f"🏆 BEST MODEL for {institution_label}: {best_model_name}")
    print(f"   R² Score: {best_model[1]['r2_score']:.4f}")
    print("="*60)
    
    # Add metadata
    comparison_data = {
        'institution_type': institution_filter,
        'results': results,
        'best_model': best_model_name,
        'dataset_size': len(X),
        'class_distribution': {
            'Slow Learner': int(np.sum(y==0)),
            'Average Learner': int(np.sum(y==1)),
            'Fast Learner': int(np.sum(y==2))
        },
        'model_explanations': {
            'Linear Regression': 'Predicts a linear relationship between features and performance. Simple, fast, and interpretable but may miss complex patterns.',
            'Random Forest': 'Uses multiple decision trees to make predictions. Handles complex patterns well and is robust to outliers. Generally more accurate than Linear Regression.',
            'Support Vector Machine': 'Finds the best boundary between classes. Works well with small datasets and high-dimensional data. Requires feature scaling.'
        },
        'why_chosen': f'{best_model_name} achieved the highest R² score of {best_model[1]["r2_score"]:.4f} on {institution_label.lower()} student data, meaning it best explains the variance in {institution_label.lower()} performance patterns.'
    }
    
    return comparison_data

def save_both_comparisons():
    """Generate and save comparisons for both school and college"""
    results = {}
    
    # School comparison
    print("\n" + "🏫 "*20)
    school_data = compare_models('school')
    if school_data:
        results['school'] = school_data
    
    # College comparison
    print("\n" + "🎓 "*20)
    college_data = compare_models('college')
    if college_data:
        results['college'] = college_data
    
    if results:
        # Save combined results
        save_path = os.path.join(os.path.dirname(__file__), 'model_comparison_results.json')
        with open(save_path, 'w') as f:
            json.dump(results, f, indent=4)
        
        print(f"\n✅ Results saved to: model_comparison_results.json")
        print(f"   School records: {results.get('school', {}).get('dataset_size', 0)}")
        print(f"   College records: {results.get('college', {}).get('dataset_size', 0)}")
    
    return results

if __name__ == "__main__":
    save_both_comparisons()