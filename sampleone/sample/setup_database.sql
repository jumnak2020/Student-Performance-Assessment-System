-- Database Setup Script for Student Performance Assessment System
-- Run this script to create all required tables

-- Create Database (if not exists)
CREATE DATABASE IF NOT EXISTS student_performance_db;
USE student_performance_db;

-- A. Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE,
    role ENUM('Admin', 'Teacher', 'Student') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- B. Students Table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    admission_number VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    class_grade VARCHAR(10),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- C. Student Performance Records (ML Input Data)
CREATE TABLE student_performance (
    performance_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(50),
    marks INT,
    attendance_percentage INT,
    assignment_timeliness INT,
    participation_score INT,
    prior_gpa DECIMAL(3,2),
    semester VARCHAR(20),
    institution_type VARCHAR(10) DEFAULT 'school',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
);

-- D. Performance Assessments (ML Output)
CREATE TABLE performance_assessments (
    assessment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    performance_id INT,
    performance_level ENUM('Slow Learner', 'Average Learner', 'Fast Learner') NOT NULL,
    confidence_score FLOAT,
    assessment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (performance_id) REFERENCES student_performance(performance_id) ON DELETE CASCADE
);

-- E. Improvement Suggestions
CREATE TABLE improvement_suggestions (
    suggestion_id INT AUTO_INCREMENT PRIMARY KEY,
    assessment_id INT,
    suggestion_text TEXT NOT NULL,
    status ENUM('Pending', 'In Progress', 'Completed') DEFAULT 'Pending',
    FOREIGN KEY (assessment_id) REFERENCES performance_assessments(assessment_id) ON DELETE CASCADE
);

-- Additional table for performance_results (used in app.py)
CREATE TABLE performance_results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    student_name VARCHAR(100),
    marks DECIMAL(5,2),
    attendance INT,
    assignments INT,
    performance_score DECIMAL(5,2),
    learner_type VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample admin user (password: admin123)
INSERT INTO users (username, password_hash, email, role) VALUES 
('admin', 'admin123', 'admin@school.com', 'Admin');

-- Insert sample student user (password: student123)
INSERT INTO users (username, password_hash, email, role) VALUES 
('student1', 'student123', 'student1@school.com', 'Student');

-- Insert sample student record
INSERT INTO students (user_id, admission_number, first_name, last_name, class_grade) VALUES 
(2, 'STU001', 'John', 'Doe', '10A');

SELECT 'Database setup completed successfully!' as message;
