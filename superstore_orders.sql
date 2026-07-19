--Level 1: Basic SELECT (Easy)
--1) Display all records from the table.
select * from superstore_orders

--2) Display only the columns:- Order ID, Customer Name and Sales
select order_id, customer_name, sales from superstore_orders

--3) Show the first 20 records.
select * from superstore_orders limit 20

--4) Find all unique categories.
select distinct category from superstore_orders

--5) Find all unique states.
select distinct state from superstore_orders

--6) Count the total number of orders.
select count(*) as total_orders from superstore_orders

--7) Count the number of unique customers.
select count(distinct customer_name) as total_customers from superstore_orders

--8) Display all orders where Sales > 500
select order_id from superstore_orders where sales>500

--9) Display all orders from the Technology category.
select * from superstore_orders where category='Technology'

--10) Display all orders shipped using "Second Class"
select * from superstore_orders where ship_mode='Second Class'

--Level 2: WHERE Clause
--11) Find orders where Profit is negative.
select * from superstore_orders where profit < 0

--12) Find products with Discount = 0.
select * from superstore_orders where discount= 0

--13) Display orders from California.
select * from superstore_orders where state= 'California'

--14) Find orders placed after 2017-01-01.
SELECT * FROM superstore_orders WHERE order_date < '2017-01-01'
-- Orders placed between 2016-01-01 and 2017-12-31
SELECT * FROM superstore_orders WHERE order_date >= '2016-01-01' AND order_date <= '2017-12-31'

--15) Find orders with Sales between 100 and 500.
select * from superstore_orders where sales>100 AND sales<500

--16) Find customers whose names start with "A".
select * from superstore_orders where customer_name LIKE 'A%'
/* LIKE is used for pattern matching and 'A%' means: A → The name starts with A. 
% → Zero or more characters can follow. */

--17) Find products whose names contain "don".
select * from superstore_orders where customer_name LIKE '%don%'
-- In PostgreSQL, ILIKE is often preferred over LIKE when searching names because it ignores uppercase/lowercase differences.

--18) Find orders from the South region.
select * from superstore_orders where region = 'South'

--19) Find orders where Sales > 1000 and Discount > 0.
select * from superstore_orders where sales > 1000 and Discount > 0

--20) Find orders where Quantity ≥ 5.
select * from superstore_orders where quantity >= 5

--Level 3: Sorting
--21) Show the top 10 highest sales.
select max(sales) from superstore_orders

--22) Show the lowest 10 profits.
select min(profit) from superstore_orders

--23) Sort customers alphabetically.
SELECT * FROM superstore_orders
ORDER BY customer_name ASC

--24) Sort orders by Order Date (newest first)
SELECT order_id FROM superstore_orders
ORDER BY order_date ASC

--25) Sort by Sales descending and Profit ascending.
SELECT sales, profit FROM superstore_orders
ORDER BY profit ASC, sales desc

--Level 4: Aggregate Functions
--26) Calculate total sales.
select sum(sales) from superstore_orders

--27) Calculate total profit.
select sum(profit) from superstore_orders

--28) Calculate average sales.
select avg(sales) from superstore_orders

--29) Find maximum profit.
select max(profit) from superstore_orders

--30) Find minimum sales.
select min(sales) from superstore_orders

--31) Count the number of products sold.
select count(distinct product_name) from superstore_orders

--32) Find average discount.
select avg(discount) from superstore_orders

--33) Find total quantity sold.
select sum(quantity) from superstore_orders

-- Level 5: GROUP BY
--34) Total sales by category.
SELECT
    category,
    SUM(sales) AS total_sales
FROM superstore_orders
GROUP BY category

--35) Total sales by region.
SELECT
    region,
    SUM(sales) AS total_sales
FROM superstore_orders
GROUP BY region

--36) Average profit by state.
SELECT
    state,
    AVG(profit) AS avg_profit
FROM superstore_orders
GROUP BY state

--37) Number of orders by ship mode.
SELECT
    ship_mode,
    count(order_id) AS no_of_order
FROM superstore_orders
GROUP BY ship_mode

--38) Total quantity by sub-category.
SELECT
    sub_category,
    SUM(quantity) AS total_quantity
FROM superstore_orders
GROUP BY sub_category

--39) Highest sales in each category.
SELECT
    category,
    MAX(sales) AS highest_sales_by_category
FROM superstore_orders
GROUP BY category

--40) Lowest profit by region.
SELECT
    region,
    MIN(profit) AS lowest_profit_by_region
FROM superstore_orders
GROUP BY region

--41) Count customers in each segment.
SELECT
    segment,
    count(customer_id) AS customers_in_each_segment
FROM superstore_orders
GROUP BY segment

--42) Total sales by year.
SELECT
    EXTRACT(YEAR FROM ship_date) AS order_year,
    SUM(sales) AS total_sales
FROM superstore_orders
GROUP BY EXTRACT(YEAR FROM ship_date)
ORDER BY order_year

--OR--
SELECT
    EXTRACT(YEAR FROM TO_DATE(order_date, 'MM/DD/YYYY')) AS order_year,
    SUM(sales) AS total_sales
FROM superstore_orders
GROUP BY EXTRACT(YEAR FROM TO_DATE(order_date, 'MM/DD/YYYY'))
ORDER BY order_year
--since order year is in text format.

--43) Total sales by month.
SELECT
    EXTRACT(MONTH FROM TO_DATE(order_date, 'MM/DD/YYYY')) AS order_month,
    SUM(sales) AS total_sales
