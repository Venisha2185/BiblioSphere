-- =========================================
-- BiblioSphere - Smart Library Management System
-- Final Database Schema
-- =========================================

CREATE DATABASE IF NOT EXISTS bibliosphere_db;
USE bibliosphere_db;

-- =========================
-- USERS (Students, Teachers, Admin)
-- =========================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    roll_no VARCHAR(20) UNIQUE,
    department VARCHAR(50),
    role ENUM('student','teacher','admin') NOT NULL,
    account_expiry_date DATE,
    is_premium BOOLEAN DEFAULT FALSE,
    max_books_allowed INT DEFAULT 4,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- BOOKS
-- =========================
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    book_code VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100),
    category VARCHAR(50),
    total_copies INT NOT NULL,
    available_copies INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- RESERVATIONS
-- =========================
CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    issue_date DATE,
    due_date DATE,
    status ENUM('pending','approved','returned') DEFAULT 'pending',
    extension_count INT DEFAULT 0,
    waiting_position INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- =========================
-- EXTENSIONS
-- =========================
CREATE TABLE extensions (
    extension_id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT NOT NULL,
    requested_date DATE,
    new_due_date DATE,
    status ENUM('pending','approved','rejected') DEFAULT 'pending',
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id)
);

-- =========================
-- FINES
-- =========================
CREATE TABLE fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT NOT NULL,
    amount DECIMAL(8,2),
    paid BOOLEAN DEFAULT FALSE,
    reason ENUM('late_return','lost_book') DEFAULT 'late_return',
    calculated_on DATE,
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id)
);

-- =========================
-- CHATBOT LOGS (Optional)
-- =========================
CREATE TABLE chatbot_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    question TEXT,
    response TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

