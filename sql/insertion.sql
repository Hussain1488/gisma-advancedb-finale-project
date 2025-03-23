

-- User insertion

INSERT INTO users (user_name, first_name, last_name, email, password, phone_number, role, created_at, updated_at)
VALUES
    ('john_doe', 'John', 'Doe', 'john.doe@example.com', 'hashed_password_1', '1234567890', 'user', NOW(), NOW()),
    ('jane_smith', 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_password_2', '0987654321', 'user', NOW(), NOW()),
    ('alice_wang', 'Alice', 'Wang', 'alice.wang@example.com', 'hashed_password_3', '1122334455', 'user', NOW(), NOW()),
    ('bob_brown', 'Bob', 'Brown', 'bob.brown@example.com', 'hashed_password_4', '5566778899', 'user', NOW(), NOW()),
    ('admin_user', 'Admin', 'User', 'admin.user@example.com', 'hashed_password_5', '9988776655', 'admin', NOW(), NOW());
    
    
-- Wallet insertion

INSERT INTO wallets (user_id, balance, created_at, updated_at)
SELECT user_id, 0.00, NOW(), NOW()
FROM users;
    
    
-- Product insertion

INSERT INTO products (title, price, discount, status, description, stock, created_at, updated_at)
VALUES
    ('Product 1', 1000, 5, 'in-stock', 'Description for Product 1', 10, NOW(), NOW()),
    ('Product 2', 1500, 10, 'out-stock', 'Description for Product 2', 0, NOW(), NOW()),
    ('Product 3', 2000, 15, 'in-stock', 'Description for Product 3', 20, NOW(), NOW()),
    ('Product 4', 2500, 20, 'in-stock', 'Description for Product 4', 25, NOW(), NOW()),
    ('Product 5', 3000, 1, 'out-stock', 'Description for Product 5', 0, NOW(), NOW()),
    ('Product 6', 3500, 2, 'in-stock', 'Description for Product 6', 35, NOW(), NOW()),
    ('Product 7', 4000, 3, 'in-stock', 'Description for Product 7', 40, NOW(), NOW()),
    ('Product 8', 4500, 4, 'in-stock', 'Description for Product 8', 45, NOW(), NOW()),
    ('Product 9', 5000, 5, 'in-stock', 'Description for Product 9', 50, NOW(), NOW()),
    ('Product 10', 5500, 6, 'out-stock', 'Description for Product 10', 0, NOW(), NOW()),
    ('Product 11', 6000, 7, 'in-stock', 'Description for Product 11', 60, NOW(), NOW()),
    ('Product 12', 6500, 8, 'in-stock', 'Description for Product 12', 65, NOW(), NOW()),
    ('Product 13', 7000, 9, 'in-stock', 'Description for Product 13', 70, NOW(), NOW()),
    ('Product 14', 7500, 10, 'out-stock', 'Description for Product 14', 0, NOW(), NOW()),
    ('Product 15', 8000, 11, 'in-stock', 'Description for Product 15', 80, NOW(), NOW()),
    ('Product 16', 8500, 12, 'in-stock', 'Description for Product 16', 85, NOW(), NOW()),
    ('Product 17', 9000, 13, 'in-stock', 'Description for Product 17', 90, NOW(), NOW()),
    ('Product 18', 9500, 14, 'in-stock', 'Description for Product 18', 95, NOW(), NOW()),
    ('Product 19', 10000, 15, 'out-stock', 'Description for Product 19', 0, NOW(), NOW()),
    ('Product 20', 10500, 16, 'in-stock', 'Description for Product 20', 105, NOW(), NOW());
    

-- Accounts insertion

INSERT INTO accounts (account_type, gateway_name, balance, description, created_at, updated_at)
VALUES
    ('credit_card', 'Stripe',0 , 'Credit card ending in 4242', NOW(), NOW()), -- Account for user_id 1
    ('bank_account', 'PayPal',0 , 'Bank account ending in 1234', NOW(), NOW()), -- Account for user_id 2
    ('payment_gateway', 'Stripe',0 , 'Payment gateway for user_id 3', NOW(), NOW()); -- Account for user_id 3


SELECT 
    *
FROM
    accounts;
    
SELECT 
    *
FROM
    products;
    
SELECT 
    *
FROM
    users;
    
SELECT 
    *
FROM
    wallets;