FROM superstore_orders
GROUP BY EXTRACT(MONTH FROM TO_DATE(order_date, 'MM/DD/YYYY'))
ORDER BY order_month

--Level 6: HAVING
--44) Categories with sales greater than 100000.
/* To solve, we need to
a) Group the data by category.
b) Calculate the total sales for each category.
c) Filter the grouped results using HAVING.*/
SELECT
    category,
    SUM(sales) AS total_sales
FROM superstore_orders
GROUP BY category
HAVING SUM(sales) > 100000

--45) States having more than 100 orders.
SELECT
    state,
    COUNT(*) AS total_orders
FROM superstore_orders
GROUP BY state
HAVING COUNT(*) > 100
ORDER BY total_orders DESC

--46) Regions whose average profit is greater than 20.
SELECT
    region,
    AVG(profit) AS avg_profit
FROM superstore_orders
GROUP BY region
HAVING AVG(profit) > 20
ORDER BY avg_profit DESC

--47) Customers with purchases greater than 100.
SELECT
    customer_name,
    SUM(quantity) AS purchases
FROM superstore_orders
GROUP BY customer_name
HAVING SUM(quantity) > 100
ORDER BY purchases DESC
--48) Products sold more than 20 times.
SELECT
    product_name,
    SUM(quantity) AS sold
FROM superstore_orders
GROUP BY product_name
HAVING SUM(quantity) > 20
ORDER BY sold DESC

--Level 7: Date Functions
--49) Extract year from Order Date.
SELECT
    EXTRACT(YEAR FROM TO_DATE(order_date, 'MM/DD/YYYY')) AS order_month
FROM superstore_orders
LIMIT 50

--50) Extract month from Ship Date.
SELECT
    EXTRACT(MONTH FROM ship_date) AS ship_month
FROM superstore_orders
LIMIT 50

--51) Find orders shipped in December.
SELECT *
FROM superstore_orders
WHERE EXTRACT(MONTH FROM ship_date) = 12

--52) Number of orders per year.
SELECT COUNT(*) AS ordered_per_year,
       EXTRACT(YEAR FROM ship_date) AS ship_year
FROM superstore_orders
GROUP BY ship_year

--53) Number of orders per month.
SELECT COUNT(*) AS ordered_per_year,
       EXTRACT(MONTH FROM ship_date) AS ship_month
FROM superstore_orders
GROUP BY ship_month
ORDER BY ship_month ASC

--54) Find the oldest order.
SELECT *
FROM superstore_orders
ORDER BY order_date ASC
LIMIT 1
--OR--
SELECT *
FROM superstore_orders
WHERE order_date = (
    SELECT MIN(order_date)
    FROM superstore_orders
)

--55) Find the latest order.
SELECT *
FROM superstore_orders
ORDER BY order_date DESC
LIMIT 1
--OR--
SELECT *
FROM superstore_orders
WHERE order_date = (
    SELECT MAX(order_date)
    FROM superstore_orders
)

--56) Calculate shipping days.
SELECT
    order_id,
    TO_DATE(order_date, 'MM/DD/YYYY'),
    ship_date,
    ship_date - TO_DATE(order_date, 'MM/DD/YYYY') AS shipping_days
FROM superstore_orders

--57) Average shipping time by Ship Mode.
SELECT
    ship_mode,
    ROUND(AVG(ship_date - TO_DATE(order_date, 'MM/DD/YYYY')), 2) AS avg_shipping_days
FROM superstore_orders
GROUP BY ship_mode
ORDER BY avg_shipping_days

--58) Orders shipped within 2 days.
SELECT
    *,
    TO_DATE(order_date, 'MM/DD/YYYY'),
    ship_date,
    ship_date - TO_DATE(order_date, 'MM/DD/YYYY') AS shipping_days
FROM superstore_orders
WHERE ship_date - TO_DATE(order_date, 'MM/DD/YYYY')<=1

--Level 8: CASE Statement--
--59) Create a column:-High Sales (>1000), Medium Sales (500–1000) and Low Sales (<500)
SELECT
    order_id, customer_name, sales,
    CASE
        WHEN sales > 1000 THEN 'High Sales'
        WHEN sales >= 500 AND sales <= 1000 THEN 'Medium Sales'
        ELSE 'Low Sales'
    END AS sales_category
FROM superstore_orders

--60) Classify Profit as- Profit and Loss
SELECT
    order_id, customer_name, product_name, category, quantity, sales, profit,
    CASE
        WHEN profit > 0 THEN 'profit'
        ELSE 'loss'
    END AS profit_and_loss
FROM superstore_orders

--61) Classify Discount into- No Discount, Low, Medium and High
SELECT
    order_id, customer_name, product_name, category, quantity, discount,
    CASE
        WHEN discount = 0 THEN 'NO DISCOUNT'
		WHEN discount< 0.2 THEN 'LOW'
		WHEN discount<0.5 THEN 'MEDIUM'
        ELSE 'HIGH'
    END AS discount
FROM superstore_orders

-- Level 9: Window Functions--
-- 62) Rank products by sales.
SELECT
    product_name,
    SUM(sales) AS total_sales,
    RANK() OVER (ORDER BY SUM(sales) DESC) AS sales_rank
FROM superstore_orders
GROUP BY product_name
ORDER BY sales_rank

