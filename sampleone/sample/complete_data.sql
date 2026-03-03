-- ========================================
-- SCHOOL DATA INSERTION SCRIPT
-- 45 Students (SCH001-SCH045)
-- 180 Performance Records (4 per student)
-- ========================================

-- Step 1: Insert 45 School Students
-- ========================================

-- CLASS 8 (9 students)
INSERT INTO students (student_id, first_name, last_name, class_grade, institution_type) VALUES
('SCH001', 'Ravi', 'Kumar', '8', 'school'),
('SCH002', 'Priya', 'Sharma', '8', 'school'),
('SCH003', 'Amit', 'Patel', '8', 'school'),
('SCH004', 'Anjali', 'Singh', '8', 'school'),
('SCH005', 'Vikram', 'Reddy', '8', 'school'),
('SCH006', 'Sneha', 'Gupta', '8', 'school'),
('SCH007', 'Arjun', 'Nair', '8', 'school'),
('SCH008', 'Divya', 'Iyer', '8', 'school'),
('SCH009', 'Karthik', 'Rao', '8', 'school');

-- CLASS 9 (9 students)
INSERT INTO students (student_id, first_name, last_name, class_grade, institution_type) VALUES
('SCH010', 'Meera', 'Joshi', '9', 'school'),
('SCH011', 'Rahul', 'Verma', '9', 'school'),
('SCH012', 'Pooja', 'Menon', '9', 'school'),
('SCH013', 'Suresh', 'Pillai', '9', 'school'),
('SCH014', 'Kavya', 'Das', '9', 'school'),
('SCH015', 'Arun', 'Shetty', '9', 'school'),
('SCH016', 'Lakshmi', 'Bhat', '9', 'school'),
('SCH017', 'Nikhil', 'Desai', '9', 'school'),
('SCH018', 'Swati', 'Malhotra', '9', 'school');

-- CLASS 10 (9 students)
INSERT INTO students (student_id, first_name, last_name, class_grade, institution_type) VALUES
('SCH019', 'Vivek', 'Agarwal', '10', 'school'),
('SCH020', 'Nisha', 'Kapoor', '10', 'school'),
('SCH021', 'Deepak', 'Jain', '10', 'school'),
('SCH022', 'Shalini', 'Chopra', '10', 'school'),
('SCH023', 'Manoj', 'Bansal', '10', 'school'),
('SCH024', 'Rina', 'Saxena', '10', 'school'),
('SCH025', 'Sandeep', 'Mehta', '10', 'school'),
('SCH026', 'Anita', 'Dutta', '10', 'school'),
('SCH027', 'Rajesh', 'Pandey', '10', 'school');

-- CLASS 11 (9 students)
INSERT INTO students (student_id, first_name, last_name, class_grade, institution_type) VALUES
('SCH028', 'Rohit', 'Mishra', '11', 'school'),
('SCH029', 'Tanvi', 'Kulkarni', '11', 'school'),
('SCH030', 'Sanjay', 'Thakur', '11', 'school'),
('SCH031', 'Vaishali', 'Yadav', '11', 'school'),
('SCH032', 'Prakash', 'Rathi', '11', 'school'),
('SCH033', 'Manisha', 'Goyal', '11', 'school'),
('SCH034', 'Ashok', 'Chauhan', '11', 'school'),
('SCH035', 'Preeti', 'Bhatt', '11', 'school'),
('SCH036', 'Naveen', 'Srivastava', '11', 'school');

-- CLASS 12 (9 students)
INSERT INTO students (student_id, first_name, last_name, class_grade, institution_type) VALUES
('SCH037', 'Gaurav', 'Tiwari', '12', 'school'),
('SCH038', 'Seema', 'Nambiar', '12', 'school'),
('SCH039', 'Vijay', 'Kohli', '12', 'school'),
('SCH040', 'Rekha', 'Hegde', '12', 'school'),
('SCH041', 'Aditya', 'Bose', '12', 'school'),
('SCH042', 'Shweta', 'Pawar', '12', 'school'),
('SCH043', 'Harsh', 'Trivedi', '12', 'school'),
('SCH044', 'Pallavi', 'Kaul', '12', 'school'),
('SCH045', 'Sameer', 'Ghosh', '12', 'school');

-- ========================================
-- Step 2: Insert Performance Records (4 per student)
-- ========================================

-- CLASS 8 - SLOW LEARNERS (SCH001-SCH003)
INSERT INTO student_performance (student_id, marks, attendance_percentage, institution_type, created_at) VALUES
-- SCH001 (Slow Learner)
('SCH001', 35, 50, 'school', '2026-01-15'),
('SCH001', 38, 52, 'school', '2026-02-15'),
('SCH001', 40, 55, 'school', '2026-03-15'),
('SCH001', 42, 58, 'school', '2026-04-15'),
-- SCH002 (Slow Learner)
('SCH002', 32, 48, 'school', '2026-01-15'),
('SCH002', 35, 50, 'school', '2026-02-15'),
('SCH002', 37, 53, 'school', '2026-03-15'),
('SCH002', 39, 55, 'school', '2026-04-15'),
-- SCH003 (Slow Learner)
('SCH003', 38, 52, 'school', '2026-01-15'),
('SCH003', 40, 54, 'school', '2026-02-15'),
('SCH003', 42, 56, 'school', '2026-03-15'),
('SCH003', 45, 60, 'school', '2026-04-15');

-- CLASS 8 - AVERAGE LEARNERS (SCH004-SCH006)
INSERT INTO student_performance (student_id, marks, attendance_percentage, institution_type, created_at) VALUES
-- SCH004 (Average Learner)
('SCH004', 60, 70, 'school', '2026-01-15'),
('SCH004', 63, 72, 'school', '2026-02-15'),
('SCH004', 65, 75, 'school', '2026-03-15'),
('SCH004', 68, 78, 'school', '2026-04-15'),
-- SCH005 (Average Learner)
('SCH005', 58, 68, 'school', '2026-01-15'),
('SCH005', 61, 70, 'school', '2026-02-15'),
('SCH005', 63, 73, 'school', '2026-03-15'),
('SCH005', 66, 75, 'school', '2026-04-15'),
-- SCH006 (Average Learner)
('SCH006', 62, 72, 'school', '2026-01-15'),
('SCH006', 65, 74, 'school', '2026-02-15'),
('SCH006', 67, 77, 'school', '2026-03-15'),
('SCH006', 70, 80, 'school', '2026-04-15');

