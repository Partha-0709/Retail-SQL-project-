/*  1 Customer Order Summary  
Retrieve a list of customers along with the total number of orders and total amount spent by each customer. Display only customers who placed more than 1 order.
*/

select c.customer_id , c.full_name ,sum(i.item_price) as total_amount ,count(distinct i.order_item_id) as total_orders
from customers c
join orders o on c.customer_id = o.customer_id
join order_items i on o.order_id = i.order_id 
group by c.customer_id ,c.full_name
having total_orders >1 
order by c.full_name ;

/* 2. Product Sales Report
List each product with the total quantity sold and the total revenue generated from that product. Include only products that have been sold at least once.
*/

select p.product_name as product_name, p.product_id as product_id ,sum(o.quantity) as total_quantity , sum(o.item_price) as total_revenue
from order_items o
join products p on o.product_id = p.product_id 
group by p.product_name , p.product_id  
having total_quantity >1  
order by product_name ;



 /* 3. City-wise Revenue
Show the total revenue generated per city by joining the customers, orders, and payments tables. Consider only successful payments. */


select c.city as city_name ,sum(i.item_price) as total_revenue , p.payment_status as payment_status
from customers c
join orders o on c.customer_id = o.customer_id
join order_items i on o.order_id = i.order_id 
join payments p on o.order_id = p.order_id 
where payment_status = 'success' 
group by city_name ,payment_status;

/* 4. Top 5 Highest Paying Customers
Find the top 5 customers who have spent the most overall. Display their name, email, and total amount spent. */

select c.full_name as customer_name , c.email as email , sum(o.total_amount) as total_amount
from customers c
join orders o on c.customer_id = o.customer_id  
group by customer_name ,email 
order by total_amount desc 
limit 5 ;

/* 5. Unsold Products
List all products that have never been included in any order. */

select distinct p.product_name as product_name , p.product_id as product_id  ,o.order_item_id as order_item_id 
from products p
left join order_items o on p.product_id = o.product_id 
where order_item_id is null ;

/* 6. Payment Status Breakdown
For each payment method, show how many payments were successful, failed, or pending. Sort the result by payment method.
*/ 

SELECT payment_method, payment_status, COUNT(payment_status) AS count
FROM payments
GROUP BY payment_method, payment_status
ORDER BY payment_method;

/*
7. Recent Orders with Item Details
Display the 10 most recent orders, including customer name, order date, product names, quantity, and item price. */

select c.full_name , p.product_name , o.order_date , i.quantity , i.item_price ,o.order_id 
from customers c
join orders o on c.customer_id = o.customer_id 
join order_items i on o.order_id = i.order_id 
join products p on i.product_id = p.product_id
WHERE o.order_id IN (
    SELECT order_id FROM (
        SELECT order_id 
        FROM orders 
        ORDER BY order_date DESC 
        LIMIT 10
    ) AS recent_orders
) 
order by order_date desc ,order_id ;

/*8. Low Stock Alert
List all products with stock quantity less than 10 that have also been sold in the past. */

select p.product_name ,p.stock_quantity ,i.order_id
from products p
join order_items i on p.product_id = i.product_id
where p.stock_quantity < 10 
and order_id is not null ;



/* 9. Order and Payment Mismatch
Find all orders that do not have a corresponding payment record. */ 


select o.order_id,o.customer_id,p.payment_method ,p.payment_id 
from orders o
left join payments p on o.order_id = p.order_id 
where p.payment_id is null ;

/* 10. Category-wise Sales Summary
Show the total quantity sold and total sales amount per product category. */

SELECT 
    p.product_name,
    p.product_id ,
    i.order_id,
    i.quantity,
    i.item_price,
    SUM(i.quantity) OVER (PARTITION BY p.product_id) AS total_quantity_sold_per_product,
    SUM(i.item_price) OVER (PARTITION BY p.product_id) AS total_revenue_per_product
FROM order_items i
JOIN products p ON i.product_id = p.product_id
ORDER BY p.product_name, i.order_id; 



 