--63) Dense Rank customers by profit.
SELECT
    customer_name,
    SUM(profit) AS total_profit,
    DENSE_RANK() OVER (ORDER BY SUM(profit) DESC) AS profit_rank
FROM superstore_orders
GROUP BY customer_name
ORDER BY profit_rank;

--64) Running total of sales.
SELECT
    order_date,
    sales,
    SUM(sales) OVER (
        ORDER BY order_date
    ) AS running_total
FROM superstore_orders
ORDER BY order_date;

--65) Moving average of sales.
SELECT
    order_date,
    sales,
    AVG(sales) OVER (
        ORDER BY order_date
    ) AS MOVING_AVG_SALES
FROM superstore_orders
ORDER BY order_date;

--66) Previous order sales using LAG().
-- The LAG() window function returns the value from the previous row according to the order you specify.--
SELECT
    order_id,
    order_date,
    customer_name,
    sales,
    LAG(sales) OVER (ORDER BY order_date) AS previous_sales
FROM superstore_orders;

--67) Highest sale within each category.

SELECT
    category,
    MAX(sales) AS highest_sale
FROM superstore_orders
GROUP BY category
--This returns only the maximum sales value, not the corresponding product.
SELECT
    category,
    product_name,
    sales,
    RANK() OVER (PARTITION BY category ORDER BY sales DESC) AS sale_rank
FROM superstore_orders;
--it ranks every row within each category. So for Furniture, you'll see:

WITH ranked_sales AS (
    SELECT
        category,
        product_name,
        sales,
        RANK() OVER (PARTITION BY category ORDER BY sales DESC) AS sale_rank
    FROM superstore_orders
)
SELECT
    category,
    product_name,
    sales
FROM ranked_sales
WHERE sale_rank = 1;

--69) Top 3 products in every category
--Step 1: Calculate total sales for each product within each category
SELECT
    category,
    product_name,
    SUM(sales) AS total_sales
FROM superstore_orders
GROUP BY category, product_name;
--Step 2: Rank the products within each category
SELECT
    category,
    product_name,
    total_sales,
    ROW_NUMBER() OVER (
        PARTITION BY category
        ORDER BY total_sales DESC
    ) AS rn
FROM (
    SELECT
        category,
        product_name,
        SUM(sales) AS total_sales
    FROM superstore_orders
    GROUP BY category, product_name
) t;
--Step 3: Return only the Top 3
SELECT
    category,
    product_name,
    total_sales
FROM (
    SELECT
        category,
        product_name,
        SUM(sales) AS total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY SUM(sales) DESC
        ) AS rn
    FROM superstore_orders
    GROUP BY category, product_name
) ranked
WHERE rn <= 3
ORDER BY category, total_sales DESC;

--70) Percentage contribution of each region to total sales.
SELECT
    region,
    SUM(sales) AS total_sales,
    ROUND(
        SUM(sales) * 100.0 /
        (SELECT SUM(sales) FROM superstore_orders),
        2
    ) AS percentage_contribution
FROM superstore_orders
GROUP BY region
ORDER BY percentage_contribution DESC;

--Level 10: Subqueries--
--71) Find products with sales above average
SELECT 
	product_name FROM superstore_orders
where sales> (SELECT AVG(sales) FROM superstore_orders)
ORDER BY sales DESC

--72) Find customers who spent more than average.
SELECT
    customer_name,
    SUM(sales) AS total_spent
FROM superstore_orders
GROUP BY customer_name
HAVING SUM(sales) >
(
    SELECT AVG(total_sales)
    FROM
    (
        SELECT SUM(sales) AS total_sales
        FROM superstore_orders
        GROUP BY customer_name
    ) AS customer_sales
)
ORDER BY total_spent DESC;

--73) Find the category with maximum sales.
SELECT
    category,
    SUM(sales) AS total_sales
FROM superstore_orders
GROUP BY category
ORDER BY total_sales DESC
LIMIT 1
--Method 2 (Using a CTE)
WITH category_sales AS (
    SELECT
        category,
        SUM(sales) AS total_sales
    FROM superstore_orders
    GROUP BY category
)
SELECT *
FROM category_sales
ORDER BY total_sales DESC
LIMIT 1;
--Method 3 (Using a Subquery)
SELECT
    category,
    SUM(sales) AS total_sales
FROM superstore_orders
GROUP BY category
HAVING SUM(sales) = (
    SELECT MAX(total_sales)
    FROM (
        SELECT SUM(sales) AS total_sales
        FROM superstore_orders
        GROUP BY category
    ) AS t
);

--74) Find products having maximum profit.
SELECT
	product_name,
	SUM(profit) as total_profit
FROM superstore_orders
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 1;
--Method 2 (Using a CTE)
WITH product_profit AS (
    SELECT
        product_name,
        SUM(profit) AS total_profit
    FROM superstore_orders
    GROUP BY product_name
)
SELECT *
FROM product_profit
ORDER BY total_profit DESC
LIMIT 1;
--Method 3 (Using a Subquery)
SELECT
    product_name,
    SUM(profit) AS total_profit
FROM superstore_orders
GROUP BY product_name
HAVING SUM(profit) = (
    SELECT MAX(total_profit)
    FROM (
        SELECT SUM(profit) AS total_profit
        FROM superstore_orders
        GROUP BY product_name
    ) AS t
);

