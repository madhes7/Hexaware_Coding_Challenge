create database ECDB;
use ECDB;


create   table customers(
 customer_id INT Primary Key Identity(1,1),
 first_name varchar(30) Not Null,
 last_name varchar(30),
 email varchar(225) Unique Not Null,
 password VARCHAR(20) NOT NULL DEFAULT 'password123'
);


create table products(
 product_id Int Primary Key Identity(1,1),
 [name] varchar(30) Not null,
 price Money Not Null,
 [description] Text,
 stockQuantity Int not null);


 create table cart(
 cart_id Int Primary Key Identity(1,1),
 customer_id Int  Not null,
 product_id Int Not null,
 quantity Int Not Null,
 Constraint FK_Cart_Customer Foreign Key (customer_id) References Customers(customer_id)On Delete CasCade On Update CasCade,
 Constraint FK_Cart_Products Foreign Key (product_id) References products(product_id) On Delete CasCade On Update CasCade );

 create table orders(
 order_id Int Primary Key Identity (1,1),
 customer_id Int Not Null,
 order_date Date Not Null,
 total_price Money Not Null,
 shipping_address Text ,
 Constraint FK_orders_Customer Foreign Key (customer_id) References Customers(customer_id) On Delete CasCade On Update CasCade
 );

 create table order_items(
 order_item_id Int Primary Key Identity(1,1),
 order_id Int Not null,
 product_id Int Not Null ,
 quantity Int Not Null,
 itemAmount Money,
 Constraint FK_OI_Order Foreign Key (order_id) References Orders(order_id) On Delete CasCade On Update CasCade,
  Constraint FK_OI_Product Foreign Key (Product_id) References Products(Product_id) On Delete CasCade On Update CasCade
 );


 Insert into products(name,Description,price ,stockQuantity) values
 ('Laptop','High-performance laptop',800.00,10),
 ('Smartphone', 'Latest smartphone', 600.00, 15),