-- CLASS 8 - FAST LEARNERS (SCH007-SCH009)
INSERT INTO student_performance (student_id, marks, attendance_percentage, institution_type, created_at) VALUES
-- SCH007 (Fast Learner)
('SCH007', 80, 85, 'school', '2026-01-15'),
('SCH007', 84, 88, 'school', '2026-02-15'),
('SCH007', 87, 92, 'school', '2026-03-15'),
('SCH007', 90, 95, 'school', '2026-04-15'),
-- SCH008 (Fast Learner)
('SCH008', 78, 83, 'school', '2026-01-15'),
('SCH008', 82, 86, 'school', '2026-02-15'),
('SCH008', 85, 89, 'school', '2026-03-15'),
('SCH008', 88, 92, 'school', '2026-04-15'),
-- SCH009 (Fast Learner)
('SCH009', 82, 87, 'school', '2026-01-15'),
('SCH009', 85, 90, 'school', '2026-02-15'),
('SCH009', 88, 93, 'school', '2026-03-15'),
('SCH009', 91, 96, 'school', '2026-04-15');

-- CLASS 9 - SLOW LEARNERS (SCH010-SCH012)
INSERT INTO student_performance (student_id, marks, attendance_percentage, institution_type, created_at) VALUES
-- SCH010 (Slow Learner)
('SCH010', 36, 51, 'school', '2026-01-15'),
('SCH010', 39, 53, 'school', '2026-02-15'),
('SCH010', 41, 56, 'school', '2026-03-15'),
('SCH010', 43, 59, 'school', '2026-04-15'),
-- SCH011 (Slow Learner)
('SCH011', 34, 49, 'school', '2026-01-15'),
('SCH011', 37, 51, 'school', '2026-02-15'),
('SCH011', 39, 54, 'school', '2026-03-15'),
('SCH011', 41, 57, 'school', '2026-04-15'),
-- SCH012 (Slow Learner)
('SCH012', 40, 54, 'school', '2026-01-15'),
('SCH012', 42, 56, 'school', '2026-02-15'),
('SCH012', 44, 58, 'school', '2026-03-15'),
('SCH012', 47, 62, 'school', '2026-04-15');

-- CLASS 9 - AVERAGE LEARNERS (SCH013-SCH015)
INSERT INTO student_performance (student_id, marks, attendance_percentage, institution_type, created_at) VALUES
-- SCH013 (Average Learner)
('SCH013', 61, 71, 'school', '2026-01-15'),
('SCH013', 64, 73, 'school', '2026-02-15'),
('SCH013', 66, 76, 'school', '2026-03-15'),
('SCH013', 69, 79, 'school', '2026-04-15'),
-- SCH014 (Average Learner)
('SCH014', 59, 69, 'school', '2026-01-15'),
('SCH014', 62, 71, 'school', '2026-02-15'),
('SCH014', 64, 74, 'school', '2026-03-15'),
('SCH014', 67, 77, 'school', '2026-04-15'),
-- SCH015 (Average Learner)
('SCH015', 63, 73, 'school', '2026-01-15'),
('SCH015', 66, 75, 'school', '2026-02-15'),
('SCH015', 68, 78, 'school', '2026-03-15'),
('SCH015', 71, 81, 'school', '2026-04-15');

-- CLASS 9 - FAST LEARNERS (SCH016-SCH018)
INSERT INTO student_performance (student_id, marks, attendance_percentage, institution_type, created_at) VALUES
-- SCH016 (Fast Learner)
('SCH016', 81, 86, 'school', '2026-01-15'),
('SCH016', 85, 89, 'school', '2026-02-15'),
('SCH016', 88, 93, 'school', '2026-03-15'),
('SCH016', 91, 96, 'school', '2026-04-15'),
-- SCH017 (Fast Learner)
('SCH017', 79, 84, 'school', '2026-01-15'),
('SCH017', 83, 87, 'school', '2026-02-15'),
('SCH017', 86, 90, 'school', '2026-03-15'),
('SCH017', 89, 93, 'school', '2026-04-15'),
-- SCH018 (Fast Learner)
('SCH018', 83, 88, 'school', '2026-01-15'),
('SCH018', 86, 91, 'school', '2026-02-15'),
('SCH018', 89, 94, 'school', '2026-03-15'),
('SCH018', 92, 97, 'school', '2026-04-15');

-- CLASS 10 - SLOW LEARNERS (SCH019-SCH021)
INSERT INTO student_performance (student_id, marks, attendance_percentage, institution_type, created_at) VALUES
-- SCH019 (Slow Learner)
('SCH019', 37, 52, 'school', '2026-01-15'),
('SCH019', 40, 54, 'school', '2026-02-15'),
('SCH019', 42, 57, 'school', '2026-03-15'),
('SCH019', 44, 60, 'school', '2026-04-15'),
-- SCH020 (Slow Learner)
('SCH020', 33, 50, 'school', '2026-01-15'),
('SCH020', 36, 52, 'school', '2026-02-15'),
('SCH020', 38, 55, 'school', '2026-03-15'),
('SCH020', 40, 58, 'school', '2026-04-15'),
-- SCH021 (Slow Learner)
('SCH021', 39, 53, 'school', '2026-01-15'),
('SCH021', 41, 55, 'school', '2026-02-15'),
('SCH021', 43, 57, 'school', '2026-03-15'),
('SCH021', 46, 61, 'school', '2026-04-15');

-- CLASS 10 - AVERAGE LEARNERS (SCH022-SCH024)
INSERT INTO student_performance (student_id, marks, attendance_percentage, institution_type, created_at) VALUES
-- SCH022 (Average Learner)
('SCH022', 62, 72, 'school', '2026-01-15'),
('SCH022', 65, 74, 'school', '2026-02-15'),
('SCH022', 67, 77, 'school', '2026-03-15'),
('SCH022', 70, 80, 'school', '2026-04-15'),
-- SCH023 (Average Learner)
('SCH023', 60, 70, 'school', '2026-01-15'),
('SCH023', 63, 72, 'school', '2026-02-15'),
('SCH023', 65, 75, 'school', '2026-03-15'),
('SCH023', 68, 78, 'school', '2026-04-15'),
-- SCH024 (Average Learner)
('SCH024', 64, 74, 'school', '2026-01-15'),
('SCH024', 67, 76, 'school', '2026-02-15'),
('SCH024', 69, 79, 'school', '2026-03-15'),
('SCH024', 72, 82, 'school', '2026-04-15');