--75) Find second highest sale.
SELECT sales
FROM superstore_orders				--This works only if you want the second row. If the highest sale appears multiple times, it may not return the second distinct highest sale.
ORDER BY sales DESC
LIMIT 1 OFFSET 1 					--OFFSET 1 skips the highest sale.

--Method 2: Using MAX()
SELECT MAX(sales) AS second_highest_sale
FROM superstore_orders
WHERE sales < (
    SELECT MAX(sales)
    FROM superstore_orders
);

--76) Find top customer by profit.
SELECT customer_name, SUM(profit)
FROM superstore_orders
GROUP BY customer_name
ORDER BY SUM(profit) desc
LIMIT 1
--OR--
WITH customer_profit AS (
    SELECT
        customer_name,
        SUM(profit) AS total_profit
    FROM superstore_orders
    GROUP BY customer_name
)
SELECT *
FROM customer_profit
ORDER BY total_profit DESC
LIMIT 1;

--(Using a Subquery)
SELECT
    customer_name,
    SUM(profit) AS total_profit
FROM superstore_orders
GROUP BY customer_name
HAVING SUM(profit) = (
    SELECT MAX(total_profit)
    FROM (
        SELECT SUM(profit) AS total_profit
        FROM superstore_orders
        GROUP BY customer_name
    ) AS t
);

--77) Find states with sales above national average.
SELECT
    state,
    SUM(sales) AS total_sales
FROM superstore_orders
GROUP BY state
HAVING SUM(sales) > (
    SELECT AVG(total_sales)
    FROM (
        SELECT
            SUM(sales) AS total_sales
        FROM superstore_orders
        GROUP BY state
    ) AS state_sales
)
ORDER BY total_sales DESC;

--Level 11: CTEs- A CTE (Common Table Expression) makes the query easier to read by creating a temporary result set that you can query afterward.
--78) Calculate yearly sales using a CTE.
WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM TO_DATE(order_date, 'MM/DD/YYYY')) AS year,    -- The CTE yearly_sales calculates total sales for each year.
        SUM(sales) AS total_sales
    FROM superstore_orders
    GROUP BY EXTRACT(YEAR FROM TO_DATE(order_date, 'MM/DD/YYYY'))
)
SELECT *
FROM yearly_sales             --The outer query simply retrieves the CTE results.
ORDER BY year;

-- Solution (CTE with Additional Information)
WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM TO_DATE(order_date,'MM/DD/YYYY')) AS year,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        COUNT(order_id) AS total_orders
    FROM superstore_orders
    GROUP BY EXTRACT(YEAR FROM TO_DATE(order_date, 'MM/DD/YYYY'))
)
SELECT *
FROM yearly_sales
ORDER BY year;

--79) Find top 5 customers using a CTE.
--first calculate the total sales (or another metric) for each customer inside a CTE, then select the top 5.
WITH customer_sales AS (
    SELECT
        customer_name,
        SUM(sales) AS total_sales
    FROM superstore_orders
    GROUP BY customer_name
)
SELECT
    customer_name,
    total_sales
FROM customer_sales
ORDER BY total_sales DESC
LIMIT 5;

--Solution 2 (Top 5 Customers by Profit)-
WITH customer_profit AS (
    SELECT
        customer_name,
        SUM(profit) AS total_profit
    FROM superstore_orders
    GROUP BY customer_name
)
SELECT
    customer_name,
    total_profit
FROM customer_profit
ORDER BY total_profit DESC
LIMIT 5;

-- Solution 3 (Include Sales, Profit, and Number of Orders)
WITH customer_summary AS (
    SELECT
        customer_name,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        COUNT(order_id) AS total_orders
    FROM superstore_orders
    GROUP BY customer_name
)
SELECT *
FROM customer_summary
ORDER BY total_sales DESC
LIMIT 5;
--80) Find average sales per category using a CTE.
WITH category_sales AS (
    SELECT
        category,
        AVG(sales) AS average_sales
    FROM superstore_orders
    GROUP BY category
)
SELECT
    category,
    average_sales
FROM category_sales
ORDER BY average_sales DESC;

--81) Rank products inside a CTE.
WITH product_sales AS (
    SELECT
        product_name,
        SUM(sales) AS total_sales
    FROM superstore_orders
    GROUP BY product_name
)
SELECT
    product_name,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS product_rank
FROM product_sales
ORDER BY product_rank;

SELECT                      --rank products using a subquery (without a CTE)
    product_name,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS product_rank
FROM (
    SELECT
        product_name,
        SUM(sales) AS total_sales
    FROM superstore_orders
    GROUP BY product_name
) AS product_sales
ORDER BY product_rank;

--82) Calculate cumulative sales by year.
SELECT
    year,
    total_sales,
    SUM(total_sales) OVER (ORDER BY year) AS cumulative_sales
FROM (
    SELECT
        EXTRACT(YEAR FROM TO_DATE (order_date, 'MM,DD,YYYY')) AS year,
        SUM(sales) AS total_sales
    FROM superstore_orders
    GROUP BY EXTRACT(YEAR FROM TO_DATE(order_date, 'MM,DD,YYYY'))
) AS yearly_sales
ORDER BY year;

-- Solution 2 (Using a CTE)
WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM TO_DATE(order_date, 'MM,DD,YYYY')) AS year,
        SUM(sales) AS total_sales
    FROM superstore_orders
    GROUP BY EXTRACT(YEAR FROM TO_DATE(order_date, 'MM,DD,YYYY'))
)
SELECT
    year,
    total_sales,
    SUM(total_sales) OVER (ORDER BY year) AS cumulative_sales
