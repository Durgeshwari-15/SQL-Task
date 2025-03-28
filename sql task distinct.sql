SELECT * FROM public.orders

select distinct city 
from customers


select distinct supplier_name
from products

select distinct payment_mode
from orders

select distinct category
from products p
join orders_items oi on p.product_id= oi. product_id


select distinct supplier_city 
from products

SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'orders';