-- CLASS 10 - FAST LEARNERS (SCH025-SCH027)
INSERT INTO student_performance (student_id, marks, attendance_percentage, institution_type, created_at) VALUES
-- SCH025 (Fast Learner)
('SCH025', 82, 87, 'school', '2026-01-15'),
('SCH025', 86, 90, 'school', '2026-02-15'),
('SCH025', 89, 94, 'school', '2026-03-15'),
('SCH025', 92, 97, 'school', '2026-04-15'),
-- SCH026 (Fast Learner)
('SCH026', 80, 85, 'school', '2026-01-15'),
('SCH026', 84, 88, 'school', '2026-02-15'),
('SCH026', 87, 91, 'school', '2026-03-15'),
('SCH026', 90, 94, 'school', '2026-04-15'),
-- SCH027 (Fast Learner)
('SCH027', 84, 89, 'school', '2026-01-15'),
('SCH027', 87, 92, 'school', '2026-02-15'),
('SCH027', 90, 95, 'school', '2026-03-15'),
('SCH027', 93, 97, 'school', '2026-04-15');

-- CLASS 11 - SLOW LEARNERS (SCH028-SCH030)
INSERT INTO student_performance (student_id, marks, attendance_percentage, institution_type, created_at) VALUES
-- SCH028 (Slow Learner)
('SCH028', 38, 53, 'school', '2026-01-15'),
('SCH028', 41, 55, 'school', '2026-02-15'),
('SCH028', 43, 58, 'school', '2026-03-15'),
('SCH028', 45, 61, 'school', '2026-04-15'),
-- SCH029 (Slow Learner)
('SCH029', 35, 51, 'school', '2026-01-15'),
('SCH029', 38, 53, 'school', '2026-02-15'),
('SCH029', 40, 56, 'school', '2026-03-15'),
('SCH029', 42, 59, 'school', '2026-04-15'),
-- SCH030 (Slow Learner)
('SCH030', 40, 54, 'school', '2026-01-15'),
('SCH030', 42, 56, 'school', '2026-02-15'),
('SCH030', 44, 58, 'school', '2026-03-15'),
('SCH030', 47, 62, 'school', '2026-04-15');

-- CLASS 11 - AVERAGE LEARNERS (SCH031-SCH033)
INSERT INTO student_performance (student_id, marks, attendance_percentage, institution_type, created_at) VALUES
-- SCH031 (Average Learner)
('SCH031', 63, 73, 'school', '2026-01-15'),
('SCH031', 66, 75, 'school', '2026-02-15'),
('SCH031', 68, 78, 'school', '2026-03-15'),
('SCH031', 71, 81, 'school', '2026-04-15'),
-- SCH032 (Average Learner)
('SCH032', 61, 71, 'school', '2026-01-15'),
('SCH032', 64, 73, 'school', '2026-02-15'),
('SCH032', 66, 76, 'school', '2026-03-15'),
('SCH032', 69, 79, 'school', '2026-04-15'),
-- SCH033 (Average Learner)
('SCH033', 65, 75, 'school', '2026-01-15'),
('SCH033', 68, 77, 'school', '2026-02-15'),
('SCH033', 70, 80, 'school', '2026-03-15'),
('SCH033', 73, 83, 'school', '2026-04-15');

-- CLASS 11 - FAST LEARNERS (SCH034-SCH036)
INSERT INTO student_performance (student_id, marks, attendance_percentage, institution_type, created_at) VALUES
-- SCH034 (Fast Learner)
('SCH034', 83, 88, 'school', '2026-01-15'),
('SCH034', 87, 91, 'school', '2026-02-15'),
('SCH034', 90, 95, 'school', '2026-03-15'),
('SCH034', 93, 97, 'school', '2026-04-15'),
-- SCH035 (Fast Learner)
('SCH035', 81, 86, 'school', '2026-01-15'),
('SCH035', 85, 89, 'school', '2026-02-15'),
('SCH035', 88, 92, 'school', '2026-03-15'),
('SCH035', 91, 95, 'school', '2026-04-15'),
-- SCH036 (Fast Learner)
('SCH036', 85, 90, 'school', '2026-01-15'),
('SCH036', 88, 93, 'school', '2026-02-15'),
('SCH036', 91, 96, 'school', '2026-03-15'),
('SCH036', 94, 97, 'school', '2026-04-15');

-- CLASS 12 - SLOW LEARNERS (SCH037-SCH039)
INSERT INTO student_performance (student_id, marks, attendance_percentage, institution_type, created_at) VALUES
-- SCH037 (Slow Learner)
('SCH037', 39, 54, 'school', '2026-01-15'),
('SCH037', 42, 56, 'school', '2026-02-15'),
('SCH037', 44, 59, 'school', '2026-03-15'),
('SCH037', 46, 62, 'school', '2026-04-15'),
-- SCH038 (Slow Learner)
('SCH038', 36, 52, 'school', '2026-01-15'),
('SCH038', 39, 54, 'school', '2026-02-15'),
('SCH038', 41, 57, 'school', '2026-03-15'),
('SCH038', 43, 60, 'school', '2026-04-15'),
-- SCH039 (Slow Learner)
('SCH039', 41, 55, 'school', '2026-01-15'),
('SCH039', 43, 57, 'school', '2026-02-15'),
('SCH039', 45, 59, 'school', '2026-03-15'),
('SCH039', 48, 63, 'school', '2026-04-15');

-- CLASS 12 - AVERAGE LEARNERS (SCH040-SCH042)
INSERT INTO student_performance (student_id, marks, attendance_percentage, institution_type, created_at) VALUES
-- SCH040 (Average Learner)
('SCH040', 64, 74, 'school', '2026-01-15'),
('SCH040', 67, 76, 'school', '2026-02-15'),
('SCH040', 69, 79, 'school', '2026-03-15'),
('SCH040', 72, 82, 'school', '2026-04-15'),
-- SCH041 (Average Learner)
('SCH041', 62, 72, 'school', '2026-01-15'),
('SCH041', 65, 74, 'school', '2026-02-15'),
('SCH041', 67, 77, 'school', '2026-03-15'),
('SCH041', 70, 80, 'school', '2026-04-15'),
-- SCH042 (Average Learner)
('SCH042', 66, 76, 'school', '2026-01-15'),
('SCH042', 69, 78, 'school', '2026-02-15'),
('SCH042', 71, 81, 'school', '2026-03-15'),
('SCH042', 74, 84, 'school', '2026-04-15');