FROM yearly_sales
ORDER BY year;

--Level 12: Advanced Analytics
--83) Find the most profitable state.
--Method 1
SELECT state, SUM(profit) AS total_profit FROM superstore_orders
GROUP BY state
ORDER BY total_profit DESC
LIMIT 1

--METHOD 2
SELECT
    state,
    SUM(profit) AS total_profit
FROM superstore_orders
GROUP BY state
HAVING SUM(profit) = (
    SELECT MAX(total_profit)
    FROM (
        SELECT
            SUM(profit) AS total_profit
        FROM superstore_orders
        GROUP BY state
    ) AS state_profit
);

-- Method 3 (Using a CTE)
WITH state_profit AS (
    SELECT
        state,
        SUM(profit) AS total_profit
    FROM superstore_orders
    GROUP BY state
)
SELECT *
FROM state_profit
ORDER BY total_profit DESC
LIMIT 1;

--84) Find the least profitable category.
SELECT category, sum(profit) as total_profit
from superstore_orders
GROUP BY category
ORDER BY total_profit ASC
LIMIT 1

--METHOD 2
SELECT
    category,
    SUM(profit) AS total_profit
FROM superstore_orders
GROUP BY category
HAVING SUM(profit) = (
    SELECT MIN(total_profit)
    FROM (
        SELECT
            SUM(profit) AS total_profit
        FROM superstore_orders
        GROUP BY category
    ) AS state_profit
);
-- Method 3 (Using a CTE)
WITH category_profit AS (
    SELECT
        category,
        SUM(profit) AS total_profit
    FROM superstore_orders
    GROUP BY category
)
SELECT *
FROM category_profit
ORDER BY total_profit ASC
LIMIT 1;

--85) Find top 10 customers
WITH customer_sales AS (
    SELECT
        customer_name,
        SUM(sales) AS total_sales
    FROM superstore_orders
    GROUP BY customer_name
)
SELECT
    customer_name,
    total_sales
FROM customer_sales
ORDER BY total_sales DESC
LIMIT 10;

--Solution 2 (Top 10 Customers by Profit)-
WITH customer_profit AS (
    SELECT
        customer_name,
        SUM(profit) AS total_profit
    FROM superstore_orders
    GROUP BY customer_name
)
SELECT
    customer_name,
    total_profit
FROM customer_profit
ORDER BY total_profit DESC
LIMIT 10;

-- Solution 3 (Include Sales, Profit, and Number of Orders)
WITH customer_summary AS (
    SELECT
        customer_name,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        COUNT(order_id) AS total_orders
    FROM superstore_orders
    GROUP BY customer_name
)
SELECT *
FROM customer_summary
ORDER BY total_sales DESC
LIMIT 10;

--86) Find bottom 10 products.
WITH product_summary AS (
    SELECT
        product_name,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        COUNT(order_id) AS total_orders
    FROM superstore_orders
    GROUP BY product_name
)
SELECT *
FROM product_summary
ORDER BY total_sales ASC
LIMIT 10;

--87) Which city generated the highest revenue?
SELECT
    city,
    SUM(sales) AS total_revenue
FROM superstore_orders
GROUP BY city
ORDER BY total_revenue DESC
LIMIT 1;

--Method 2 (Using a Subquery)
SELECT
    city,
    SUM(sales) AS total_revenue
FROM superstore_orders
GROUP BY city
HAVING SUM(sales) = (
    SELECT MAX(total_revenue)
    FROM (
        SELECT
            SUM(sales) AS total_revenue
        FROM superstore_orders
        GROUP BY city
    ) AS city_revenue
);

--Method 3 (Using a CTE)
WITH city_revenue AS (
    SELECT
        city,
        SUM(sales) AS total_revenue
    FROM superstore_orders
    GROUP BY city
)
SELECT *
FROM city_revenue
ORDER BY total_revenue DESC
LIMIT 1;

--88) Which sub-category has the highest average profit?
SELECT
    sub_category,
    AVG(profit) AS avg_profit
FROM superstore_orders
GROUP BY sub_category
ORDER BY avg_profit DESC
LIMIT 1;

--Method 2 (Using a Subquery)
SELECT
    sub_category,
    AVG(profit) AS average_profit
FROM superstore_orders
GROUP BY sub_category
HAVING AVG(profit) = (
    SELECT MAX(avg_profit)
    FROM (
        SELECT
            AVG(profit) AS avg_profit
        FROM superstore_orders
        GROUP BY sub_category
    ) AS subcategory_profit
);

--Method 3 (Using a CTE)
WITH subcategory_profit AS (
    SELECT
        sub_category,
        AVG(profit) AS average_profit
    FROM superstore_orders
    GROUP BY sub_category
)
SELECT *
FROM subcategory_profit
ORDER BY average_profit DESC
LIMIT 1;

--89) Which ship mode is fastest on average?
SELECT
    ship_mode,
    AVG(ship_date - TO_DATE(order_date, 'MM,DD,YYYY')) AS avg_delivery_days
FROM superstore_orders
GROUP BY ship_mode
ORDER BY avg_delivery_days
LIMIT 1;

--Method 2 (Using a Subquery)
SELECT
    ship_mode,
    AVG(ship_date -TO_DATE (order_date,'MM,DD,YYYY')) AS avg_delivery_days
