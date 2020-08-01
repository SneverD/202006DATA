###EXAM 1

##1. Employees all over the world. Can you tell me the top three cities that we have employees?
select city, count(employeeNumber) as employee_count
from employees
left join offices
on offices.officeCode=employees.officeCode
group by employees.officeCode
order by  employee_count desc
limit 3;

##2.For company products, each product has inventory and buy price, msrp. Assume that every product is sold on msrp price. Can you write a query to tell company executives: profit margin on each productlines 
select productLine, avg((MSRP-buyPrice)/buyPrice) as profit_margin
from products
group by productLine;


##3.company wants to award the top 3 sales rep They look at who produces the most sales revenue.
#a)can you write a query to help find the employees. 
select salesRepEmployeeNumber, sum(quantityOrdered*priceEach) as revenue
from orders 
join orderdetails on orderdetails.orderNumber=orders.orderNumber
join customers on customers.customerNumber=orders.customerNumber
where status='shipped'
group by salesRepEmployeeNumber
order by revenue desc
limit 3;

#b)if we want to promote the employee to a manager, what do you think are the tables to be updated. 
delimiter $$
create procedure employee_promotion (in v_employeeNumber int)
begin
     update employees
	 set jobTitle='Sales Manager', reportsTo=(select employeeNumber from employees where jobTitle='VP Sales') 
	 where employeeNumber=v_employeeNumbe
end;
delimiter ;

#c)An employee is leaving the company, write a stored procedure to handle the case. 1). Make the current employee inactive, 2). Replaced with its manager employeenumber in order table. 
delimiter $$
create procedure employee_leaving (in v_employeeNumber int)
begin
update employees e,customers c
set e.jobTitle='inactive',e.reportsTo='inactive',e.officeCode='inactive',e.email='inactive',e.extension='inactive'
where e.employeeNumber=v_employeeNumber

select salesRepEmployeeNumber
replace (salesRepEmployeeNumber,v_employeeNumber,(select reportsTo from employees where employeeNumber=v_employeeNumber))
from customers
where salesRepEmployeeNumber=v_employeeNumber

end;
delimiter ;

##4. Ask to provide a table to show for each employee in a certain department how many times their Salary changes 
delimiter $$
create procedure salary_change (in v_department varchar(255))
begin
       select  e.employee_name, count(es.employee_id) as change_time
	   from employee e,employee_salary es
       where e.employee_id=es.employee_id and
             e.department_id = v_departmentr
	   group by e.employee_name;

end$$
delimiter ;

##5. Ask to provide a table to show for each department the top 3 salary with employee name and employee has not left the company.
select department_name,employee_name, current_salary
from department, employees
where department.department_id=employee.department_id
group by department_name
order by current_salary desc limit 3;



