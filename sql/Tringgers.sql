
-- *** >  Isertion tables setting current time and date to create_at and updated_at   < *** -- 

-- User table befor insertion 
DELIMITER $$
CREATE TRIGGER before_insert_users
BEFORE INSERT ON users FOR EACH ROW
BEGIN
    -- Set created_at and updat	ed_at to the current timestamp
    SET NEW.created_at = NOW();
    SET NEW.updated_at = NOW();
END ;
DE:IMITER ;

-- Products table befor insertion 
DELIMITER $$
create trigger befor_insert_products
before insert on products for each row
begin 
	-- Set created_at and updated_at to the current timestamp
    set new.created_at = now();
    set new.update_at = now();
end;
DELIMITER ;


-- Orders table befor insertion 
DELIMITER $$
create trigger befor_insert_orders
before insert on orders for each row
begin 
	-- Set created_at and updated_at to the current timestamp
    set new.created_at = now();
    set new.update_at = now();
end;
DELIMITER ;

-- Order_items table befor insertion 
DELIMITER $$
create trigger befor_insert_order_items
before insert on order_items for each row
begin 
	-- Set created_at and updated_at to the current timestamp
	set new.total_price = new.quantity * new.price;
    set new.updated_at = now();
    set new.created_at = now();
end;
DELIMITER ;


-- Transactions table befor insertion 
DELIMITER $$
create trigger befor_insert_transactions
before insert on transactions for each row
begin 
	-- Set created_at and updated_at to the current timestamp
    set new.created_at = now();
    set new.update_at = now();
end;
DELIMITER ;