FROM superstore_orders
GROUP BY ship_mode
HAVING AVG(ship_date -TO_DATE(order_date,'MM,DD,YYYY')) = (
    SELECT MIN(avg_days)
    FROM (
        SELECT
            AVG(ship_date - TO_DATE(order_date,'MM,DD,YYYY')) AS avg_days
        FROM superstore_orders
        GROUP BY ship_mode
    ) AS shipping_time
);

--Method 3 (Using a CTE)
WITH shipping_time AS (
    SELECT
        ship_mode,
        AVG(ship_date - TO_DATE(order_date,'MM,DD,YYYY')) AS avg_delivery_days
    FROM superstore_orders
    GROUP BY ship_mode
)
SELECT *
FROM shipping_time
ORDER BY avg_delivery_days
LIMIT 1;

-- 90) Find repeat customers.
SELECT
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM superstore_orders
GROUP BY customer_name
HAVING COUNT(DISTINCT order_id) > 1
ORDER BY total_orders DESC;
--Method 2 (Using a Subquery)
SELECT *
FROM (
    SELECT
        customer_name,
        COUNT(DISTINCT order_id) AS total_orders
    FROM superstore_orders
    GROUP BY customer_name
) AS customer_orders
WHERE total_orders > 1
ORDER BY total_orders DESC;

-- Method 3 (Using a CTE)
WITH customer_orders AS (
    SELECT
        customer_name,
        COUNT(DISTINCT order_id) AS total_orders
    FROM superstore_orders
    GROUP BY customer_name
)
SELECT *
FROM customer_orders
WHERE total_orders > 1
ORDER BY total_orders DESC;

--91) Find customers who purchased in multiple years.
SELECT
    customer_name,
    COUNT(DISTINCT EXTRACT(YEAR FROM TO_DATE(order_date,'MM,DD,YYYY'))) AS years_purchased
FROM superstore_orders
GROUP BY customer_name
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM TO_DATE(order_date,'MM,DD,YYYY'))) > 1
ORDER BY years_purchased DESC, customer_name;

--Method 2 (Using a Subquery)
SELECT *
FROM (
    SELECT
        customer_name,
        COUNT(DISTINCT EXTRACT(YEAR FROM TO_DATE(order_date,'MM,DD,YYYY'))) AS years_purchased
    FROM superstore_orders
    GROUP BY customer_name
) AS customer_years
WHERE years_purchased > 1
ORDER BY years_purchased DESC, customer_name;

--Method 3 (Using a CTE)
WITH customer_years AS (
    SELECT
        customer_name,
        COUNT(DISTINCT EXTRACT(YEAR FROM TO_DATE(order_date,'MM,DD,YYYY'))) AS years_purchased
    FROM superstore_orders
    GROUP BY customer_name
)
SELECT *
FROM customer_years
WHERE years_purchased > 1
ORDER BY years_purchased DESC, customer_name;

--92) Find monthly sales growth.
SELECT
    year,
    month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY year, month) AS previous_month_sales,
    total_sales - LAG(total_sales) OVER (ORDER BY year, month) AS sales_growth
FROM (
    SELECT
        EXTRACT(YEAR FROM TO_DATE(order_date,'MM,DD,YYYY')) AS year,
        EXTRACT(MONTH FROM TO_DATE(order_date,'MM,DD,YYYY')) AS month,
        SUM(sales) AS total_sales
    FROM superstore_orders
    GROUP BY
        EXTRACT(YEAR FROM TO_DATE(order_date,'MM,DD,YYYY')),
        EXTRACT(MONTH FROM TO_DATE(order_date,'MM,DD,YYYY'))
) AS monthly_sales
ORDER BY year, month;

--Method 2: Monthly Growth Percentage
SELECT
    year,
    month,
    total_sales,
    ROUND(
        (
            (total_sales - LAG(total_sales) OVER (ORDER BY year, month))
            / LAG(total_sales) OVER (ORDER BY year, month)
        ) * 100,
        2
    ) AS growth_percent
FROM (
    SELECT
        EXTRACT(YEAR FROM TO_DATE(order_date,'MM,DD,YYYY')) AS year,
        EXTRACT(MONTH FROM TO_DATE(order_date,'MM,DD,YYYY')) AS month,
        SUM(sales) AS total_sales
    FROM superstore_orders
    GROUP BY
        EXTRACT(YEAR FROM TO_DATE(order_date,'MM,DD,YYYY')),
        EXTRACT(MONTH FROM TO_DATE(order_date,'MM,DD,YYYY'))
) AS monthly_sales
ORDER BY year, month;

--93) Find yearly profit growth.
SELECT
    year,
    month,
    total_profit,
    LAG(total_profit) OVER (ORDER BY year, month) AS previous_month_profit,
    total_profit - LAG(total_profit) OVER (ORDER BY year, month) AS profit_growth
FROM (
    SELECT
        EXTRACT(YEAR FROM TO_DATE(order_date,'MM,DD,YYYY')) AS year,
        EXTRACT(MONTH FROM TO_DATE(order_date,'MM,DD,YYYY')) AS month,
        SUM(profit) AS total_profit
    FROM superstore_orders
    GROUP BY
        EXTRACT(YEAR FROM TO_DATE(order_date,'MM,DD,YYYY')),
        EXTRACT(MONTH FROM TO_DATE(order_date,'MM,DD,YYYY'))
) AS monthly_profit
ORDER BY year, month;