('Tablet', 'Portable tablet', 300.00, 20),
('Headphones', 'Noise-canceling', 150.00, 30),
('TV', '4K Smart TV', 900.00, 5),
('Coffee Maker', 'Automatic coffee maker', 50.00, 25),
('Refrigerator', 'Energy-efficient', 700.00, 10),
('Microwave Oven', 'Countertop microwave', 80.00, 15),
('Blender', 'High-speed blender', 70.00, 20),
('Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10); 

select * from products




INSERT INTO customers (first_name, last_name, email) VALUES
('John', 'Doe', 'johndoe@example.com'),
('Jane', 'Smith', 'janesmith@example.com'),
('Robert', 'Johnson', 'robert@example.com'),
('Sarah', 'Brown', 'sarah@example.com'),
('David', 'Lee', 'david@example.com'),
('Laura', 'Hall', 'laura@example.com'),
('Michael', 'Davis', 'michael@example.com'),
('Emma', 'Wilson', 'emma@example.com'),
('William', 'Taylor', 'william@example.com'),
('Olivia', 'Adams', 'olivia@example.com');

select * from customers;


INSERT INTO orders (customer_id, order_date, total_price) VALUES
(1, '2023-01-05', 1200.00),
(2, '2023-02-10', 900.00),
(3, '2023-03-15', 300.00),
(4, '2023-04-20', 150.00),
(5, '2023-05-25', 1800.00),
(6, '2023-06-30', 400.00),
(7, '2023-07-05', 700.00),
(8, '2023-08-10', 160.00),
(9, '2023-09-15', 140.00),
(10, '2023-10-20', 1400.00);

select * from orders;

INSERT INTO order_items (order_id, product_id, quantity, itemAmount) VALUES
(1, 1, 2, 1600.00),
(1, 3, 1, 300.00),
(2, 2, 3, 1800.00),
(3, 5, 2, 1800.00),
(4, 4, 4, 600.00),
(4, 6, 1, 50.00),
(5, 1, 1, 800.00),
(5, 2, 2, 1200.00),
(6, 10, 2, 240.00),
(6, 9, 3, 210.00);

select * from order_items;


INSERT INTO cart (customer_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 3),
(3, 4, 4),
(3, 5, 2),
(4, 6, 1),
(5, 1, 1),
(6, 10, 2),
(6, 9, 3),
(7, 7, 2);

select * from cart;

--1. Update refrigerator product price to 800--

Update products set price=800 where name='Refrigerator';

--2. Remove all cart items for a specific customer.--

Delete from cart where customer_id=3;
select * from cart;

--3. Retrieve Products Priced Below $100.--

Select * from products where price<= 100;

--4. Find Products with Stock Quantity Greater Than 5.--

Select * from products where stockQuantity > 5;

-- 5. Retrieve Orders with Total Amount Between $500 and $1000.--

Select * from orders where total_price between 500 And 1000;

--6. Find Products which name end with letter ‘r’.--

Select * from products where [name] like '%r';

--7. Retrieve Cart Items for Customer 5.--

select * from cart where customer_id=5 ;

--8. Find Customers Who Placed Orders in 2023.--


select c.customer_id ,CONCAT_WS(' ',c.first_name,c.last_name) As Name from customers c
Left Join orders o On c.customer_id=o.customer_id 
where Year(o.order_date)=2023 
group by c.customer_id,c.first_name,c.last_name;

--9. Determine the Minimum Stock Quantity for Each Product Category.--

select product_id,Min(stockQuantity) As Min_Quantity from products
Group by product_id;

--10. Calculate the Total Amount Spent by Each Customer.--

select c.customer_id ,CONCAT_WS(' ',c.first_name,c.last_name) As [Name] , Sum(o.total_price) As Amt_Spend from customers c
Left Join orders o On c.customer_id=o.customer_id 
group by c.customer_id,c.first_name,c.last_name;

--11. Find the Average Order Amount for Each Customer.--
select 
  c.customer_id ,
  CONCAT_WS(' ',c.first_name,c.last_name) As [Name] , 
  Avg(o.total_price) As Avg_Amt 
from customers c
Left Join orders o On c.customer_id=o.customer_id 
group by c.customer_id,c.first_name,c.last_name;

--12. Count the Number of Orders Placed by Each Customer.--

select 
  c.customer_id ,
  CONCAT_WS(' ',c.first_name,c.last_name) As [Name] , 
  Count(o.order_id) As Count_Orders
from customers c
Left Join orders o On c.customer_id=o.customer_id 
group by c.customer_id,c.first_name,c.last_name;


--13. Find the Maximum Order Amount for Each Customer.--

select 
  c.customer_id ,
  CONCAT_WS(' ',c.first_name,c.last_name) As [Name] , 
  Max(o.total_price) As Max_Order
from customers c
Left Join orders o On c.customer_id=o.customer_id 
group by c.customer_id,c.first_name,c.last_name 
Order By Max(o.total_price) desc;

--14. Get Customers Who Placed Orders Totaling Over $1000--

select 
  c.customer_id ,
  CONCAT_WS(' ',c.first_name,c.last_name) As [Name] , 
  Sum(o.total_price) As Sum_Amt 
from customers c
Left Join orders o On c.customer_id=o.customer_id 
group by c.customer_id,c.first_name,c.last_name
having Sum(o.total_price) > 1000;

--15. Subquery to Find Products Not in the Cart.--

Select * from products 
where product_id Not In (select product_id from cart group by product_id);

--16. Subquery to Find Customers Who Haven't Placed Orders. --

Select * from customers 
where customer_id Not In (Select customer_id from orders group by customer_id);



--18. Subquery to Find Products with Low Stock.--

Select * from products 
where stockQuantity =( select Min(stockQuantity) from products) ;

--19. Subquery to Find Customers Who Placed High-Value Orders.--

SELECT DISTINCT c.customer_id, 
       CONCAT_WS(' ', c.first_name, c.last_name) AS [Name]
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.total_price > (SELECT AVG(total_price) FROM orders);

