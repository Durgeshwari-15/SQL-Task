SELECT * FROM public.customers

Task1:
SELECT c.customer_name, c.city, o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2023;

Task2:
SELECT p.product_name, p.category, (oi.quantity * price) AS price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE c.city = 'Mumbai';

task3:
SELECT c.customer_name, o.order_date, SUM(oi.quantity * order_amount) AS order_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.payment_mode = 'Credit Card'
GROUP BY c.customer_name, o.order_date;

task4:
SELECT p.product_name, p.category, SUM(oi.quantity * price) AS price
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_date BETWEEN '2023-01-01' AND '2023-06-30'
GROUP BY p.product_name, p.category;


task5:
SELECT c.customer_name, SUM(oi.quantity) AS total_products_ordered
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name;

