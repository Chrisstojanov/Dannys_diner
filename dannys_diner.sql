1.What is the total amount each customer spent at the restaurant?

select customer_id, Sum(price) as total_spend from dannys_diner.sales as S
inner join dannys_diner.menu as M on S.product_id = M.product_id
group by customer_id

--The query is selecting the "customer_id" and the sum of "price" for each customer in the sales table in the "dannys_diner" database.
--The data is being retrieved by joining the "sales" and "menu" tables in the "dannys_diner" database on the "product_id" column.
--Finally, the query groups the data by the "customer_id" column using the GROUP BY clause to display the total amount spent by each customer on the menu items purchased from the diner.


--Identify high-value customers and provide them with personalized offers to increase their loyalty and frequency of visits.



2.How many days has each customer visited the restaurant?

select customer_id, count(distinct order_date) as Visits from dannys_diner.sales
group by customer_id

--Segment customers by visit frequency and create targeted marketing campaigns to increase repeat visits. Also, monitor for any changes in visit frequency over time to identify potential issues or opportunities.


3.What was the first item from the menu purchased by each customer?

with cte AS(
select customer_id, 
order_date, 
product_name,
rank() over(
			partition by customer_id 
			ORDER BY  order_date asc) as rnk
from dannys_diner.sales as S
inner join dannys_diner.menu as M on S.product_id =  M.product_id)

select * from CTE
where rnk = 1

--The code defines a Common Table Expression (CTE) named "cte" that selects data from the "sales" and "menu" tables in the "dannys_diner" database.
--The query uses the RANK() function to rank the order dates of each menu item purchased by each customer in ascending order, partitioned by the customer_id.
--The query then selects all columns from the CTE where the rank is equal to 1, which represents the first item purchased by each customer.
--The code could be useful providing insights into customer preferences and trends.


--Analyze the most common first item purchases to identify potential upsell or cross-sell opportunities. For example, if many customers order a burger as their first item, 
--consider offering a combo meal deal that includes fries and a drink.


4.What is the most purchased item on the menu and how many times was it purchased by all customers?

select product_name, count(order_date) as orders
from dannys_diner.sales as S
inner join dannys_diner.menu as M on S.product_id = M.product_id
group by product_name
order by count(order_date) desc
limit 1

--The SQL code selects the "product_name" column from the "sales" and "menu" tables in the "dannys_diner" database and counts the number of orders for each product.
--The data is being retrieved by joining the "sales" and "menu" tables in the "dannys_diner" database on the "product_id" column.
--The query groups the data by "product_name" using the GROUP BY clause and sorts the result set in descending order by the count of orders using the ORDER BY clause.
--The LIMIT clause is used to restrict the result set to only the first row, which represents the product with the highest number of orders.
--This SQL code can be useful for identifying the most popular product in the "dannys_diner" database and gaining insights into customer preferences and behavior.


--Identify the most popular menu items to optimize inventory management and ensure availability. Additionally, consider offering promotions or discounts for these items to encourage more purchases.

5.Which item was the most popular for each customer?

with cte as (
	select 
	product_name,
	customer_id,
	rank () over (partition by customer_id order by  count(order_date) desc) as rnk
	from dannys_diner.sales as S
	inner join dannys_diner.menu as M on S.product_id = M.product_id 
	group by product_name,customer_id
)
select 
customer_id,
product_name 
from cte
where rnk = 1

--The SQL code defines a Common Table Expression (CTE) named "cte" that selects data from the "sales" and "menu" tables in the "dannys_diner" database.
--The query uses the RANK() function to rank the products purchased by each customer in descending order based on the count of orders for each product, partitioned by the customer_id.
--The query then selects the "customer_id" and "product_name" columns from the CTE where the rank is equal to 1, which represents the most purchased product by each customer.
--This SQL code can be useful for identifying the most popular product purchased by each customer in the "dannys_diner" database, which can provide insights into customer preferences and help with targeting marketing efforts towards specific customer segments.


--Use this data to create personalized marketing campaigns and offers that align with each customer's preferences. 
--For example, if a customer frequently orders the chicken sandwich, consider offering them a coupon for a free side dish to go with their next purchase.


6.Which item was purchased first by the customer after they became a member?

7.Which item was purchased just before the customer became a member?
8.What is the total items and amount spent for each member before they became a member?
9.If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
10.In the first week after a customer joins the program (including their join date) they earn 2x points on all items, 
not just sushi - how many points do customer A and B have at the end of January?