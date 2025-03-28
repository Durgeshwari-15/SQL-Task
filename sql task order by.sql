SELECT * FROM public.orders_items


SELECT * FROM customers 
ORDER BY customer_name ASC;


select * from orders
order by order_amount desc;

select * from products
order by price asc, category desc

select order_id, customer_id, order_date from orders
order by order_date desc

select * from customer
SELECT c.city, COUNT(o.order_id) AS total_orders 
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY c.city ASC;
