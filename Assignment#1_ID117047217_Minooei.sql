-- ***********************
-- Name: Parjad Minooei
-- ID: 117047217
-- Date: 2023-10-15
-- Purpose: Assignment #1 DBS311
-- ***********************


--Display the employee number, full employee name, job title, and hire date of all
--employees hired in September with the most recently hired employees displayed 
--first

Select employee_Id as "Employee Number", first_name || ', ' || last_name as "Full Name", job_title as "Job Title",  TO_CHAR(Hire_Date, 'Month') || ' ' || TO_CHAR(Hire_Date, 'DD') || 'th of year ' || TO_CHAR(Hire_Date, 'YYYY') as "Start Date"
from ASGM1_Employees
where Extract (MONTH from Hire_date) = 9
order by Hire_Date Desc;


--The company wants to see the total sale amount per sales person (salesman) for all
--orders, assume that online orders do not have any sale representative. for online
--orders(orders with no salesman ID), consider the salesman ID as 0. Display the
--salesman ID and the total sale amount for each employee.
--sort the result according to the employee number


Select NVL(s.Salesman_ID, 0) AS "Employee Number", TO_CHAR(sum(o.quantity * o.unit_Price), 'L999,999,999.00') as "Total Sale"
From ASGM1_Orders s 
Join ASGM1_Order_Items o 
on s.order_ID = o.order_ID 
Group by s.salesman_ID
Order by NVL(s.Salesman_ID, 0) asc;


--Display customer id, customer name, an total number of orders for customers that 
--the value of their customer ID is in values from 35 to 45. Include the cusomers with
--no orders in your report if their customer ID falls in the range 35 and 45.
--Sort the result by the value of total orders

Select NVL(c.Customer_ID, 0) as "Customer ID", c.name as Name, count(o.customer_ID) as "Total Orders"
From ASGM1_Customers c
left Join ASGM1_Orders o
ON c.customer_ID = o.customer_ID
Where c.Customer_ID Between 35 AND 45
Group by NVL(c.customer_ID, 0), c.name
order by count(o.customer_ID);


--Display Customer ID, Customer Name, and the order ID and the order date of all
--orders for customer whose ID is 44.
--  a. Show also the total qanity and the total amount of each customer's order.
--  b. sort the result from highest to lowest total order amount.


Select c.customer_ID as "Customer ID", c.Name as Name, o.order_ID as "Order Id", UPPER(to_char(o.order_date, 'dd-mon-yyyy')) as "Order Date", sum(i.quantity) as "Total Items", TO_CHAR(sum((i.unit_price * i.quantity)), 'L999,999,999.00') as "Total Amount"
From ASGM1_Customers c
join ASGM1_Orders o
on c.customer_ID = o.customer_ID
left Join ASGM1_Order_items i
on i.order_Id = o.order_Id
Where c.customer_ID = 44
Group by c.customer_ID, c.name, o.Order_Id, o.order_Date
order by sum((i.unit_price * i.quantity)) desc;



-- Display customer id, name, total number of orders, the total number of items
-- ordered, and the total order amount for customers who have more than 30 orders.
-- sort the result based on the total number of orders.

Select c.customer_ID as "Customer ID", c.name as Name, count(o.customer_ID) as "Total Number Of Orders", sum(i.quantity) as "Total Items", TO_CHAR(sum((i.unit_price * i.quantity)), 'L999,999,999.00') as "Total Amount"
from ASGM1_Customers c
join ASGM1_Orders o
on c.customer_ID = o.customer_ID
Join ASGM1_Order_items i
on i.order_Id = o.order_Id
group by c.customer_ID, c.name
Having count(o.customer_ID) > 30
Order By count(o.customer_ID);

