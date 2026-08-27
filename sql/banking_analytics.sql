Use banking_analytics;

select * from banking_master limit 10;

select transaction_id , transaction_datetime, amount, payment_method, region from banking_master limit 10;

select distinct payment_method from banking_master;

SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM banking_master;

select transaction_id, amount, transaction_status from banking_master where transaction_status="Failed";

select transaction_id, amount, customer_id from banking_master where amount>45000;

SELECT
    transaction_id,
    payment_method,
    amount
FROM banking_master
WHERE payment_method = 'UPI'
AND amount > 20000
AND transaction_status = 'Success';

SELECT
    transaction_id,
    payment_method,
    amount
FROM banking_master
WHERE payment_method = 'Credit Card'
OR payment_method = 'Debit Card';


SELECT
    transaction_id,
    amount
FROM banking_master
WHERE amount BETWEEN 5000 AND 15000;


SELECT DISTINCT customer_city
FROM banking_master
WHERE customer_city LIKE 'B%';

SELECT DISTINCT merchant_name
FROM banking_master
WHERE merchant_name LIKE '%Mart%';

SELECT
    transaction_id,
    customer_id,
    amount
FROM banking_master
ORDER BY amount DESC
LIMIT 10;


SELECT
    region,
    customer_id,
    amount
FROM banking_master
ORDER BY region ASC,
         amount DESC;

select transaction_id , amount, payment_method,transaction_status from banking_master where payment_method= "Credit Card" and transaction_status="Failed";


select DISTINCT customer_id, banking_master.name , annual_income from banking_master order by annual_income desc limit 15;

select customer_id , name from banking_master where city = "Mumbai";

select transaction_id, transaction_type, transaction_datetime, transaction_status from banking_master where amount between 10000 and 25000;

select distinct merchant_name, category, mcc_code from banking_master order by category asc, merchant_name asc;


select region,
    SUM(amount) AS total_revenue
FROM banking_master
GROUP BY region
ORDER BY total_revenue DESC;

SELECT
    payment_method,
    COUNT(*) AS total_transactions
FROM banking_master
GROUP BY payment_method
ORDER BY total_transactions DESC;


SELECT
    channel,
    ROUND(AVG(amount),2) AS avg_transaction
FROM banking_master
GROUP BY channel
ORDER BY avg_transaction DESC;

SELECT
    branch_name,
    SUM(amount) AS revenue
FROM banking_master
GROUP BY branch_name
ORDER BY revenue DESC
LIMIT 10;

SELECT
    occupation,
    COUNT(*) AS transactions,
    ROUND(SUM(amount),2) AS revenue,
    ROUND(AVG(amount),2) AS avg_spend
FROM banking_master
GROUP BY occupation
ORDER BY revenue DESC;

select 
	case 
		when age <25 Then '18-24'
        when age between 25 and 34 then '25-34'
        when age between 35 and 44 then '35-44'
        else '45+'
	end as age_group,
    count(distinct customer_id) as customers
from banking_master
group by age_group order by customers desc;


select region , sum(amount) as revenue from banking_master group by region having revenue >90000000 order by revenue desc;

select branch_name , count(*) as total_transactions from banking_master group by branch_name having total_transactions>4000 order by total_transactions desc;

SELECT
    category,

    COUNT(*) AS transactions,

    ROUND(SUM(amount),2) AS revenue,

    ROUND(AVG(amount),2) AS avg_transaction,

    MAX(amount) AS highest_transaction,

    MIN(amount) AS lowest_transaction

FROM banking_master

GROUP BY category

ORDER BY revenue DESC;


select region , sum(amount) as revenue from banking_master group by region order by revenue desc limit 5;

select payment_method, AVG(amount) as highest_average  from banking_master group by payment_method order by highest_average desc limit 1;

select occupation ,sum(amount) as total_revenue from banking_master group by occupation having total_revenue >2500000;

select branch_name , count(*) as successful_transactions from banking_master group by branch_name having successful_transactions >3500;


#Subqueries

 # Show all transactions whose amount is higher than the overall average.


SELECT
    transaction_id,
    customer_id,
    amount
FROM banking_master
WHERE amount >
(
    SELECT AVG(amount)
    FROM banking_master
)
ORDER BY amount DESC;

# Highest spending customer

# who made the highest total spending

SELECT
    customer_id,
    name,
    SUM(amount) AS total_spending
