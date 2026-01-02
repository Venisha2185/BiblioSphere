CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    roll_no VARCHAR(20) UNIQUE NOT NULL,
    department VARCHAR(50),
    role ENUM('student','admin') DEFAULT 'student',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100),
    category VARCHAR(50),
    total_copies INT NOT NULL,
    available_copies INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    book_id INT,
    issue_date DATE,
    due_date DATE,
    status ENUM('pending','approved','returned') DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE extensions (
    extension_id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT,
    requested_date DATE,
    new_due_date DATE,
    status ENUM('pending','approved','rejected') DEFAULT 'pending',
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id)
);

CREATE TABLE fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT,
    amount DECIMAL(8,2),
    paid BOOLEAN DEFAULT FALSE,
    calculated_on DATE,
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id)
);

CREATE TABLE chatbot_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    question TEXT,
    response TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
