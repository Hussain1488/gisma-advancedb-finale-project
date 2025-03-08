
-- User insert

INSERT INTO users (user_name, first_name, last_name, email, password, phone_number, role, created_at, updated_at)
VALUES ('admin', 'alex', 'admin', 'admin@example.com', 'admin123', '0900000000', 'admin', NOW(), NOW());

INSERT INTO users (user_name, first_name, last_name, email, password, phone_number, role, created_at, updated_at)
VALUES ('john_doe', 'John', 'Doe', 'john.doe@example.com', 'securepassword123', '1234567890', 'user', NOW(), NOW());

-- Product insert
INSERT INTO products (title, price, discount, status, description, stock, created_at, updated_at)
VALUES
    ('Smartphone X', 80000, 5, 'in-stock', 'Latest model with 128GB storage', 50, NOW(), NOW()),
    ('Wireless Earbuds', 15000, 10, 'in-stock', 'Noise-cancelling wireless earbuds', 100, NOW(), NOW()),
    ('4K Smart TV', 120000, 15, 'in-stock', '55-inch 4K UHD Smart TV', 30, NOW(), NOW()),
    ('Gaming Laptop', 150000, 20, 'in-stock', 'High-performance gaming laptop with RTX 3080', 20, NOW(), NOW()),
    ('Bluetooth Speaker', 5000, 0, 'in-stock', 'Portable Bluetooth speaker with 12-hour battery', 200, NOW(), NOW()),
    ('Smart Watch', 25000, 10, 'in-stock', 'Fitness tracker with heart rate monitor', 80, NOW(), NOW()),
    ('Tablet Pro', 60000, 5, 'in-stock', '10-inch tablet with 256GB storage', 40, NOW(), NOW()),
    ('DSLR Camera', 90000, 10, 'in-stock', '24MP DSLR camera with 18-55mm lens', 25, NOW(), NOW()),
    ('Wireless Keyboard', 3000, 0, 'in-stock', 'Ergonomic wireless keyboard', 150, NOW(), NOW()),
    ('External Hard Drive', 7000, 5, 'in-stock', '1TB portable external hard drive', 60, NOW(), NOW());
    
    