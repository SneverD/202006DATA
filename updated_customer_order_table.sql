DELIMITER //

DROP PROCEDURE IF EXISTS updated_customer_order_table;
CREATE PROCEDURE updated_customer_order_table(IN start_date date, IN end_date date)

BEGIN
DROP TABLE IF EXISTS customer_order;
CREATE TABLE IF NOT EXISTS customer_order as 
(SELECT customerName,city,state,country,salesRepEmployeeNumber from customers c
left join orders o on o.customerNumber=c.customerNumber
left join orderdetails ot on ot.orderNumber=o.orderNumber
where orderDate between start_date and end_date ); 

END //

DELIMITER ;


-- 1. Schedule a cron to execute at 2am daily.
#crontab -e
#!/ltd/bin/bash
#/usr/local/mysql/bin/mysql -u root -Daiyumeng < updated_customer_order_table.sql
#0 2 * * * root updated_customer_order_table.sh
