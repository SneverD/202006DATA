###HOMEWORK 1
##Single entity
#1. Prepare a list of offices sorted by country, state, city.
select officeCode,country,state,city
from offices;
#2.How many employees are there in the company?
select count(employeeNumber) as employeenumb
from employees;
#3.What is the total of payments received?
select * from payments;
select sum(amount) as totalpayment
from payments;
#4.List the product lines that contain 'Cars'.
select productLine
from productlines
where productLine like ('%cars%');
#5.Report total payments for October 28, 2004.
select paymentDate, sum(amount) as totalpayment
from payments
where paymentDate='2004-10-28';
#6.Report those payments greater than $100,000.
select * 
from payments
where amount>100000;
#7.List the products in each product line.
select productLine, productCode,productName
from products
order by productLine;
#8.How many products in each product line?
select productLine, count(productCode) as numberofproduct
from products
group by productLine;
#9.What is the minimum payment received?
select min(amount)
from payments;
#10 List all payments greater than twice the average payment.
select * 
from payments
where amount>2*(select avg(amount)from payments);
#11.What is the average percentage markup of the MSRP on buyPrice?
select avg((MSRP-buyPrice)/buyPrice) as avgmarkuprate
from products;
#12.How many distinct products does ClassicModels sell?
select count(distinct productCode) as nubproducts
from products;
#13.Report the name and city of customers who don't have sales representatives?
select customerName,city
from customers
where salesRepEmployeeNumber is null;
#14.What are the names of executives with VP or Manager in their title? Use the CONCAT function to combine the employee's first name and last name into a single field for reporting. 
select concat(firstName,' ',lastName) as employeename, jobTitle
from employees
where jobTitle like '%vp%'or jobTitle like '%manager%';
#15.Which orders have a value greater than $5,000?
select orderNumber,priceEach
from orderdetails
where priceEach>5000;



##One to many relationship
#1. Report the account representative for each customer.
select customerNumber, customerName,salesRepEmployeeNumber
from customers
order by salesRepEmployeeNumber;
#2.Report total payments for Atelier graphique.
select customers.customerName, sum(payments.amount) as totpayment
from customers, payments
where customers.customerNumber=payments.customerNumber
group by customers.customerName
having customers.customerName='Atelier graphique';
#3.Report the total payments by date
select paymentDate, sum(amount) as totalpayment
from payments
group by paymentDate
order by paymentDate;
#4.Report the products that have not been sold.
select * 
from Products ,OrderDetails 
where Products.productCode != OrderDetails.productCode;
#5.List the amount paid by each customer.
select customers.customerNumber, customers.customerName, sum(payments.amount) as totamount
from payments, customers
where customers.customerNumber=payments.customerNumber 
group by customerNumber
order by totamount desc;
#6.How many orders have been placed by Herkku Gifts?
select customerName, count(orderNumber) as orderamount
from customers,orders
where customers.customerNumber=orders.customerNumber
and customerName='herkku gifts';
#7.Who are the employees in Boston?
select employees.firstName,employees.lastName,offices.city
from employees, offices 
where employees.officeCode=offices.officeCode
and city='boston';
#8.Report those payments greater than $100,000. Sort the report so the customer who made the highest payment appears first.
select customerNumber, amount
from payments
where amount>100000
order by amount desc;
#9.List the value of 'On Hold' orders.
select sum(payments.amount) as ordervalue, orders.status
from orders,payments
where orders.customerNumber=payments.customerNumber
and orders.status='on hold';
#10.Report the number of orders 'On Hold' for each customer.
select customerNumber, count(status='on hold') as numoforders
from orders
group by customerNumber;