-- CLASS 12 - FAST LEARNERS (SCH043-SCH045)
INSERT INTO student_performance (student_id, marks, attendance_percentage, institution_type, created_at) VALUES
-- SCH043 (Fast Learner)
('SCH043', 84, 89, 'school', '2026-01-15'),
('SCH043', 88, 92, 'school', '2026-02-15'),
('SCH043', 91, 96, 'school', '2026-03-15'),
('SCH043', 94, 97, 'school', '2026-04-15'),
-- SCH044 (Fast Learner)
('SCH044', 82, 87, 'school', '2026-01-15'),
('SCH044', 86, 90, 'school', '2026-02-15'),
('SCH044', 89, 93, 'school', '2026-03-15'),
('SCH044', 92, 96, 'school', '2026-04-15'),
-- SCH045 (Fast Learner)
('SCH045', 86, 91, 'school', '2026-01-15'),
('SCH045', 89, 94, 'school', '2026-02-15'),
('SCH045', 92, 97, 'school', '2026-03-15'),
('SCH045', 94, 97, 'school', '2026-04-15');
-- ========================================
-- COLLEGE DATA INSERTION SCRIPT
-- 72 Students (COL001-COL072)
-- 288 Performance Records (4 per student)
-- ========================================

-- Step 3: Insert 72 College Students
-- ========================================

-- SEMESTER 1 (9 students)
INSERT INTO students (student_id, first_name, last_name, semester, institution_type) VALUES
('COL001', 'Aditi', 'Krishnan', '1', 'college'),
('COL002', 'Rohan', 'Fernandes', '1', 'college'),
('COL003', 'Ishita', 'Bhargava', '1', 'college'),
('COL004', 'Akash', 'Saini', '1', 'college'),
('COL005', 'Nidhi', 'Arora', '1', 'college'),
('COL006', 'Varun', 'Mathur', '1', 'college'),
('COL007', 'Shreya', 'Venkatesh', '1', 'college'),
('COL008', 'Karan', 'Raghavan', '1', 'college'),
('COL009', 'Ritu', 'Chawla', '1', 'college');

-- SEMESTER 2 (9 students)
INSERT INTO students (student_id, first_name, last_name, semester, institution_type) VALUES
('COL010', 'Abhishek', 'Ranganathan', '2', 'college'),
('COL011', 'Megha', 'Srinivasan', '2', 'college'),
('COL012', 'Deepika', 'Sundaram', '2', 'college'),
('COL013', 'Aryan', 'Khanna', '2', 'college'),
('COL014', 'Simran', 'Bakshi', '2', 'college'),
('COL015', 'Sidharth', 'Ghai', '2', 'college'),
('COL016', 'Priyanka', 'Subramaniam', '2', 'college'),
('COL017', 'Yash', 'Narayanan', '2', 'college'),
('COL018', 'Neha', 'Balakrishnan', '2', 'college');

-- SEMESTER 3 (9 students)
INSERT INTO students (student_id, first_name, last_name, semester, institution_type) VALUES
('COL019', 'Vishal', 'Ramakrishnan', '3', 'college'),
('COL020', 'Kritika', 'Mohan', '3', 'college'),
('COL021', 'Ashish', 'Subramanian', '3', 'college'),
('COL022', 'Ayesha', 'Khan', '3', 'college'),
('COL023', 'Anirudh', 'Natarajan', '3', 'college'),
('COL024', 'Tanya', 'Devanathan', '3', 'college'),
('COL025', 'Aakash', 'Venkataraman', '3', 'college'),
('COL026', 'Sakshi', 'Ramesh', '3', 'college'),
('COL027', 'Parth', 'Krishnamurthy', '3', 'college');

-- SEMESTER 4 (9 students)
INSERT INTO students (student_id, first_name, last_name, semester, institution_type) VALUES
('COL028', 'Isha', 'Parthasarathy', '4', 'college'),
('COL029', 'Siddharth', 'Gopalakrishnan', '4', 'college'),
('COL030', 'Ananya', 'Chandrasekhar', '4', 'college'),
('COL031', 'Aman', 'Swaminathan', '4', 'college'),
('COL032', 'Ritika', 'Ganesh', '4', 'college'),
('COL033', 'Kartik', 'Thyagarajan', '4', 'college'),
('COL034', 'Diya', 'Ramamurthy', '4', 'college'),
('COL035', 'Arjun', 'Vasudevan', '4', 'college'),
('COL036', 'Sanya', 'Balasubramanian', '4', 'college');

-- SEMESTER 5 (9 students)
INSERT INTO students (student_id, first_name, last_name, semester, institution_type) VALUES
('COL037', 'Raghav', 'Lakshman', '5', 'college'),
('COL038', 'Kavita', 'Seshadri', '5', 'college'),
('COL039', 'Nitin', 'Anand', '5', 'college'),
('COL040', 'Aishwarya', 'Vaidyanathan', '5', 'college'),
('COL041', 'Manav', 'Shankar', '5', 'college'),
('COL042', 'Riya', 'Iyer', '5', 'college'),
('COL043', 'Shubham', 'Narasimhan', '5', 'college'),
('COL044', 'Poornima', 'Raghavan', '5', 'college'),
('COL045', 'Aditya', 'Murali', '5', 'college');

-- SEMESTER 6 (9 students)
INSERT INTO students (student_id, first_name, last_name, semester, institution_type) VALUES
('COL046', 'Tanushree', 'Sridhar', '6', 'college'),
('COL047', 'Pranav', 'Padmanabhan', '6', 'college'),
('COL048', 'Shalini', 'Venkat', '6', 'college'),
('COL049', 'Devika', 'Krishnan', '6', 'college'),
('COL050', 'Mohit', 'Sundaresan', '6', 'college'),
('COL051', 'Shruti', 'Hariharan', '6', 'college'),
('COL052', 'Tushar', 'Gopalan', '6', 'college'),
('COL053', 'Anushka', 'Shanmugam', '6', 'college'),
('COL054', 'Mayank', 'Rangarajan', '6', 'college');

