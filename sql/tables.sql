
--  ****>  Creating Schemas <****  --


--    --> Creating users table <-- 
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
	user_name VARCHAR(50) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(70) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) DEFAULT NULL,
    role ENUM('user', 'admin') DEFAULT 'user',
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL    
);

-- DROP TABLE users

-- SELECT 
--     *
-- FROM
--     users;


--    --> Creating order table <-- 
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    price INT NOT NULL,
    final_price INT NOT NULL,
	paid_amount INT NOT NULL default 0, -- checking each transaction order payment if the paid_amount is less than final price then update the paid_amount for order
    discount TINYINT NOT NULL default 0, -- Showing error massage when it has values less then 0 or greater that 100
    create_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY (user_id)
        REFERENCES users (user_id)
);
-- DROP TABLE orders;

--    --> Creating products table <-- 
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(250) NOT NULL,
    price INT DEFAULT 0,
    discount TINYINT NOT NULL CHECK (discount >= 0 AND discount <= 100),
    status ENUM('in-stock', 'out-stock') DEFAULT 'out-stock',
    description TEXT,
    stock INT DEFAULT 0,
    updated_at DATETIME,
    created_at DATETIME
);

-- DROP TABLE products 


--    --> Creating order items table <-- 
CREATE TABLE order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    order_id INT,
    quantity INT,
    price INT NOT NULL,
    total_price INT NOT NULL,
    FOREIGN KEY (product_id)
        REFERENCES products (product_id),
    FOREIGN KEY (order_id)
        REFERENCES orders (order_id)
);


--    --> Creating transactions table <-- 

CREATE TABLE transactions (
    trans_id INT AUTO_INCREMENT PRIMARY KEY,
    type ENUM('income', 'expence') DEFAULT 'income',
	order_id int,
    amount INT NOT NULL,
    status ENUM('pending', 'paid'),
    description VARCHAR(256),
    create_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    foreign key (order_id) references orders (order_id)
);
-- DROP TABLE transactions;

--    --> Creating address table <-- 
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    FOREIGN KEY (user_id)
        REFERENCES users (user_id),
    country VARCHAR(60) NOT NULL,
    province VARCHAR(60) NOT NULL,
    city VARCHAR(60) NOT NULL,
    post_code VARCHAR(5) NOT NULL,
    street VARCHAR(150) NOT NULL
);


-- DROP TABLE address;
-- DROP TABLE transactions;
-- DROP TABLE orders;
-- DROP TABLE employee;
-- DROP TABLE users;






