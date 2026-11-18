SELECT *
FROM bright_coffee_shop.sales_analysis.coffee_shop
LIMIT 10;

SELECT 
     transaction_id,
     CAST(REPLACE(unit_price, ',','.') AS DOUBLE) AS Unit_price
FROM bright_coffee_shop.sales_analysis.coffee_shop;

-- Count total number of records from the coffe shop table?( our total records 149116)
SELECT COUNT(*) AS total_records
FROM bright_coffee_shop.sales_analysis.coffee_shop;

-- check for duplicates(It must be on a row basis, and not column-basis).

SELECT *,
    COUNT(*) AS duplicate_count
FROM bright_coffee_shop.sales_analysis.coffee_shop
GROUP BY ALL
HAVING COUNT(*) > 1;-- No duplicates found

-- Count the NULL (missing) values in the transaction_id column of the coffee_shop table.
SELECT *
FROM bright_coffee_shop.sales_analysis.coffee_shop
WHERE transaction_id IS NULL OR 
      transaction_date IS NULL OR
      transaction_time IS NULL OR 
      transaction_qty IS NULL OR 
      store_id IS NULL OR
      store_location IS NULL OR
      product_id IS NULL OR
      unit_price IS NULL OR 
      product_category IS NULL OR
      product_type IS NULL OR 
      product_detail IS NULL;

SELECT COUNT(DISTINCT transaction_id) AS unique_transaction
FROM  bright_coffee_shop.sales_analysis.coffee_shop


-- Counts all the unique store locations from coffee shop dataset and arranging them in alphabetical order (Retrieved 3 stores:)
-- checking how many stores in the datasets = 3 stores Astoria,Hell's Kitchen and Lower Manhatten
SELECT COUNT(DISTINCT store_id) AS store_id
FROM bright_coffee_shop.sales_analysis.coffee_shop;

SELECT DISTINCT store_location 
FROM bright_coffee_shop.sales_analysis.coffee_shop
ORDER BY store_location;

--Counts the number of records where transaction quantity is 0 or neqative.(retrieved 0 quantities)
SELECT COUNT(*) AS negative_qty 
FROM bright_coffee_shop.sales_analysis.coffee_shop
WHERE transaction_qty <= 0; 

-- Counts the number of records where unit price is 0 or neqative.
SELECT COUNT(*) AS negative_price
FROM bright_coffee_shop.sales_analysis.coffee_shop
WHERE unit_price <= 0;

-- Count the blank product categories, product type and product detail.
SELECT COUNT(*) AS missing_product_categories
FROM bright_coffee_shop.sales_analysis.coffee_shop
WHERE TRIM(product_category)  = ' '
OR TRIM(product_detail) = ' '
OR TRIM(product_detail) = ' ';

-- Counting blank store locations in the dataset to identify records with missing or empty store location information.
SELECT COUNT(*) AS store_locations
FROM bright_coffee_shop.sales_analysis.coffee_shop
WHERE TRIM(store_location) = ' ';

-- DATE RANGE VALIDATION - when sales manager wants to understand daily, monthly and seasonal trends
-- This also tells us the period covered
SELECT
     MIN(transaction_date) AS First_Transaction_Date,
     MAX(transaction_date) AS Last_Transaction_Date
FROM bright_coffee_shop.sales_analysis.coffee_shop;

-- We are checking the operating hours to understand when the business is open.
SELECT 
    MIN(transaction_time) AS earliest_transaction_time,
    MAX(transaction_time) AS latest_transaction_time
FROM bright_coffee_shop.sales_analysis.coffee_shop;

-- We are identifying all product categories and types in the coffee shop.
SELECT DISTINCT product_category
FROM bright_coffee_shop.sales_analysis.coffee_shop
ORDER BY product_category;

-- Date extraction (Month name, month_id, day name)
SELECT
     transaction_date,
     MONTHNAME(transaction_date) AS month_name,
     MONTH(transaction_date) AS month_number,
     DATE_FORMAT(transaction_date, 'yyyy-MMM') AS month_id,
     DAYNAME(transaction_date) AS day_name,
     DAYOFWEEK(transaction_date) AS day_number
