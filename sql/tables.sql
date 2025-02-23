CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    full_name VARCHAR(70) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20) DEFAULT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    role ENUM('customer', 'admin', 'employee') DEFAULT 'customer'
);
-- DROP TABLE users;-- 


CREATE TABLE employee (
    emp_id INT AUTO_INCREMENT NOT NULL KEY,
    user_id INT,
    salary INT NOT NULL,
    total_salary INT NOT NULL,
    start_date DATE NOT NULL,
    create_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY (user_id)
        REFERENCES users (user_id)
);
-- DROP TABLE employee;



CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    price INT NOT NULL,
    final_price INT NOT NULL,
    discount TINYINT NOT NULL,
    create_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY (user_id)
        REFERENCES users (user_id)
);
-- DROP TABLE orders;



