CREATE DATABASE project ;

use project ;


create table Customers (
customer_id	INT PRIMARY KEY ,
full_name VARCHAR(20)	,
email	VARCHAR(20)	,
city	VARCHAR(20)	,
registered_date	  DATE 
) ;

desc customers ;

create table Products (

prodcut_id INT PRIMARY KEY,
product_name varchar(20) ,
category varchar(20) ,
price  decimal(10,2) ,
stock_quanitiy INT ) ;

create table orders (
order_id INT primary KEY ,
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ,
order_date date ,
total_amount decimal(10,2) ) ;


desc orders ;

alter table products
change prodcut_id product_id INT ;

desc products ;

create table order_items(

order_item_id INT primary key ,
order_id int ,
foreign key(order_id) references orders(order_id),
product_id int ,
foreign key(product_id) references products(product_id),
quantity INT,
item_price decimal(10,2) ) ; 

desc order_items ;

create table payments (
payment_id INT PRIMARY KEY ,
order_id int ,
foreign key (order_id) references orders(order_id) ,
payment_date date ,
payment_method varchar(20),
payment_status varchar(20) );

desc payments ;

ALTER TABLE products CHANGE stock_quanitiy stock_quantity INT;

ALTER TABLE Customers
MODIFY full_name VARCHAR(40);

ALTER TABLE Customers
MODIFY email VARCHAR(40);

ALTER TABLE Customers
MODIFY city VARCHAR(40);

alter table products
modify product_name varchar(50) ;

alter table products
modify category varchar(50) ;

alter table payments
modify payment_method varchar(50) ;