FROM bright_coffee_shop.sales_analysis.coffee_shop;

-- We are calculating the total revenue of the coffee.(our total revenue R698812.33)
SELECT 
    ROUND(SUM(transaction_qty * unit_price), 2) AS total_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop;

-- Calculating total number of units sold.(214470.00)
SELECT 
    SUM(transaction_qty) AS total_units_sold
FROM bright_coffee_shop.sales_analysis.coffee_shop;

-- Calculate total average revenue per transaction
SELECT
    ROUND(SUM(transaction_qty * unit_price), 2) AS total_average_revenue,
    AVERAGE(SUM(transaction_qty * unit_price), 2) AS average_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop;

-- We are calculating the revenue amounts for product type.
SELECT
    product_type,
    ROUND(SUM(transaction_qty * unit_price), 2) AS total_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop
GROUP BY product_type
ORDER BY total_revenue DESC;

-- We are calculating by product detail
SELECT
product_detail,
ROUND(SUM(transaction_qty * unit_price), 2) AS total_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop
GROUP BY product_detail
ORDER BY total_revenue DESC;
-- We are identifying the earliest and latest transaction times
SELECT 
    MIN(transaction_time) AS earliest_transaction_time,
    MAX(transaction_time) AS latest_transaction_time
FROM bright_coffee_shop.sales_analysis.coffee_shop;

-- We are calculating the total revenue generated each day to check which days have the highest and lowest sales.
SELECT 
transaction_date,
DAYNAME(CURRENT_DATE()) AS Day_name,
ROUND(SUM(transaction_qty * unit_price), 2) AS total_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop
GROUP BY transaction_date
ORDER BY total_revenue DESC;

-- We are caculating the daily revenue sales from Monday to Sunday.
SELECT
    date_format(transaction_date,'EEEE') AS weekday,
    ROUND(SUM(transaction_qty * unit_price),2) AS total_sales
FROM bright_coffee_shop.sales_analysis.coffee_shop 
WHERE dayofweek(transaction_date) BETWEEN 1 AND 7
GROUP BY date_format(transaction_date,'EEEE')
ORDER BY total_sales DESC;

-- We are identifying top 10 best-selling products.

SELECT
    product_detail,
    SUM(transaction_qty) AS units_sold
FROM bright_coffee_shop.sales_analysis.coffee_shop 
GROUP BY product_detail
ORDER BY units_sold DESC
LIMIT 10;

-- Revenue by store
SELECT
    store_location,
    ROUND(SUM(transaction_qty * unit_price),2) AS total_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop 
GROUP BY store_location
ORDER BY total_revenue DESC;

-- Grouping Sales by hours from highest to lowest
SELECT
    HOUR(transaction_time) AS sales_hour,
    ROUND(SUM(transaction_qty * unit_price),2) AS total_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop 
GROUP BY HOUR(transaction_time)
ORDER BY total_revenue DESC;

-- Grouping the sales by product detail and displaying by product detail and displaying the top 10 highest_revenue products in descending order.
SELECT
    product_detail,
    ROUND(SUM(transaction_qty * unit_price),2) AS total_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop 
GROUP BY product_detail
ORDER BY total_revenue DESC
LIMIT 10;

-- Cal

-- 1. TOTAL REVENUE
SELECT 
      transaction_qty * unit_price AS Total_amount
FROM bright_coffee_shop.sales_analysis.coffee_shop;

-- Total revenue per dataset rounded to 2 decimal places.
SELECT
      SUM(transaction_qty),
     ROUND(SUM(transaction_qty * unit_price), 2) AS Total_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop
GROUP BY ALL;


-- 2. TOTAL REVENUE BY PRODUCT
-- Revenue by product category
SELECT
     product_category,
     ROUND(SUM(transaction_qty * unit_price), 2) AS Total_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop 
GROUP BY ALL
ORDER BY Total_revenue DESC;

