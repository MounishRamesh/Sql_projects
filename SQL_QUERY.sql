-- sql Reatail sales Analysis
-- create table
drop table if exists retail_sales ;
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

SELECT * FROM retail_sales 
LIMIT 10 ;

SELECT count(*) from retail_sales ;


SELECT * FROM retail_sales
WHERE TRANSACTIONS_ID IS NULL 
or sale_date IS NULL
OR SALE_TIME IS NULL
OR GENDER IS NULL
OR CATEGORY IS NULL
OR QUANTIY IS NULL
OR COGS IS NULL
OR PRICE_PER_UNIT IS NULL
OR TOTAL_SALE IS NULL;

DELETE FROM RETAIL_SALES
WHERE TRANSACTIONS_ID IS NULL 
or sale_date IS NULL
OR SALE_TIME IS NULL
OR GENDER IS NULL
OR CATEGORY IS NULL
OR QUANTIY IS NULL
OR COGS IS NULL
OR PRICE_PER_UNIT IS NULL
OR TOTAL_SALE IS NULL;

-- DATA EXPLORATION 
-- HOW MANY SALES WE HAVE 
select COUNT(*) AS Total_sales from retail_sales

-- How many customers you have ?
select COUNT(DISTINCT CUSTOMER_ID) AS Total_sales from retail_sales

select DISTINCT CATEGORY from retail_sales

-- DATA ANALYSIS
-- Q1 write a sql query to retrive all columns for sales made on '2022-11-05'
select * from retail_sales
where sale_date = '2022-11-05' ;

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022 


SELECT *  FROM RETAIL_SALES
WHERE CATEGORY = 'Clothing'
AND TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
AND QUANTIY >= 3

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
        CATEGORY ,  
		SUM(TOTAL_SALE) AS NEW_SALES , 
		COUNT(*) AS TOTAL_ORDERS
FROM RETAIL_SALES
GROUP BY 1
--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age),1) AS AVERAGE_AGES
FROM RETAIL_SALEs
WHERE CATEGORY = 'Beauty'

--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000
SELECT * FROM RETAIL_SALES
WHERE(TOTAL_SALE > 1000)

--Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
      CATEGORY , 
	  GENDER ,
	  COUNT(*) AS TOTAL_TRANS
	  FROM RETAIL_SALES
	  GROUP BY 
	  CATEGORY , GENDER
--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT * FROM (
SELECT 
    EXTRACT(YEAR FROM SALE_DATE) AS YEAR, 
	EXTRACT(MONTH FROM SALE_DATE) AS MONTH, 
	AVG(TOTAL_SALE) AS AVG_SALE ,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM SALE_DATE) ORDER BY AVG(TOTAL_SALE)DESC) AS RANK
FROM RETAIL_SALES 
GROUP BY 1,2 ) AS t1 
where rank = 1
--ORDER BY 1 ,3 DESC
--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
select CUSTOMER_ID ,SUM(total_sale) as total_sales
frOm RETAIL_SALES
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT CATEGORY, COUNT(DISTINCT CUSTOMER_ID) AS UNIQUE_CUSTOMERS
FROM RETAIL_SALES
GROUP BY CATEGORY

--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS(
SELECT * ,
   CASE 
      WHEN EXTRACT(HOUR FROM SALE_TIME) < 12 THEN 'Morning'
	  WHEN EXTRACT (HOUR FROM SALE_TIME) BETWEEN 12 AND 17 THEN 'Afternoon'
	  ELSE 'Evening'
	END AS SHIFT
FROM RETAIL_SALES
)
SELECT 
     SHIFT ,
     COUNT(*) AS TOTAL_ORDERS
FROM hourly_sale
GROUP BY SHIFT
-- END OF PROJECT