## Many to many relationship
#1. List products sold by order date.
select products.productName,orders.orderDate
from products
join orderdetails
on orderdetails.productCode=products.productCode
join orders
on orders.orderNumber=orderdetails.orderNumber
order by orderDate;
#2.List the order dates in descending order for orders for the 1940 Ford Pickup Truck.
select products.productName,orders.orderDate
from products
join orderdetails
on orderdetails.productCode=products.productCode
join orders
on orders.orderNumber=orderdetails.orderNumber
where productName='1940 Ford Pickup Truck'
order by orderDate desc;
#3.List the names of customers and their corresponding order number where a particular order from that customer has a value greater than $25,000?
select customers.customerName, sum(orderdetails.priceEach*orderdetails.quantityOrdered) as value
from customers
join orders
on orders.customerNumber=customers.customerNumber
join orderdetails
on orderdetails.orderNumber=orders.orderNumber
group by customers.customerName
having value>25000;
#4.Are there any products that appear on all orders?
select o.productCode as productappearall
from orderdetails o
where ( select count(distinct productcode) as p from orderdetails)=
(select count(distinct orderdetails.orderNumber) from orderdetails);
#5.List the names of products sold at less than 80% of the MSRP.
select products.productName, products.MSRP, orderdetails.priceEach as soldprice
from products
join orderdetails
on orderdetails.productCode=products.productCode
having soldprice<products.MSRP*0.8;
#6.Reports those products that have been sold with a markup of 100% or more (i.e.,  the priceEach is at least twice the buyPrice)
select products.productName, products.buyPrice, orderdetails.priceEach as soldprice
from products
join orderdetails
on orderdetails.productCode=products.productCode
having soldprice>buyPrice*2;
#7.List the products ordered on a Monday.
select products.productName,orders.orderDate
from products
join orderdetails
on orderdetails.productCode=products.productCode
join orders
on orderdetails.orderNumber=orders.orderNumber
where dayname(orders.orderDate)='monday';
#8.What is the quantity on hand for products listed on 'On Hold' orders?
select products.productName,products.quantityInStock,orders.status
from products
join orderdetails
on orderdetails.productCode=products.productCode
join orders
on orders.orderNumber=orderdetails.orderNumber
where orders.status='on hold';




##Regular expressions
#1.Find products containing the name 'Ford'.
select productName
from products
where productName like('%ford%');
#2. List products ending in 'ship'.
select productName
from products 
where productName like('%ship');
#3. Report the number of customers in Denmark, Norway, and Sweden.
select country, count(customerNumber) as customernub
from customers
where country='denmark'or country='Norway' or country='sweden'
group by country;
#4.What are the products with a product code in the range S700_1000 to S700_1499?
select productCode,productName
from products
where productCode between 'S700_1000' and 'S700_1499';
#5.Which customers have a digit in their name?
select customerName
from customers
where customerName like '%[0-9]%';
#6.List the names of employees called Dianne or Diane.
select employeeNumber,lastName,firstName
from employees
where firstName ='dianne'or firstName='diane';
#7.List the products containing ship or boat in their product name.
select productName
from products 
where productName like '%boat%' or productName like'%ship%';
#8.List the products with a product code beginning with S700.
select productCode,productName
from products
where productCode like 's700%';
#9.List the names of employees called Larry or Barry.
select employeeNumber,lastName,firstName
from employees
where firstName like '%larry%' or firstName like '%barry%';
#10.List the names of employees with non-alphabetic characters in their names.
select lastName,firstName
from employees
where lastname LIKE '%[^a-zA-Z]%' or firstname LIKE '%[^a-zA-Z]%';
#11.List the vendors whose name ends in Diecast
select productVendor
from products
where productVendor like '%diecast';



