
import mysql.connector

try:
    db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="ashfaq123@2005",
        database="student_performance_db"
    )
    cursor = db.cursor()
    cursor.execute("DESCRIBE student_performance")
    columns = cursor.fetchall()
    print("Columns in student_performance:")
    for col in columns:
        print(col)
        
except Exception as e:
    print(e)
