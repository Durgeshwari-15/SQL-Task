SELECT * FROM customers
order by customer_name limit 10

select * from products
order by price desc limit 5

select order_id, order_date, customer_id 
from orders 
where order_date >= '2023-01-01' AND order_date <= '2023-12-31' 
order by order_date 
limit 5;


select distinct c.city 
from customers c
join orders o ON c.customer_id = o.customer_id
order by c.city 
limit 10 offset 10;