##General queries
#1. Who is at the top of the organization (i.e.,  reports to no one).
select employeeNumber,lastName,firstName
from employees
where reportsTo is null;
#2.Who reports to William Patterson?
select employeeNumber 
from employees 
where employees.lastName='Patterson' and employees.firstName='William';
select employeeNumber,lastName,firstName
from employees
where employees.reportsTo = '1088';
#3.List all the products purchased by Herkku Gifts.
select products.productName,customers.customerName
from products
join orderdetails
on orderdetails.productCode=products.productCode
join orders
on orders.orderNumber=orderdetails.orderNumber
join customers
on customers.customerNumber=orders.customerNumber
having customers.customerName='Herkku Gifts';
#4.Compute the commission for each sales representative, assuming the commission is 5% of the value of an order. Sort by employee last name and first name.
SELECT Customers.salesRepEmployeeNumber, CONCAT(firstName, ' ', lastName) AS Employee, (amount*0.05) AS commission
FROM Customers, Payments, Employees
WHERE Payments.customerNumber= Customers.customerNumber
ORDER BY lastName, firstName;
#5.What is the difference in days between the most recent and oldest order date in the Orders file?
select min(orderDate) as oldestdate, max(orderDate)as recentdate, datediff(max(orderDate),min(orderDate)) as difference
from orders;
#6.Compute the average time between order date and ship date for each customer ordered by the largest difference.
select customerNumber, avg(datediff(shippedDate,orderDate))as avgtime
from orders
group by customerNumber
order by avgtime desc;
#7.What is the value of orders shipped in August 2004?
select sum(orde.priceEach*orde.quantityOrdered) Total_Value 
from ClassicModels.orders ord,ClassicModels.orderdetails orde 
where ord.orderNumber=orde.orderNumber 
and monthname(ord.shippedDate)='August' 
and year(ord.shippedDate)=2004;
#8.Compute the total value ordered, total amount paid, and their difference for each customer for orders placed in 2004 and payments received in 2004 (Hint; Create views for the total paid and total ordered).
select orders.customerNumber, sum(payments.amount) as totpaid, 
sum(orderdetails.quantityOrdered*orderdetails.priceEach) as totorder,
(sum(payments.amount)-sum(orderdetails.quantityOrdered*orderdetails.priceEach)) as diff
from payments
join orders
     on orders.customerNumber=payments.customerNumber
join orderdetails
     on orderdetails.orderNumber=orders.orderNumber
where year(orders.orderDate)='2004' and year(payments.paymentDate)='2004'
group by orders.customerNumber;
#9.List the employees who report to those employees who report to Diane Murphy. Use the CONCAT function to combine the employee's first name and last name into a single field for reporting.
select A.employeeNumber, CONCAT(A.firstName, ' ', A.lastName), A.reportsTo
from Employees A 
inner join Employees B ON A.reportsTo = B.employeeNumber
where B.reportsto = 1002;
#10.What is the percentage value of each product in inventory sorted by the highest percentage first (Hint: Create a view first).
select sum(quantityInStock) as totinventory
from products;
select productCode,productName,(quantityInStock/555131*100)as percentage
from products
order by percentage desc;
#11.Write a function to convert miles per gallon to liters per 100 kilometers.
delimiter $$
create function mpg_convert(v_mpg double) 
returns double
deterministic no sql reads sql data
begin
declare v_lpk double;
return 235.215 * v_mpg;
end $$
delimiter;
#12.Write a procedure to increase the price of a specified product category by a given percentage. You will need to create a product table with appropriate data to test your procedure. Alternatively, load the ClassicModels database on your personal machine so you have complete access. You have to change the DELIMITER prior to creating the procedure.
delimiter $$
create procedure change_price(in v_percentage double, in v_productkine varchar(255))
begin
update products
set msrp = (1 + v_percentage) * msrp
where productlines = v_productline;
end$$
delimiter ;
#14.What is the ratio the value of payments made to orders received for each month of 2004?
select month(orderDate) as order_month, sum(ot.quantityOrdered * ot.priceEach)/ sum(p.amount) as ratio
from payments p
join orders o on p.customerNumber = o.customerNumber
join orderdetails ot on o.orderNumber = od.orderNumber
group by order_month;

#15.What is the difference in the amount received for each month of 2004 compared to 2003?
SELECT 
    tb1.payment_month,
    tb1.monthly_payment AS 2004_payment,
    tb2.monthly_payment AS 2003_payment,
    tb1.monthly_payment - tb2.monthly_payment AS payment_difference