-- SEMESTER 7 (9 students)
INSERT INTO students (student_id, first_name, last_name, semester, institution_type) VALUES
('COL055', 'Lakshmi', 'Devan', '7', 'college'),
('COL056', 'Chirag', 'Subramani', '7', 'college'),
('COL057', 'Puja', 'Kannan', '7', 'college'),
('COL058', 'Arush', 'Ramaswamy', '7', 'college'),
('COL059', 'Kavya', 'Sathya', '7', 'college'),
('COL060', 'Arnav', 'Venkatesan', '7', 'college'),
('COL061', 'Meghna', 'Janardhan', '7', 'college'),
('COL062', 'Utkarsh', 'Bhaskar', '7', 'college'),
('COL063', 'Trisha', 'Nagarajan', '7', 'college');

-- SEMESTER 8 (9 students)
INSERT INTO students (student_id, first_name, last_name, semester, institution_type) VALUES
('COL064', 'Saurabh', 'Sivasubramaniam', '8', 'college'),
('COL065', 'Nikita', 'Ramachandran', '8', 'college'),
('COL066', 'Piyush', 'Govindarajan', '8', 'college'),
('COL067', 'Anushree', 'Parthasarathy', '8', 'college'),
('COL068', 'Shaurya', 'Sekar', '8', 'college'),
('COL069', 'Rhea', 'Anantharaman', '8', 'college'),
('COL070', 'Dhruv', 'Mahadevan', '8', 'college'),
('COL071', 'Aanya', 'Varadhan', '8', 'college'),
('COL072', 'Advait', 'Bharath', '8', 'college');

-- ========================================
-- Step 4: Insert College Performance Records (4 per student)
-- ========================================

-- SEMESTER 1 - SLOW LEARNERS (COL001-COL003)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL001 (Slow Learner)
('COL001', 4.5, 55, 'college', '2026-01-15'),
('COL001', 4.8, 57, 'college', '2026-02-15'),
('COL001', 5.0, 60, 'college', '2026-03-15'),
('COL001', 5.2, 63, 'college', '2026-04-15'),
-- COL002 (Slow Learner)
('COL002', 4.2, 52, 'college', '2026-01-15'),
('COL002', 4.5, 54, 'college', '2026-02-15'),
('COL002', 4.7, 57, 'college', '2026-03-15'),
('COL002', 5.0, 60, 'college', '2026-04-15'),
-- COL003 (Slow Learner)
('COL003', 4.8, 58, 'college', '2026-01-15'),
('COL003', 5.0, 60, 'college', '2026-02-15'),
('COL003', 5.2, 62, 'college', '2026-03-15'),
('COL003', 5.5, 65, 'college', '2026-04-15');

-- SEMESTER 1 - AVERAGE LEARNERS (COL004-COL006)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL004 (Average Learner)
('COL004', 6.5, 72, 'college', '2026-01-15'),
('COL004', 6.8, 74, 'college', '2026-02-15'),
('COL004', 7.0, 77, 'college', '2026-03-15'),
('COL004', 7.2, 80, 'college', '2026-04-15'),
-- COL005 (Average Learner)
('COL005', 6.2, 70, 'college', '2026-01-15'),
('COL005', 6.5, 72, 'college', '2026-02-15'),
('COL005', 6.7, 75, 'college', '2026-03-15'),
('COL005', 7.0, 78, 'college', '2026-04-15'),
-- COL006 (Average Learner)
('COL006', 6.8, 74, 'college', '2026-01-15'),
('COL006', 7.0, 76, 'college', '2026-02-15'),
('COL006', 7.2, 79, 'college', '2026-03-15'),
('COL006', 7.5, 82, 'college', '2026-04-15');

-- SEMESTER 1 - FAST LEARNERS (COL007-COL009)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL007 (Fast Learner)
('COL007', 8.5, 88, 'college', '2026-01-15'),
('COL007', 8.8, 90, 'college', '2026-02-15'),
('COL007', 9.0, 93, 'college', '2026-03-15'),
('COL007', 9.2, 95, 'college', '2026-04-15'),
-- COL008 (Fast Learner)
('COL008', 8.2, 85, 'college', '2026-01-15'),
('COL008', 8.5, 87, 'college', '2026-02-15'),
('COL008', 8.7, 90, 'college', '2026-03-15'),
('COL008', 9.0, 93, 'college', '2026-04-15'),
-- COL009 (Fast Learner)
('COL009', 8.8, 90, 'college', '2026-01-15'),
('COL009', 9.0, 92, 'college', '2026-02-15'),
('COL009', 9.2, 95, 'college', '2026-03-15'),
('COL009', 9.5, 97, 'college', '2026-04-15');

-- SEMESTER 2 - SLOW LEARNERS (COL010-COL012)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL010 (Slow Learner)
('COL010', 4.6, 56, 'college', '2026-01-15'),
('COL010', 4.9, 58, 'college', '2026-02-15'),
('COL010', 5.1, 61, 'college', '2026-03-15'),
('COL010', 5.3, 64, 'college', '2026-04-15'),
-- COL011 (Slow Learner)
('COL011', 4.3, 53, 'college', '2026-01-15'),
('COL011', 4.6, 55, 'college', '2026-02-15'),
('COL011', 4.8, 58, 'college', '2026-03-15'),
('COL011', 5.1, 61, 'college', '2026-04-15'),
-- COL012 (Slow Learner)
('COL012', 4.9, 59, 'college', '2026-01-15'),
('COL012', 5.1, 61, 'college', '2026-02-15'),
('COL012', 5.3, 63, 'college', '2026-03-15'),
('COL012', 5.6, 66, 'college', '2026-04-15');

-- SEMESTER 2 - AVERAGE LEARNERS (COL013-COL015)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL013 (Average Learner)
('COL013', 6.6, 73, 'college', '2026-01-15'),
('COL013', 6.9, 75, 'college', '2026-02-15'),
('COL013', 7.1, 78, 'college', '2026-03-15'),
('COL013', 7.3, 81, 'college', '2026-04-15'),
-- COL014 (Average Learner)
('COL014', 6.3, 71, 'college', '2026-01-15'),
('COL014', 6.6, 73, 'college', '2026-02-15'),
('COL014', 6.8, 76, 'college', '2026-03-15'),
('COL014', 7.1, 79, 'college', '2026-04-15'),
-- COL015 (Average Learner)
('COL015', 6.9, 75, 'college', '2026-01-15'),
('COL015', 7.1, 77, 'college', '2026-02-15'),
('COL015', 7.3, 80, 'college', '2026-03-15'),
('COL015', 7.6, 83, 'college', '2026-04-15');

