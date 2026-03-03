-- Insert sample students to match the student IDs used in the form
USE student_performance_db;

-- Insert more sample students (these IDs are commonly used in forms)
INSERT INTO students (student_id, admission_number, first_name, last_name, class_grade) VALUES 
(1, 'STU001', 'Alice', 'Johnson', '10A'),
(2, 'STU002', 'Bob', 'Smith', '10B'),
(3, 'STU003', 'Charlie', 'Brown', '11A'),
(4, 'STU004', 'Diana', 'Prince', '11B'),
(5, 'STU005', 'Edward', 'Norton', '12A'),
(6, 'STU006', 'Fiona', 'Apple', '12B'),
(7, 'STU007', 'George', 'Lucas', '9A'),
(8, 'STU008', 'Helen', 'Hunt', '9B'),
(9, 'STU009', 'Ian', 'McKellen', '10C'),
(10, 'STU010', 'Julia', 'Roberts', '11C')
ON DUPLICATE KEY UPDATE 
admission_number = VALUES(admission_number),
first_name = VALUES(first_name),
last_name = VALUES(last_name),
class_grade = VALUES(class_grade);

SELECT 'Sample students added successfully!' as message;