FROM
    (SELECT 
        MONTH(paymentDate) AS payment_month,
            SUM(amount) AS monthly_payment
    FROM
        payments
    WHERE
        YEAR(paymentDate) = 2004
    GROUP BY MONTH(paymentDate)) AS tb1
        JOIN
    (SELECT 
        MONTH(paymentDate) AS payment_month,
            SUM(amount) AS monthly_payment
    FROM
        payments
    WHERE
        YEAR(paymentDate) = 2003
    GROUP BY MONTH(paymentDate)) AS tb2 ON tb1.payment_month = tb2.payment_month
ORDER BY payment_month ASC;


#16.Write a procedure to report the amount ordered in a specific month and year for customers containing a specified character string in their name.
delimiter $$
create procedure orderamount(in v_month integer, in v_year integer, in v_customer varchar(255))
begin
select c.customerName,sum(ot.quantityOrdered*ot.priceEach) as amount
from orders o
join orderdetails ot on ot.orderNumber=o.orderNumber
join customers c on c.customerNumber=o.customerNumber
group by c.customerName
having year(o.orderDate) = v_year and
      month(o.orderDate) = v_month and 
      c.customerName regexp v_custome;
end$$
delimiter ;

#17.Write a procedure to change the credit limit of all customers in a specified country by a specified percentage.
delimiter $$
create procedure change_credit_limit(in v_percentage double, in v_country varchar(255))
begin
update customers
set creditLimit = (1 + v_percentage) * creditLimit
where country = v_country;
end$$
delimiter ;

#18.Basket of goods analysis: A common retail analytics task is to analyze each basket or order to learn what products are often purchased together. Report the names of products that appear in the same order ten or more times.
select items,count(*) as 'Freq' from 
(select concat(x.productCode,',',y.productCode) as items from orderdetails x 
JOIN orderdetails y ON x.orderNumber = y.orderNumber and 
x.productCode != y.productCode and x.productCode < y.productCode) A 
group by A.items 
having Freq>10 
order by A.items;
#19. ABC reporting: Compute the revenue generated by each customer based on their orders. Also, show each customer's revenue as a percentage of total revenue. Sort by customer name.
select sum(orderdetails.quantityOrdered*orderdetails.priceEach) as totrevenue
from orderdetails;
select orders.customerNumber, 
       sum(orderdetails.quantityOrdered*orderdetails.priceEach) as revenue,
	   (sum(orderdetails.quantityOrdered*orderdetails.priceEach)/9604190.61)*100 as percentage
from orderdetails
join orders
on orderdetails.orderNumber=orders.orderNumber
group by orders.customerNumber
order by orders.customerNumber;
#20.Compute the profit generated by each customer based on their orders. Also, show each customer's profit as a percentage of total profit. Sort by profit descending.
select sum(orderdetails.quantityOrdered*(orderdetails.priceEach-products.buyPrice)) as totprofit
from orderdetails
join products on products.productCode=orderdetails.productCode;
select orders.customerNumber, 
       sum(orderdetails.quantityOrdered*(orderdetails.priceEach-products.buyPrice)) as profit,
	   (sum(orderdetails.quantityOrdered*(orderdetails.priceEach-products.buyPrice))/3825880.25)*100 as percentage
from orderdetails
join orders on orderdetails.orderNumber=orders.orderNumber
join products on products.productCode=orderdetails.productCode
group by orders.customerNumber
order by profit desc;

#21.Compute the revenue generated by each sales representative based on the orders from the customers they serve.
select customers.salesRepEmployeeNumber,sum(orderdetails.quantityOrdered*orderdetails.priceEach) as revenue
from orders
join orderdetails on orderdetails.orderNumber=orders.orderNumber
join customers on customers.customerNumber=orders.customerNumber
group by customers.salesRepEmployeeNumber;

#22. Compute the profit generated by each sales representative based on the orders from the customers they serve. Sort by profit generated descending.
select customers.salesRepEmployeeNumber,sum(orderdetails.quantityOrdered*(orderdetails.priceEach-products.buyPrice)) as profit
from orders
join orderdetails on orderdetails.orderNumber=orders.orderNumber
join customers on customers.customerNumber=orders.customerNumber
join products on products.productCode=orderdetails.productCode
group by customers.salesRepEmployeeNumber
order by profit desc;

