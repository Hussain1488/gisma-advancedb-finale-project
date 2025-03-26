

-- ***> in this file I have four procedures that each of them containse one transaction.
-- Functionalities like: Adding product in to orders, Paying for Order, Increasing wallet balance and updating the balance of wallet.


-- proedure and transaction for adding product(item) to order

CALL AddProductToOrder(2,1,1);

DELIMITER $$

CREATE PROCEDURE AddProductToOrder(
    IN p_order_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_product_price DECIMAL(10, 2);
    DECLARE v_discount TINYINT;
    DECLARE v_item_price DECIMAL(10, 2);
    DECLARE v_item_final_price DECIMAL(10, 2);
    DECLARE v_order_price DECIMAL(10, 2);
    DECLARE v_order_final_price DECIMAL(10, 2);
    DECLARE v_stock INT;

    -- Start the transaction
    START TRANSACTION;

    -- Get product price and discount
    SELECT price, discount, stock INTO v_product_price, v_discount, v_stock
    FROM products
    WHERE product_id = p_product_id
    FOR UPDATE;

    -- Check if the product is in stock
    IF v_stock < p_quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock for the product';
    END IF;

    -- Calculate item price and final price
    SET v_item_price = v_product_price * p_quantity;
    SET v_item_final_price = v_item_price * (100 - v_discount) / 100;

    -- Insert the item into order_items
    INSERT INTO order_items (product_id, order_id, quantity, price, final_price)
    VALUES (p_product_id, p_order_id, p_quantity, v_item_price, v_item_final_price);

    -- Update product stock and status
    SET v_stock = v_stock - p_quantity;
    UPDATE products
    SET stock = v_stock,
        status = IF(v_stock = 0, 'out-stock', 'in-stock')
    WHERE product_id = p_product_id;

    -- Update order price and final price
    SELECT SUM(price), SUM(final_price) INTO v_order_price, v_order_final_price
    FROM order_items
    WHERE order_id = p_order_id;

    UPDATE orders
    SET price = v_order_price,
        final_price = v_order_final_price
    WHERE order_id = p_order_id;

    COMMIT;
END$$

DELIMITER ;

call PayOrder(2, 1, 70);

-- procedure and transaction for order payment
DELIMITER $$

CREATE PROCEDURE PayOrder(
    IN p_order_id INT,
    IN p_wallet_id INT,
    IN p_payment_amount DECIMAL(10, 2)
)
BEGIN
    DECLARE v_total_price DECIMAL(10, 2);
    DECLARE v_paid_amount DECIMAL(10, 2);
    DECLARE v_wallet_balance DECIMAL(10, 2);
    DECLARE v_order_status ENUM('PENDING','PAID');
    DECLARE v_order_user_id INT;
    DECLARE v_wallet_user_id INT;
    

    -- Start the transaction
    START TRANSACTION;

    -- Get the total price and paid amount of the order
    SELECT final_price, paid_amount INTO v_total_price, v_paid_amount
    FROM orders
    WHERE order_id = p_order_id
    FOR UPDATE;

	SELECT user_id INTO v_order_user_id FROM orders WHERE order_id = p_order_id;
    SELECT user_id INTO v_wallet_user_id FROM wallets WHERE wallet_id = p_wallet_id;

    IF v_order_user_id != v_wallet_user_id THEN
		 
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Selected wallet and selected order have different owners';
	END IF;
    
    IF p_payment_amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid payment amount: Amount must be greater than 0';
    END IF;

    -- Check if the payment exceeds the remaining amount
    IF v_paid_amount + p_payment_amount > v_total_price THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Payment exceeds the total price of the order';
    END IF;
    

    
    -- Get the wallet balance
    SELECT balance INTO v_wallet_balance
    FROM wallets
    WHERE wallet_id = p_wallet_id
    FOR UPDATE; -- Lock the row to prevent concurrent updates

    -- Check if the wallet balance is sufficient
    IF v_wallet_balance < p_payment_amount THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient wallet balance';
    END IF;

    -- Update the paid amount in the orders table
    UPDATE orders o
    SET paid_amount = paid_amount + p_payment_amount,
        status = CASE 
                WHEN (paid_amount + p_payment_amount) >= o.final_price THEN 'PAID' 
                ELSE 'PENDING' 
             END
    WHERE order_id = p_order_id;

    -- Create a wallet history entry for the payment
    INSERT INTO wallet_histories (wallet_id, type, amount)
    VALUES (p_wallet_id, 'WITHDRAW', p_payment_amount);

    -- Update the wallet balance using the UpdateWalletBalance procedure
    CALL UpdateWalletBalance(p_wallet_id, p_payment_amount, 'WITHDRAW');

    -- Commit the transaction
    COMMIT;
END$$

DELIMITER ;

call IncreaseWalletBalance(1, 150, 3, 'it is just for testing the code');

-- procedure and transaction for increasing the wallet balance
DELIMITER $$

CREATE PROCEDURE IncreaseWalletBalance(
    IN p_wallet_id INT,
    IN p_amount DECIMAL(10, 2),
    IN p_account_id INT,
    IN p_description VARCHAR(256)
)
BEGIN
    DECLARE v_wallet_balance DECIMAL(10, 2);
    DECLARE v_account_balance DECIMAL(20, 2);
    DECLARE u_user_id INT;

    -- Start the transaction
    START TRANSACTION;

    -- Validate the amount
    IF p_amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid amount: Amount must be greater than 0';
    END IF;

    -- Get the wallet balance
    SELECT balance INTO v_wallet_balance
    FROM wallets
    WHERE wallet_id = p_wallet_id
    FOR UPDATE; -- Lock the row to prevent concurrent updates

    -- Get the account balance
    SELECT balance INTO v_account_balance
    FROM accounts
    WHERE account_id = p_account_id
    FOR UPDATE; -- Lock the row to prevent concurrent updates


    -- Increase the wallet balance
    UPDATE wallets
    SET balance = balance + p_amount,
        updated_at = NOW()
    WHERE wallet_id = p_wallet_id;
    
    SELECT user_id INTO u_user_id FROM wallets WHERE wallet_id = p_wallet_id;

    -- Create a wallet history entry
    INSERT INTO wallet_histories (wallet_id, amount, type, created_at)
    VALUES (p_wallet_id, p_amount, 'DEPOSIT', NOW());

    -- Create a transaction entry
    INSERT INTO transactions (account_id, user_id, amount, status, type, description, created_at)
    VALUES (p_account_id, u_user_id, p_amount, 'success', 'WITHDRAW', p_description, NOW());

    -- Deduct the amount from the account balance
    UPDATE accounts
    SET balance = balance - p_amount,
        updated_at = NOW()
    WHERE account_id = p_account_id;

    -- Commit the transaction
    COMMIT;
END$$

DELIMITER ;




-- Updating wallet balance for each wallet_history insertion.

call UpdateWalletBalance(1, 100, 'WITHDRAW');

select * from wallets;

DELIMITER $$

CREATE PROCEDURE UpdateWalletBalance(IN u_wallet_id INT, IN new_amount DECIMAL(10, 2), IN type enum('DEPOSIT','WITHDRAW'))
BEGIN 
DECLARE old_balance DECIMAL(10, 2);

	START TRANSACTION;
    
	IF new_amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid amount: Amount must be greater than 0';
    END IF;

	SELECT balance  INTO old_balance FROM wallets WHERE wallet_id = u_wallet_id;

	IF old_balance IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Wallet not found';
    END IF;
    
	IF type = 'DEPOSIT' THEN
		UPDATE wallets SET balance = old_balance + new_amount 
		WHERE wallet_id = u_wallet_id;
	ELSE 
		IF new_amount > old_balance THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Insufficiant wallet balance, can not withdraw more then available balance';
		ELSE
			UPDATE wallets SET balance = old_balance - new_amount 
			WHERE wallet_id = u_wallet_id;
		END IF;
	END IF;
    COMMIT;
END $$
DELIMITER ;


DELIMITER $$

CREATE PROCEDURE OrderStatusChange(
    IN v_order_id INT, 
    IN v_status ENUM('CANCELED','DELIVERED')  -- Fixed typo: CANCELED
)
BEGIN 
    DECLARE trans_message VARCHAR(250);
    DECLARE order_status ENUM('PENDING','PAID','CANCELED','DELIVERED');
    DECLARE u_wallet_id INT;
    DECLARE v_paid_amount DECIMAL(10,2);
    DECLARE v_user_id INT;
    DECLARE v_bank_account_id INT;
    DECLARE p_wallet_id INT;

    START TRANSACTION;
    

    SELECT status, paid_amount, user_id INTO order_status, v_paid_amount, v_user_id
    FROM orders 
    WHERE order_id = v_order_id
    FOR UPDATE;
    
    IF order_status IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Order not found';
    END IF;
    
    IF v_status = order_status THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Order status already set to this status';
    END IF;
    
    IF order_status = 'DELIVERED' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Delivered orders cannot be modified';
    END IF;
    
    IF v_status = 'DELIVERED' AND order_status != 'PAID' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Order must be paid before delivery';
    END IF;
    
    SELECT wallet_id INTO u_wallet_id FROM wallets WHERE user_id = v_user_id;
    SELECT account_id INTO v_bank_account_id 
    FROM accounts 
    WHERE account_type = 'bank_account' AND user_id = v_user_id;  -- Added user filter
    
    IF v_status = 'CANCELED' THEN
        SET trans_message = CONCAT('Refund for order cancellation #', v_order_id);
        
        IF v_paid_amount IS NULL OR v_user_id IS NULL OR v_bank_account_id IS NULL THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Missing required data for cancellation';
        END IF;
        
        IF v_paid_amount > 0 THEN
            INSERT INTO wallet_histories (wallet_id, amount, type)
            VALUES (u_wallet_id, v_paid_amount, 'DEPOSIT');
            
            INSERT INTO transactions(account_id, user_id, amount, status, type, description) 
            VALUES (
                v_bank_account_id,
                v_user_id,
                v_paid_amount,
                'success',
                'REFUND',
                trans_message
                );
            
            call UpdateWalletBalance(1, v_paid_amount, 'DEPOSIT');
            
        END IF;
    END IF;
    
    -- Update order status
    UPDATE orders 
    SET status = v_status,
        updated_at = NOW()
    WHERE order_id = v_order_id;
    
    COMMIT;
END$$

DELIMITER ;
    
    
    
    