-- SEMESTER 2 - FAST LEARNERS (COL016-COL018)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL016 (Fast Learner)
('COL016', 8.6, 89, 'college', '2026-01-15'),
('COL016', 8.9, 91, 'college', '2026-02-15'),
('COL016', 9.1, 94, 'college', '2026-03-15'),
('COL016', 9.3, 96, 'college', '2026-04-15'),
-- COL017 (Fast Learner)
('COL017', 8.3, 86, 'college', '2026-01-15'),
('COL017', 8.6, 88, 'college', '2026-02-15'),
('COL017', 8.8, 91, 'college', '2026-03-15'),
('COL017', 9.1, 94, 'college', '2026-04-15'),
-- COL018 (Fast Learner)
('COL018', 8.9, 91, 'college', '2026-01-15'),
('COL018', 9.1, 93, 'college', '2026-02-15'),
('COL018', 9.3, 96, 'college', '2026-03-15'),
('COL018', 9.5, 97, 'college', '2026-04-15');

-- SEMESTER 3 - SLOW LEARNERS (COL019-COL021)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL019 (Slow Learner)
('COL019', 4.7, 57, 'college', '2026-01-15'),
('COL019', 5.0, 59, 'college', '2026-02-15'),
('COL019', 5.2, 62, 'college', '2026-03-15'),
('COL019', 5.4, 65, 'college', '2026-04-15'),
-- COL020 (Slow Learner)
('COL020', 4.4, 54, 'college', '2026-01-15'),
('COL020', 4.7, 56, 'college', '2026-02-15'),
('COL020', 4.9, 59, 'college', '2026-03-15'),
('COL020', 5.2, 62, 'college', '2026-04-15'),
-- COL021 (Slow Learner)
('COL021', 5.0, 60, 'college', '2026-01-15'),
('COL021', 5.2, 62, 'college', '2026-02-15'),
('COL021', 5.4, 64, 'college', '2026-03-15'),
('COL021', 5.7, 67, 'college', '2026-04-15');

-- SEMESTER 3 - AVERAGE LEARNERS (COL022-COL024)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL022 (Average Learner)
('COL022', 6.7, 74, 'college', '2026-01-15'),
('COL022', 7.0, 76, 'college', '2026-02-15'),
('COL022', 7.2, 79, 'college', '2026-03-15'),
('COL022', 7.4, 82, 'college', '2026-04-15'),
-- COL023 (Average Learner)
('COL023', 6.4, 72, 'college', '2026-01-15'),
('COL023', 6.7, 74, 'college', '2026-02-15'),
('COL023', 6.9, 77, 'college', '2026-03-15'),
('COL023', 7.2, 80, 'college', '2026-04-15'),
-- COL024 (Average Learner)
('COL024', 7.0, 76, 'college', '2026-01-15'),
('COL024', 7.2, 78, 'college', '2026-02-15'),
('COL024', 7.4, 81, 'college', '2026-03-15'),
('COL024', 7.7, 84, 'college', '2026-04-15');

-- SEMESTER 3 - FAST LEARNERS (COL025-COL027)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL025 (Fast Learner)
('COL025', 8.7, 90, 'college', '2026-01-15'),
('COL025', 9.0, 92, 'college', '2026-02-15'),
('COL025', 9.2, 95, 'college', '2026-03-15'),
('COL025', 9.4, 97, 'college', '2026-04-15'),
-- COL026 (Fast Learner)
('COL026', 8.4, 87, 'college', '2026-01-15'),
('COL026', 8.7, 89, 'college', '2026-02-15'),
('COL026', 8.9, 92, 'college', '2026-03-15'),
('COL026', 9.2, 95, 'college', '2026-04-15'),
-- COL027 (Fast Learner)
('COL027', 9.0, 92, 'college', '2026-01-15'),
('COL027', 9.2, 94, 'college', '2026-02-15'),
('COL027', 9.4, 97, 'college', '2026-03-15'),
('COL027', 9.5, 97, 'college', '2026-04-15');

-- SEMESTER 4 - SLOW LEARNERS (COL028-COL030)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL028 (Slow Learner)
('COL028', 4.8, 58, 'college', '2026-01-15'),
('COL028', 5.1, 60, 'college', '2026-02-15'),
('COL028', 5.3, 63, 'college', '2026-03-15'),
('COL028', 5.5, 66, 'college', '2026-04-15'),
-- COL029 (Slow Learner)
('COL029', 4.5, 55, 'college', '2026-01-15'),
('COL029', 4.8, 57, 'college', '2026-02-15'),
('COL029', 5.0, 60, 'college', '2026-03-15'),
('COL029', 5.3, 63, 'college', '2026-04-15'),
-- COL030 (Slow Learner)
('COL030', 5.1, 61, 'college', '2026-01-15'),
('COL030', 5.3, 63, 'college', '2026-02-15'),
('COL030', 5.5, 65, 'college', '2026-03-15'),
('COL030', 5.8, 68, 'college', '2026-04-15');

-- SEMESTER 4 - AVERAGE LEARNERS (COL031-COL033)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL031 (Average Learner)
('COL031', 6.8, 75, 'college', '2026-01-15'),
('COL031', 7.1, 77, 'college', '2026-02-15'),
('COL031', 7.3, 80, 'college', '2026-03-15'),
('COL031', 7.5, 83, 'college', '2026-04-15'),
-- COL032 (Average Learner)
('COL032', 6.5, 73, 'college', '2026-01-15'),
('COL032', 6.8, 75, 'college', '2026-02-15'),
('COL032', 7.0, 78, 'college', '2026-03-15'),
('COL032', 7.3, 81, 'college', '2026-04-15'),
-- COL033 (Average Learner)
('COL033', 7.1, 77, 'college', '2026-01-15'),
('COL033', 7.3, 79, 'college', '2026-02-15'),
('COL033', 7.5, 82, 'college', '2026-03-15'),
('COL033', 7.8, 85, 'college', '2026-04-15');

