
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

--    --> Creating order table <-- 
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    price DECIMAL(10, 2) CHECK (price >= 0),
    final_price DECIMAL(10, 2) CHECK (final_price >= 0),
	paid_amount DECIMAL(10, 2) CHECK (paid_amount >= 0),
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY (user_id)
        REFERENCES users (user_id)
);

--    --> Creating products table <-- 
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(250) NOT NULL,
    price DECIMAL(10, 2) CHECK (price >= 0),
    discount TINYINT NOT NULL CHECK (discount >= 0 AND discount <= 100),
    status ENUM('in-stock', 'out-stock') DEFAULT 'out-stock',
    description TEXT,
    stock INT DEFAULT 0,
    updated_at DATETIME,
    created_at DATETIME
);

--    --> Creating order items table <-- 
CREATE TABLE order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    order_id INT,
    quantity INT,
    price DECIMAL(10, 2) CHECK (price >= 0),
    final_price DECIMAL(10, 2) CHECK (final_price >= 0),
    FOREIGN KEY (product_id)
        REFERENCES products (product_id),
    FOREIGN KEY (order_id)
        REFERENCES orders (order_id)
);

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

CREATE TABLE wallets(
wallet_id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT,
balance DECIMAL(10, 2) CHECK (balance >= 0) DEFAULT 0,
created_at DATETIME NOT NULL,
updated_at DATETIME NOT NULL,
FOREIGN KEY (user_id)
        REFERENCES users (user_id)
);

CREATE TABLE wallet_histories(
history_id INT AUTO_INCREMENT PRIMARY KEY,
wallet_id INT NOT NULL,
order_id INT,
amount DECIMAL(10,2) NOT NULL,
status ENUM('failed', 'success'),
type ENUM('DEPOSIT','WITHDRAW') DEFAULT('DEPOSITE'),
created_at DATETIME NOT NULL,
FOREIGN KEY (wallet_id)
        REFERENCES wallets (wallet_id),
FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

--    --> Creating transactions table <-- 

CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    account_type ENUM('bank_account', 'credit_card', 'payment_gateway') DEFAULT 'bank_account' NOT NULL,
    gateway_name VARCHAR(100),
    balance DECIMAL(20, 2) NOT NULL,
    description VARCHAR(256),
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
);

CREATE TABLE transactions (
    trans_id INT AUTO_INCREMENT PRIMARY KEY,
	account_id INT NOT NULL,
    amount DECIMAL(10, 2) CHECK (amount >= 0),
    status ENUM('failed', 'success'),
    type ENUM('DEPOSIT','WITHDRAW') DEFAULT 'DEPOSIT',
    description VARCHAR(256),
    created_at DATETIME NOT NULL,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

DROP TABLE address;
DROP TABLE transactions;
DROP TABLE wallet_histories;
DROP TABLE wallets;
DROP TABLE order_items;
DROP TABLE orders;
DROP TABLE products;
DROP TABLE accounts;
DROP TABLE users;





