
-- *** >  Isertion tables setting current time and date to create_at and updated_at   < *** -- 

-- User table befor insertion 
DELIMITER $$
CREATE TRIGGER before_insert_users
BEFORE INSERT ON users FOR EACH ROW
BEGIN
    -- Set created_at and updated_at to the current timestamp
    SET NEW.created_at = now(),
    NEW.updated_at = now();
END $$
DELIMITER ;

-- Products table befor insertion 
DELIMITER $$
create trigger befor_insert_products
before insert on products for each row
begin 
	-- Set created_at and updated_at to the current timestamp
    SET NEW.created_at = now(),
    NEW.updated_at = now();
end $$
DELIMITER ;


-- Orders table befor insertion 
DELIMITER $$
create trigger befor_insert_orders
before insert on orders for each row
begin 
	-- Set created_at and updated_at to the current timestamp
    SET NEW.created_at = now(),
    NEW.updated_at = now(),
    NEW.price = 0,
    NEW.status = 'PENDING',
    NEW.final_price = 0,
    NEW.paid_amount =0;
end $$
DELIMITER ;


-- Transactions table befor insertion 
DELIMITER $$
create trigger befor_insert_transactions
before insert on transactions for each row
begin 
	-- Set created_at and updated_at to the current timestamp
    set new.created_at = now();
end$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER befor_insert_wallet
BEFORE INSERT ON wallets FOR EACH ROW
BEGIN 
	-- SET UPDATED_AT AND CREATED_AT TO CURRENT TIME
    SET NEW.created_at = now(),
    NEW.updated_at = now();
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER before_insert_wallet_histories
BEFORE INSERT ON wallet_histories FOR EACH ROW
BEGIN 
	-- SET UPDATED_AT AND CREATED_AT TO CURRENT TIMESTAMP
    SET NEW.created_at = now();
END $$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER before_insert_accounts
BEFORE INSERT ON accounts FOR EACH ROW
BEGIN
	-- SET UPDATED_AT AND CREATED_AT FOR CURRENT TIMESTAMP
    SET NEW.updated_at = now(),
    NEW.created_at = now();
END $$
DELIMITER ;




-- *****     UPDATE TRIGGERS       *****  ----


-- UPDATED THE UPDATED_AT 
DELIMITER $$
create trigger befor_update_user
before update on users for each row
begin
	-- set the updated_at to the current timespamt
    set new.updated_at = now();
end$$

DELIMITER ;



-- UPDATED THE UPDATED_AT 
DELIMITER $$
create trigger before_update_order
before update on orders for each row
begin 
	-- set the updated_at to the current time stamp
    set new.updated_at = now();
end $$
DELIMITER ;


-- UPDATED THE UPDATED_AT transactionstransactions
DELIMITER $$
create trigger befor_update_product
before update on products for each row
begin 
	-- set the updated_at to the current timespamp
    set new.updated_at = now();
end$$
DELIMITER ;

DELIMITER $$



-- UPDATED THE UPDATED_AT 
DELIMITER $$
CREATE TRIGGER befor_update_wallet
BEFORE UPDATE ON wallets FOR EACH ROW
BEGIN 
	-- set updated_at to current timestamp
    set new.updated_at = now();
END$$
DELIMITER ;


-- UPDATE THE UPDATED_AT
DELIMITER $$
CREATE TRIGGER befor_update_account
BEFORE UPDATE ON accounts FOR EACH ROW
BEGIN
	-- SET UPDATED_AT TO CURRENT TIMESTAMP
    SET NEW.updated_at = now();
END $$
DELIMITER ;




    
    