-- SEMESTER 4 - FAST LEARNERS (COL034-COL036)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL034 (Fast Learner)
('COL034', 8.8, 91, 'college', '2026-01-15'),
('COL034', 9.1, 93, 'college', '2026-02-15'),
('COL034', 9.3, 96, 'college', '2026-03-15'),
('COL034', 9.5, 97, 'college', '2026-04-15'),
-- COL035 (Fast Learner)
('COL035', 8.5, 88, 'college', '2026-01-15'),
('COL035', 8.8, 90, 'college', '2026-02-15'),
('COL035', 9.0, 93, 'college', '2026-03-15'),
('COL035', 9.3, 96, 'college', '2026-04-15'),
-- COL036 (Fast Learner)
('COL036', 9.1, 93, 'college', '2026-01-15'),
('COL036', 9.3, 95, 'college', '2026-02-15'),
('COL036', 9.5, 97, 'college', '2026-03-15'),
('COL036', 9.5, 97, 'college', '2026-04-15');

-- SEMESTER 5 - SLOW LEARNERS (COL037-COL039)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL037 (Slow Learner)
('COL037', 4.9, 59, 'college', '2026-01-15'),
('COL037', 5.2, 61, 'college', '2026-02-15'),
('COL037', 5.4, 64, 'college', '2026-03-15'),
('COL037', 5.6, 67, 'college', '2026-04-15'),
-- COL038 (Slow Learner)
('COL038', 4.6, 56, 'college', '2026-01-15'),
('COL038', 4.9, 58, 'college', '2026-02-15'),
('COL038', 5.1, 61, 'college', '2026-03-15'),
('COL038', 5.4, 64, 'college', '2026-04-15'),
-- COL039 (Slow Learner)
('COL039', 5.2, 62, 'college', '2026-01-15'),
('COL039', 5.4, 64, 'college', '2026-02-15'),
('COL039', 5.6, 66, 'college', '2026-03-15'),
('COL039', 5.9, 69, 'college', '2026-04-15');

-- SEMESTER 5 - AVERAGE LEARNERS (COL040-COL042)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL040 (Average Learner)
('COL040', 6.9, 76, 'college', '2026-01-15'),
('COL040', 7.2, 78, 'college', '2026-02-15'),
('COL040', 7.4, 81, 'college', '2026-03-15'),
('COL040', 7.6, 84, 'college', '2026-04-15'),
-- COL041 (Average Learner)
('COL041', 6.6, 74, 'college', '2026-01-15'),
('COL041', 6.9, 76, 'college', '2026-02-15'),
('COL041', 7.1, 79, 'college', '2026-03-15'),
('COL041', 7.4, 82, 'college', '2026-04-15'),
-- COL042 (Average Learner)
('COL042', 7.2, 78, 'college', '2026-01-15'),
('COL042', 7.4, 80, 'college', '2026-02-15'),
('COL042', 7.6, 83, 'college', '2026-03-15'),
('COL042', 7.9, 86, 'college', '2026-04-15');

-- SEMESTER 5 - FAST LEARNERS (COL043-COL045)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL043 (Fast Learner)
('COL043', 8.9, 92, 'college', '2026-01-15'),
('COL043', 9.2, 94, 'college', '2026-02-15'),
('COL043', 9.4, 97, 'college', '2026-03-15'),
('COL043', 9.5, 97, 'college', '2026-04-15'),
-- COL044 (Fast Learner)
('COL044', 8.6, 89, 'college', '2026-01-15'),
('COL044', 8.9, 91, 'college', '2026-02-15'),
('COL044', 9.1, 94, 'college', '2026-03-15'),
('COL044', 9.4, 97, 'college', '2026-04-15'),
-- COL045 (Fast Learner)
('COL045', 9.2, 94, 'college', '2026-01-15'),
('COL045', 9.4, 96, 'college', '2026-02-15'),
('COL045', 9.5, 97, 'college', '2026-03-15'),
('COL045', 9.5, 97, 'college', '2026-04-15');

-- SEMESTER 6 - SLOW LEARNERS (COL046-COL048)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL046 (Slow Learner)
('COL046', 5.0, 60, 'college', '2026-01-15'),
('COL046', 5.3, 62, 'college', '2026-02-15'),
('COL046', 5.5, 65, 'college', '2026-03-15'),
('COL046', 5.7, 68, 'college', '2026-04-15'),
-- COL047 (Slow Learner)
('COL047', 4.7, 57, 'college', '2026-01-15'),
('COL047', 5.0, 59, 'college', '2026-02-15'),
('COL047', 5.2, 62, 'college', '2026-03-15'),
('COL047', 5.5, 65, 'college', '2026-04-15'),
-- COL048 (Slow Learner)
('COL048', 5.3, 63, 'college', '2026-01-15'),
('COL048', 5.5, 65, 'college', '2026-02-15'),
('COL048', 5.7, 67, 'college', '2026-03-15'),
('COL048', 6.0, 70, 'college', '2026-04-15');

-- SEMESTER 6 - AVERAGE LEARNERS (COL049-COL051)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL049 (Average Learner)
('COL049', 7.0, 77, 'college', '2026-01-15'),
('COL049', 7.3, 79, 'college', '2026-02-15'),
('COL049', 7.5, 82, 'college', '2026-03-15'),
('COL049', 7.7, 85, 'college', '2026-04-15'),
-- COL050 (Average Learner)
('COL050', 6.7, 75, 'college', '2026-01-15'),
('COL050', 7.0, 77, 'college', '2026-02-15'),
('COL050', 7.2, 80, 'college', '2026-03-15'),
('COL050', 7.5, 83, 'college', '2026-04-15'),
-- COL051 (Average Learner)
('COL051', 7.3, 79, 'college', '2026-01-15'),
('COL051', 7.5, 81, 'college', '2026-02-15'),
('COL051', 7.7, 84, 'college', '2026-03-15'),
('COL051', 8.0, 87, 'college', '2026-04-15');

-- SEMESTER 6 - FAST LEARNERS (COL052-COL054)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL052 (Fast Learner)
('COL052', 9.0, 93, 'college', '2026-01-15'),
('COL052', 9.3, 95, 'college', '2026-02-15'),
('COL052', 9.5, 97, 'college', '2026-03-15'),
('COL052', 9.5, 97, 'college', '2026-04-15'),
-- COL053 (Fast Learner)
('COL053', 8.7, 90, 'college', '2026-01-15'),
('COL053', 9.0, 92, 'college', '2026-02-15'),
('COL053', 9.2, 95, 'college', '2026-03-15'),
('COL053', 9.5, 97, 'college', '2026-04-15'),
-- COL054 (Fast Learner)
('COL054', 9.3, 95, 'college', '2026-01-15'),
('COL054', 9.5, 97, 'college', '2026-02-15'),
('COL054', 9.5, 97, 'college', '2026-03-15'),
('COL054', 9.5, 97, 'college', '2026-04-15');

