

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
#1. MYSQL EVENT SCHEDULER
CREATE definer = 'root'@'localhost' 
EVENT table_update_event 
ON SCHEDULE EVERY 1 DAY STARTS '2020-08-01 2:00:00' 
ON COMPLETION PRESERVE ENABLE do call updated_customer_order_table();

#2. Schedule a cron.
#env EDITOR=nano crontab -e
#0 2 * * * cd Desktop && user/bin/updated_customer_order_table.sql

