
SHOW INDEX FROM orders;
SHOW INDEX FROM products;
-- User insertion

INSERT INTO users (user_name, first_name, last_name, email, password, phone_number, role)
VALUES
    ('john_doe', 'John', 'Doe', 'john.doe@example.com', 'hashed_password_1', '1234567890', 'user'),
    ('jane_smith', 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_password_2', '0987654321', 'user'),
    ('alice_wang', 'Alice', 'Wang', 'alice.wang@example.com', 'hashed_password_3', '1122334455', 'user'),
    ('bob_brown', 'Bob', 'Brown', 'bob.brown@example.com', 'hashed_password_4', '5566778899', 'user'),
    ('admin_user', 'Admin', 'User', 'admin.user@example.com', 'hashed_password_5', '9988776655', 'admin');
    
    
-- Wallet insertion

INSERT INTO wallets (user_id, balance)
SELECT user_id, 0.00
FROM users;
    
    
-- Product insertion

INSERT INTO products (title, price, discount, status, description, stock)
VALUES
    ('Product 1', 1000, 5, 'in-stock', 'Description for Product 1', 10),
    ('Product 2', 1500, 10, 'out-stock', 'Description for Product 2', 0),
    ('Product 3', 2000, 15, 'in-stock', 'Description for Product 3', 20),
    ('Product 4', 2500, 20, 'in-stock', 'Description for Product 4', 25),
    ('Product 5', 3000, 1, 'out-stock', 'Description for Product 5', 0),
    ('Product 6', 3500, 2, 'in-stock', 'Description for Product 6', 35),
    ('Product 7', 4000, 3, 'in-stock', 'Description for Product 7', 40),
    ('Product 8', 4500, 4, 'in-stock', 'Description for Product 8', 45),
    ('Product 9', 5000, 5, 'in-stock', 'Description for Product 9', 50),
    ('Product 10', 5500, 6, 'out-stock', 'Description for Product 10', 0),
    ('Product 11', 6000, 7, 'in-stock', 'Description for Product 11', 60),
    ('Product 12', 6500, 8, 'in-stock', 'Description for Product 12', 65),
    ('Product 13', 7000, 9, 'in-stock', 'Description for Product 13', 70),
    ('Product 14', 7500, 10, 'out-stock', 'Description for Product 14', 0),
    ('Product 15', 8000, 11, 'in-stock', 'Description for Product 15', 80),
    ('Product 16', 8500, 12, 'in-stock', 'Description for Product 16', 85),
    ('Product 17', 9000, 13, 'in-stock', 'Description for Product 17', 90),
    ('Product 18', 9500, 14, 'in-stock', 'Description for Product 18', 95),
    ('Product 19', 10000, 15, 'out-stock', 'Description for Product 19', 0),
    ('Product 20', 10500, 16, 'in-stock', 'Description for Product 20', 105);
    

-- Accounts insertion

INSERT INTO accounts (account_type, gateway_name, balance, description)
VALUES
    ('credit_card', 'Stripe',0 , 'Credit card ending in 4242'), -- Account for user_id 1
    ('bank_account', 'PayPal',0 , 'Bank account ending in 1234'), -- Account for user_id 2
    ('payment_gateway', 'Stripe',0 , 'Payment gateway for user_id 3'); -- Account for user_id 3


INSERT INTO orders(user_id) values (1), (2),(3),(4);

SELECT * FROM accounts;
    
SELECT * FROM products;
    
SELECT * FROM users;
    
SELECT * FROM wallets;
    
SELECT * FROM wallet_histories;
        
SELECT * FROM transactions;

SELECT * FROM orders;

SELECT * FROM order_items;