--Method 2: Monthly Growth Percentage
SELECT
    year,
    month,
    total_profit,
    ROUND(
        (
            (total_profit - LAG(total_profit) OVER (ORDER BY year, month))
            / LAG(total_profit) OVER (ORDER BY year, month)
        ) * 100,
        2
    ) AS growth_percent
FROM (
    SELECT
        EXTRACT(YEAR FROM TO_DATE(order_date,'MM,DD,YYYY')) AS year,
        EXTRACT(MONTH FROM TO_DATE(order_date,'MM,DD,YYYY')) AS month,
        SUM(sales) AS total_profit
    FROM superstore_orders
    GROUP BY
        EXTRACT(YEAR FROM TO_DATE(order_date,'MM,DD,YYYY')),
        EXTRACT(MONTH FROM TO_DATE(order_date,'MM,DD,YYYY'))
) AS monthly_profit
ORDER BY year, month;

--94) Find top-selling product in each region.
SELECT
    region,
    product_name,
    total_sales
FROM (
    SELECT
        region,
        product_name,
        SUM(sales) AS total_sales,
        RANK() OVER (
            PARTITION BY region
            ORDER BY SUM(sales) DESC
        ) AS rnk
    FROM superstore_orders
    GROUP BY region, product_name
) AS ranked_products
WHERE rnk = 1;

-- Method 2 (Using ROW_NUMBER())
--This returns exactly one product per region, even if there is a tie.
SELECT
    region,
    product_name,
    total_sales
FROM (
    SELECT
        region,
        product_name,
        SUM(sales) AS total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY SUM(sales) DESC
        ) AS rn
    FROM superstore_orders
    GROUP BY region, product_name
) AS ranked_products
WHERE rn = 1;

-- Method 3 (Using a CTE)
WITH product_sales AS (
    SELECT
        region,
        product_name,
        SUM(sales) AS total_sales,
        RANK() OVER (
            PARTITION BY region
            ORDER BY SUM(sales) DESC
        ) AS rnk
    FROM superstore_orders
    GROUP BY region, product_name
)
SELECT
    region,
    product_name,
    total_sales
FROM product_sales
WHERE rnk = 1;
--95) Find the percentage of total sales contributed by each category.
SELECT
    category,
    SUM(sales) AS category_sales,
    ROUND(
        (SUM(sales) * 100.0) /
        (SELECT SUM(sales) FROM superstore_orders),
        2
    ) AS sales_percentage
FROM superstore_orders
GROUP BY category
ORDER BY sales_percentage DESC;

--Method 2 (Using a CTE)
WITH category_sales AS (
    SELECT
        category,
        SUM(sales) AS total_sales
    FROM superstore_orders
    GROUP BY category
)
SELECT
    category,
    total_sales,
    ROUND(
        (total_sales * 100.0) /
        (SELECT SUM(total_sales) FROM category_sales),
        2
    ) AS sales_percentage
FROM category_sales
ORDER BY sales_percentage DESC;
--Method 3 (Using a Window Function)
SELECT
    category,
    SUM(sales) AS category_sales,
    ROUND(
        SUM(sales) * 100.0 /
        SUM(SUM(sales)) OVER (),
        2
    ) AS sales_percentage
FROM superstore_orders
GROUP BY category
ORDER BY sales_percentage DESC;

--96) Find products responsible for 80% of sales (Pareto Analysis).

WITH product_sales AS (
    SELECT
        product_name,
        SUM(sales) AS total_sales
    FROM superstore_orders
    GROUP BY product_name
),
pareto AS (
    SELECT
        product_name,
        total_sales,
        SUM(total_sales) OVER (
            ORDER BY total_sales DESC
        ) AS cumulative_sales,
        SUM(total_sales) OVER () AS overall_sales
    FROM product_sales
)
SELECT
    product_name,
    total_sales,
    cumulative_sales,
    ROUND(cumulative_sales * 100.0 / overall_sales, 2) AS cumulative_percentage
FROM pareto
WHERE cumulative_sales <= overall_sales * 0.80
ORDER BY total_sales DESC;

-- Method 2 (Show All Products with Pareto Percentage)
WITH product_sales AS (
    SELECT
        product_name,
        SUM(sales) AS total_sales
    FROM superstore_orders
    GROUP BY product_name
)
SELECT
    product_name,
    total_sales,
    SUM(total_sales) OVER (
        ORDER BY total_sales DESC
    ) AS cumulative_sales,
    ROUND(
        SUM(total_sales) OVER (
            ORDER BY total_sales DESC
        ) * 100.0 /
        SUM(total_sales) OVER (),
        2
    ) AS cumulative_percentage
FROM product_sales
ORDER BY total_sales DESC;

--97) Identify outlier sales using Z-score or IQR logic.
-- A sale is considered an outlier if: Z-score > 3 or Z-score < -3
WITH stats AS (
    SELECT
        AVG(sales) AS mean_sales,
        STDDEV(sales) AS std_sales
    FROM superstore_orders
)
SELECT
    order_id,
    product_name,
    sales,
    ROUND(
        (sales - mean_sales) / std_sales,
        2
    ) AS z_score
FROM superstore_orders
CROSS JOIN stats
WHERE ABS((sales - mean_sales) / std_sales) > 3
ORDER BY z_score DESC;

--Method 2 (Recommended for Skewed Data): IQR Method
--The Interquartile Range (IQR) method is more robust because it is not affected much by extreme values.