#23. Compute the revenue generated by each product, sorted by product name.
select  products.productName, sum(orderdetails.quantityOrdered*orderdetails.priceEach) as revenue
from orderdetails
join products
on orderdetails.productCode=products.productCode
group by products.productName
order by products.productName;

#24. Compute the profit generated by each product line, sorted by profit descending.
select products. productLine, sum(orderdetails.quantityOrdered*(orderdetails.priceEach-products.buyPrice)) as profit
from orderdetails
join products
on orderdetails.productCode=products.productCode
group by products. productLine
order by profit desc;

#25.Compute the ratio for each product of sales for 2003 versus 2004???
SELECT 
    tb1.productCode,
    tb1.sale AS 2003_sale,
    tb2.sale AS 2004_sale

FROM
    (SELECT productCode, SUM(quantityOrdered*priceEach) AS sale
    FROM orderdetails JOIN orders ON orders.orderNumber=orderdetails.orderNumber
    WHERE YEAR(orderDate) = 2003
    GROUP BY  productCode) AS tb1
JOIN
    (SELECT productCode,SUM(quantityOrdered*priceEach) AS sale
    FROM orderdetails JOIN orders ON orders.orderNumber=orderdetails.orderNumber
    WHERE YEAR(orderDate) = 2004
    GROUP BY productCode) AS tb2
    
ON tb1.productCode= tb2.productCode;

#26.Compute the ratio of payments for each customer for 2003 versus 2004??
SELECT 
    tb1.customerNumber,
    tb1.payment AS 2003_payment,
    tb2.payment AS 2004_payment

FROM
    (SELECT customerNumber, SUM(amount) AS payment
    FROM payments
    WHERE YEAR(paymentDate) = 2003
    GROUP BY  customerNumber) AS tb1
JOIN
    (SELECT customerNumber,SUM(amount) AS payment
    FROM payments
    WHERE YEAR(paymentDate) = 2004
    GROUP BY customerNumber) AS tb2
    
ON tb1.customerNumber= tb2.customerNumber;

#27.Find the products sold in 2003 but not 2004.
select distinct productCode
from orderdetails
left join orders
on orders.orderNumber=orderdetails.orderNumber
where year(orders.orderDate)='2003' and 
year(orders.orderDate)!='2004';
#28. Find the customers without payments in 2003
select distinct customers.customerName
from customers
left join payments
on payments.customerNumber=customers.customerNumber
where year(payments.paymentDate)!='2003';



##Correlated subqueries     
#1.Who reports to Mary Patterson?
select employeeNumber 
from employees
where lastName='Patterson' and firstName='mary';
select employeeNumber,lastName,firstName,reportsTo
from employees
where reportsTo='1056';
#2.Which payments in any month and year are more than twice the average for that month and year (i.e. compare all payments in Oct 2004 with the average payment for Oct 2004)?
select p.checkNumber, p.amount, p.paymentDate
from (select  p.*, avg(p.amount) over (PARTITION by year(p.paymentDate), month(p.PaymentDate)) as avg_ym
      from Payments p) p
where p.paymentDate between '2004-10-01' and '2004-10-31' and
      p.amount > 2 * avg_ym;
#3.Report for each product, the percentage value of its stock on hand as a percentage of the stock on hand for product line to which it belongs.
select products.productCode,products.productName,
       round(products.quantityinStock/sum(products.quantityInStock)over(partition by products.productLine)*100,2) AS Percent
from Products 
order by products.productLine desc;
#4.For orders containing more than two products, report those products that constitute more than 50% of the value of the order.
select t2.productCode
from
(select orderNumber,sum(quantityOrdered*priceEach) as ordervalue,max(quantityOrdered*priceEach) as maxproductvalue
from orderdetails
group by orderNumber
having maxproductvalue >0.5*ordervalue
and maxproductvalue !=ordervalue) t1
left join 
(select orderNumber,productCode,quantityOrdered*priceEach as productvalue
from orderdetails) t2
on t1.orderNumber=t2.orderNumber
and t1.maxproductvalue=t2.productvalue;





