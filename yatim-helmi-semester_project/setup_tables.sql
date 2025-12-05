DROP TABLE IF EXISTS `TRANSACTION`;
CREATE TABLE `TRANSACTION` (
    customer_id VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    gender VARCHAR(1),
    purchase_amount DECIMAL(13,2),
    credit_card VARCHAR(20),
    transaction_id VARCHAR(50),
    transaction_date DATE,
    street VARCHAR(50),
    city VARCHAR(50),
    `state` VARCHAR(2),
    zip VARCHAR(5),
    phone VARCHAR(15)
);

DROP TABLE IF EXISTS SUMMARY;
CREATE TABLE SUMMARY(
    customerID VARCHAR(50),
    `state` VARCHAR(2),
    zip VARCHAR(5),
    lastname VARCHAR(50),
    firstname VARCHAR(50),
    total_purchase DECIMAL(13,2)
);