-- SEMESTER 7 - SLOW LEARNERS (COL055-COL057)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL055 (Slow Learner)
('COL055', 5.1, 61, 'college', '2026-01-15'),
('COL055', 5.4, 63, 'college', '2026-02-15'),
('COL055', 5.6, 66, 'college', '2026-03-15'),
('COL055', 5.8, 69, 'college', '2026-04-15'),
-- COL056 (Slow Learner)
('COL056', 4.8, 58, 'college', '2026-01-15'),
('COL056', 5.1, 60, 'college', '2026-02-15'),
('COL056', 5.3, 63, 'college', '2026-03-15'),
('COL056', 5.6, 66, 'college', '2026-04-15'),
-- COL057 (Slow Learner)
('COL057', 5.4, 64, 'college', '2026-01-15'),
('COL057', 5.6, 66, 'college', '2026-02-15'),
('COL057', 5.8, 68, 'college', '2026-03-15'),
('COL057', 6.1, 71, 'college', '2026-04-15');

-- SEMESTER 7 - AVERAGE LEARNERS (COL058-COL060)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL058 (Average Learner)
('COL058', 7.1, 78, 'college', '2026-01-15'),
('COL058', 7.4, 80, 'college', '2026-02-15'),
('COL058', 7.6, 83, 'college', '2026-03-15'),
('COL058', 7.8, 86, 'college', '2026-04-15'),
-- COL059 (Average Learner)
('COL059', 6.8, 76, 'college', '2026-01-15'),
('COL059', 7.1, 78, 'college', '2026-02-15'),
('COL059', 7.3, 81, 'college', '2026-03-15'),
('COL059', 7.6, 84, 'college', '2026-04-15'),
-- COL060 (Average Learner)
('COL060', 7.4, 80, 'college', '2026-01-15'),
('COL060', 7.6, 82, 'college', '2026-02-15'),
('COL060', 7.8, 85, 'college', '2026-03-15'),
('COL060', 8.1, 88, 'college', '2026-04-15');

-- SEMESTER 7 - FAST LEARNERS (COL061-COL063)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL061 (Fast Learner)
('COL061', 9.1, 94, 'college', '2026-01-15'),
('COL061', 9.4, 96, 'college', '2026-02-15'),
('COL061', 9.5, 97, 'college', '2026-03-15'),
('COL061', 9.5, 97, 'college', '2026-04-15'),
-- COL062 (Fast Learner)
('COL062', 8.8, 91, 'college', '2026-01-15'),
('COL062', 9.1, 93, 'college', '2026-02-15'),
('COL062', 9.3, 96, 'college', '2026-03-15'),
('COL062', 9.5, 97, 'college', '2026-04-15'),
-- COL063 (Fast Learner)
('COL063', 9.4, 96, 'college', '2026-01-15'),
('COL063', 9.5, 97, 'college', '2026-02-15'),
('COL063', 9.5, 97, 'college', '2026-03-15'),
('COL063', 9.5, 97, 'college', '2026-04-15');

-- SEMESTER 8 - SLOW LEARNERS (COL064-COL066)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL064 (Slow Learner)
('COL064', 5.2, 62, 'college', '2026-01-15'),
('COL064', 5.5, 64, 'college', '2026-02-15'),
('COL064', 5.7, 67, 'college', '2026-03-15'),
('COL064', 5.9, 70, 'college', '2026-04-15'),
-- COL065 (Slow Learner)
('COL065', 4.9, 59, 'college', '2026-01-15'),
('COL065', 5.2, 61, 'college', '2026-02-15'),
('COL065', 5.4, 64, 'college', '2026-03-15'),
('COL065', 5.7, 67, 'college', '2026-04-15'),
-- COL066 (Slow Learner)
('COL066', 5.5, 65, 'college', '2026-01-15'),
('COL066', 5.7, 67, 'college', '2026-02-15'),
('COL066', 5.9, 69, 'college', '2026-03-15'),
('COL066', 6.2, 72, 'college', '2026-04-15');

-- SEMESTER 8 - AVERAGE LEARNERS (COL067-COL069)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL067 (Average Learner)
('COL067', 7.2, 79, 'college', '2026-01-15'),
('COL067', 7.5, 81, 'college', '2026-02-15'),
('COL067', 7.7, 84, 'college', '2026-03-15'),
('COL067', 7.9, 87, 'college', '2026-04-15'),
-- COL068 (Average Learner)
('COL068', 6.9, 77, 'college', '2026-01-15'),
('COL068', 7.2, 79, 'college', '2026-02-15'),
('COL068', 7.4, 82, 'college', '2026-03-15'),
('COL068', 7.7, 85, 'college', '2026-04-15'),
-- COL069 (Average Learner)
('COL069', 7.5, 81, 'college', '2026-01-15'),
('COL069', 7.7, 83, 'college', '2026-02-15'),
('COL069', 7.9, 86, 'college', '2026-03-15'),
('COL069', 8.2, 89, 'college', '2026-04-15');

-- SEMESTER 8 - FAST LEARNERS (COL070-COL072)
INSERT INTO student_performance (student_id, prior_gpa, attendance_percentage, institution_type, created_at) VALUES
-- COL070 (Fast Learner)
('COL070', 9.2, 95, 'college', '2026-01-15'),
('COL070', 9.5, 97, 'college', '2026-02-15'),
('COL070', 9.5, 97, 'college', '2026-03-15'),
('COL070', 9.5, 97, 'college', '2026-04-15'),
-- COL071 (Fast Learner)
('COL071', 8.9, 92, 'college', '2026-01-15'),
('COL071', 9.2, 94, 'college', '2026-02-15'),
('COL071', 9.4, 97, 'college', '2026-03-15'),
('COL071', 9.5, 97, 'college', '2026-04-15'),
-- COL072 (Fast Learner)
('COL072', 9.5, 97, 'college', '2026-01-15'),
('COL072', 9.5, 97, 'college', '2026-02-15'),
('COL072', 9.5, 97, 'college', '2026-03-15'),
('COL072', 9.5, 97, 'college', '2026-04-15');

-- ========================================
-- COMPLETE! ALL DATA INSERTED
-- ========================================
-- Total: 117 students (45 school + 72 college)
-- Total: 468 performance records (180 school + 288 college)