-- Revenue by product_detail
SELECT
     product_detail,
     ROUND(SUM(transaction_qty * unit_price), 2) AS Total_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop
GROUP BY ALL
ORDER BY Total_revenue DESC;

 -- Revenue by product category 
 SELECT
     product_category,
     ROUND(SUM(transaction_qty * unit_price), 2) AS Total_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop
-- WHERE product_category = 'Coffee'
GROUP BY ALL
ORDER BY product_category;

--  Revenue by product_type
SELECT
     product_type,
     ROUND(SUM(transaction_qty * unit_price), 2) AS Total_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop
GROUP BY ALL
ORDER BY Total_revenue DESC;


-- 3.REVENUE BY UNIT PRICE
SELECT
      unit_price,
      SUM(transaction_qty) AS total_units_sold,
      ROUND(SUM(unit_price * transaction_qty), 2) AS Total_Revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop
GROUP BY unit_price
ORDER by Total_revenue;


-- 4.TOTAL REVENUE BY STORE LOCATION
SELECT 
     store_location,
     ROUND(SUM(transaction_qty * unit_price), 2) AS Total_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop
GROUP BY ALL
ORDER BY Total_revenue DESC;

--  Revenue by product_type
SELECT
     product_type,
     ROUND(SUM(transaction_qty * unit_price), 2) AS Total_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop
GROUP BY ALL
ORDER BY Total_revenue DESC;


-- 3.REVENUE BY UNIT PRICE
SELECT
      unit_price,
      SUM(transaction_qty) AS total_units_sold,
      ROUND(SUM(unit_price * transaction_qty), 2) AS Total_Revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop
GROUP BY unit_price
ORDER by Total_revenue;


-- 4.TOTAL REVENUE BY STORE LOCATION
SELECT 
     store_location,
     ROUND(SUM(transaction_qty * unit_price), 2) AS Total_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop
GROUP BY ALL
ORDER BY Total_revenue DESC;
-- TOTAL REVENUE BASED ON TIME OF THE DAY
-- 6am - 11:59:59 = Morning
-- 12pm - 17:59:59 = Afternoon
-- 18pm - 20:59:59 = Evening
-- After 21:00 = Night

SELECT 
    CASE 
       WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
       WHEN transaction_time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
       WHEN transaction_time BETWEEN '13:00:00' AND '23:59:59' THEN 'Night'
       ELSE 'Evening'
    END AS time_bucket,
    ROUND(SUM(transaction_qty * unit_price), 2) AS Total_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop
GROUP BY ALL;


-- Date extraction (Month name, month_id, day name)
SELECT
     transaction_date,
     YEAR(transaction_date) As Sales_year,
     MONTHNAME(transaction_date) AS month_name,
     MONTH(transaction_date) AS month_number,
     DATE_FORMAT(transaction_date, 'yyyy-MMM') AS month_id,
     DAYNAME(transaction_date) AS day_name,
     DAYOFWEEK(transaction_date) AS day_number
FROM bright_coffee_shop.sales_analysis.coffee_shop; 


-- COMBINE ALL THE CODES TO CREATE DATASET TO EXPORT AS CSV TO EXCEL FOR EXCEL ANALYSIS.
SELECT 
    transaction_id,
    transaction_date,
    YEAR(transaction_date) AS sales_year,
    MONTHNAME(transaction_date) AS month_name,
    MONTH(transaction_date) AS month_number,
    DATE_FORMAT(transaction_date, 'yyyy-MMM') AS month_id,
    DAYNAME(transaction_date) AS day_name,
    DAYOFWEEK(transaction_date) AS day_number,
    product_category,
    product_type,
    product_detail,
    store_location,
      CASE 
       WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
       WHEN transaction_time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
       ELSE 'Evening'
    END AS time_bucket,
    COUNT(transaction_id) AS Total_transactions,
    SUM(transaction_qty) AS Total_units_sold,
    ROUND(SUM(transaction_qty * unit_price), 2) AS Total_revenue
FROM bright_coffee_shop.sales_analysis.coffee_shop
GROUP BY ALL;
