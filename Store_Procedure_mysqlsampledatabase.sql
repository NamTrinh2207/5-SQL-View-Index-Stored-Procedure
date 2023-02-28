USE classicmodels;
# Sử dụng Stored Procedure
DELIMITER //
CREATE PROCEDURE findAllCustomers()
BEGIN
	SELECT * FROM customers;
END //
DELIMITER ;

CALL findAllCustomers();

DELIMITER //
DROP PROCEDURE IF EXISTS findAllCustomers;
CREATE PROCEDURE findAllCustomers()
BEGIN
	SELECT * FROM customers WHERE customerNumber = 175;
END //