FROM banking_master
GROUP BY customer_id, name
HAVING total_spending =
(
    SELECT MAX(total_amount)
    FROM
    (
        SELECT customer_id,
               SUM(amount) AS total_amount
        FROM banking_master
        GROUP BY customer_id
    ) AS customer_totals
);


# Customers  Above their region
# Find customers whose transaction is above the average of their own region
# Concept - Correlated Subquery

SELECT
    customer_id,
    name,
    region,
    amount
FROM banking_master b1
WHERE amount >
(
    SELECT AVG(amount)
    FROM banking_master b2
    WHERE b1.region = b2.region
);


# Common Table Expression
# Top 10 Customers Using CTE
# Show the highest spending customers.

WITH customer_spending AS
(
    SELECT
        customer_id,
        name,
        SUM(amount) AS total_spending
    FROM banking_master
    GROUP BY customer_id, name
)

SELECT *
FROM customer_spending
ORDER BY total_spending DESC
LIMIT 10;

# Branch KPI Report 
# Instead of repeating calculations, create one CTE.

With branch_kpi as 
(
	select branch_name,
    count(*) as transactions,
    sum(amount) as revenue,
    avg(amount) as avg_transaction
from banking_master
group by branch_name
)
select * from branch_kpi order by revenue desc;


# Regional Ranking Preparation
WITH regional_revenue AS
(
    SELECT
        region,
        SUM(amount) AS revenue
    FROM banking_master
    GROUP BY region
)

SELECT *
FROM regional_revenue
ORDER BY revenue DESC;


# Find all transactions whose amount is greater than the maximum average payment method amount.

SELECT
    transaction_id,
    name,
    payment_method,
    amount
FROM banking_master
WHERE amount >
(
    SELECT MAX(avg_amount)
    FROM
    (
        SELECT
            payment_method,
            AVG(amount) AS avg_amount
        FROM banking_master
        GROUP BY payment_method
    ) AS payment_avg
)
ORDER BY amount DESC;

# Create a CTE called occupation_kpi containing:occupation,transactions,revenuea,avg_spend.Then display occupations ordered by revenue.

WITH occupation_kpi AS
(
    SELECT
        occupation,
        COUNT(*) AS transactions,
        SUM(amount) AS revenue,
        ROUND(AVG(amount),2) AS avg_spend
    FROM banking_master
    GROUP BY occupation
)

SELECT *
FROM occupation_kpi
ORDER BY revenue DESC;

# Peak Transaction Hours 


# WEEKEND VS WEEKDAY


# Monthly Trend revenue

SELECT
year,
month_no,
month,
ROUND(SUM(amount),2) AS revenue
FROM banking_master
GROUP BY year,month_no,month
ORDER BY year,month_no;

#Top 10 customers

WITH customer_spending AS
(
SELECT
customer_id,
name,
SUM(amount) AS total_spending
FROM banking_master
GROUP BY customer_id,name
)

SELECT *
FROM customer_spending
ORDER BY total_spending DESC
LIMIT 10;

#Regions above average

WITH region_avg AS
(
SELECT
region,
AVG(amount) AS avg_amount
FROM banking_master
GROUP BY region
)

SELECT
b.transaction_id,
b.customer_id,
b.name,
b.region,
b.amount,
ROUND(r.avg_amount,2) AS regional_average
FROM banking_master b
JOIN region_avg r
ON b.region=r.region
WHERE b.amount>r.avg_amount;


# Rank branches by revenue--Rank

WITH branch_revenue AS (
    SELECT
        branch_name,
        SUM(amount) AS revenue
    FROM banking_master
    GROUP BY branch_name
)

SELECT
    branch_name,
    revenue,
    RANK() OVER(ORDER BY revenue DESC) AS revenue_rank
FROM branch_revenue;

# Running Monthly Revenue

WITH monthly AS (
    SELECT
        year,
        month_no,
        month,
        SUM(amount) AS revenue
    FROM banking_master
    GROUP BY year, month_no, month
)

SELECT
    month,
    revenue,
    SUM(revenue) OVER(
        ORDER BY year, month_no
    ) AS cumulative_revenue
FROM monthly;

#Previous month comparison (LAG)

WITH monthly AS (
    SELECT
        year,
        month_no,
        month,
        SUM(amount) AS revenue
    FROM banking_master
    GROUP BY year, month_no, month
)

SELECT
    month,
    revenue,
    LAG(revenue) OVER(
        ORDER BY year, month_no
    ) AS previous_month,
    revenue - LAG(revenue) OVER(
        ORDER BY year, month_no
    ) AS growth
FROM monthly;