WITH quartiles AS (
    SELECT
        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY sales) AS q1,
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY sales) AS q3
    FROM superstore_orders
)
SELECT
    order_id,
    product_name,
    sales
FROM superstore_orders
CROSS JOIN quartiles
WHERE sales < (q1 - 1.5 * (q3 - q1))
   OR sales > (q3 + 1.5 * (q3 - q1))
ORDER BY sales DESC;

--98) Find the longest shipping delay.
--calculate the difference between ship_date and order_date, then find the maximum delay.
SELECT
    order_id,
    customer_name,
    product_name,
    order_date,
    ship_date,
    (ship_date - to_date(order_date, 'mm,dd,yyyy')) AS shipping_delay
FROM superstore_orders
ORDER BY shipping_delay DESC
LIMIT 1;

-- Method 2 (Using a Subquery)
SELECT
    order_id,
    customer_name,
    product_name,
    order_date,
    ship_date,
    (ship_date - to_date(order_date,'mm,dd,yyyy')) AS shipping_delay
FROM superstore_orders
WHERE (ship_date - to_date(order_date,'mm,dd,yyyy')) = (
    SELECT MAX(ship_date - to_date(order_date,'mm,dd,yyyy'))
    FROM superstore_orders
);

--Method 3 (Using a CTE)
WITH shipping_time AS (
    SELECT
        order_id,
        customer_name,
        product_name,
        to_date(order_date,'mm,dd,yyyy'),
        ship_date,
        (ship_date - to_date(order_date,'mm,dd,yyyy')) AS shipping_delay
    FROM superstore_orders
)
SELECT *
FROM shipping_time
ORDER BY shipping_delay DESC
LIMIT 1;

--Method 4 (Using RANK())

SELECT
    order_id,
    customer_name,
    product_name,
    order_date,
    ship_date,
    shipping_delay
FROM (
    SELECT
        order_id,
        customer_name,
        product_name,
        TO_DATE(order_date, 'MM,DD,YYYY') AS order_date,
        ship_date,
        ship_date - TO_DATE(order_date, 'MM,DD,YYYY') AS shipping_delay,
        RANK() OVER (
            ORDER BY ship_date - TO_DATE(order_date, 'MM,DD,YYYY') DESC
        ) AS rnk
    FROM superstore_orders
) AS ranked_orders
WHERE rnk = 1;

--99) Build an RFM (Recency, Frequency, Monetary) analysis using SQL.
/*Recency (R): Days since the customer's last purchase.
Frequency (F): Number of orders placed by the customer.
Monetary (M): Total amount spent by the customer.*/
WITH rfm AS (
    SELECT
        customer_name,

        MAX(TO_DATE(order_date,'MM,DD,YYYY')) AS last_order_date,

        (
            SELECT MAX(TO_DATE(order_date,'MM,DD,YYYY'))
            FROM superstore_orders
        ) - MAX(TO_DATE(order_date,'MM,DD,YYYY')) AS recency,

        COUNT(DISTINCT order_id) AS frequency,

        ROUND(SUM(sales),2) AS monetary

    FROM superstore_orders
    GROUP BY customer_name
)

SELECT *
FROM rfm
ORDER BY monetary DESC;

--Method 2 (RFM Score using NTILE)
--This is the version most commonly used in customer segmentation.
WITH rfm AS (
    SELECT
        customer_name,
        (
            SELECT MAX(TO_DATE(order_date,'MM,DD,YYYY'))
            FROM superstore_orders
        ) - MAX(TO_DATE(order_date,'MM,DD,YYYY')) AS recency,
        COUNT(DISTINCT order_id) AS frequency,
        SUM(sales) AS monetary
    FROM superstore_orders
    GROUP BY customer_name
)

SELECT
    customer_name,
    recency,
    frequency,
    monetary,

    NTILE(5) OVER (ORDER BY recency ASC) AS r_score,

    NTILE(5) OVER (ORDER BY frequency DESC) AS f_score,

    NTILE(5) OVER (ORDER BY monetary DESC) AS m_score

FROM rfm;

 --100) Write a sales dashboard query showing:Year, Month, Category, Sales, Profit, Orders, Running Total, Growth % and Rank
 WITH monthly_sales AS (
    SELECT
        EXTRACT(YEAR FROM TO_DATE(order_date,'MM,DD,YYYY')) AS year,
        EXTRACT(MONTH FROM TO_DATE(order_date,'MM,DD,YYYY')) AS month,
        category,

        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        COUNT(DISTINCT order_id) AS total_orders

    FROM superstore_orders
    GROUP BY
        EXTRACT(YEAR FROM TO_DATE(order_date,'MM,DD,YYYY')),
        EXTRACT(MONTH FROM TO_DATE(order_date,'MM,DD,YYYY')),
        category
)

SELECT

    year,
    month,
    category,

    total_sales,
    total_profit,
    total_orders,

    SUM(total_sales) OVER(
        ORDER BY year,month
    ) AS running_total,

    ROUND(
        (
            total_sales -
            LAG(total_sales) OVER(
                ORDER BY year,month
            )
        )*100.0/
        LAG(total_sales) OVER(
            ORDER BY year,month
        ),
        2
    ) AS growth_percent,

    RANK() OVER(
        PARTITION BY year,month
        ORDER BY total_sales DESC
    ) AS sales_rank

FROM monthly_sales

ORDER BY
year,
month,
sales_rank;
select * from superstore_orders