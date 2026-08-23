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



    