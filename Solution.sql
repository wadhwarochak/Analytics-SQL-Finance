-- Month
-- Product Name
-- Variant
-- Sold Quantity
-- Gross Price Per Item

-- Step 1: Find cusromer code
SELECT * FROM dim_customer where customer like "%croma%" and market = 'india';

-- Step 2: Find monthly sale
select * from fact_sales_monthly where customer_code=90002002;

-- Step 3 : Find in Year 2021
select * from fact_sales_monthly where customer_code=90002002 and YEAR(date)=2021
order by date desc;

-- Step 4: Convert calender year to Fiscal Year
select * from fact_sales_monthly where customer_code=90002002 and
YEAR(DATE_ADD(date,INTERVAL 4 MONTH))=2021
order by date desc;

-- Step 5: Create Function and use it
select get_fiscal_year('2020-09-01');

-- Step 6: Use the function
select * from gdb0041.fact_sales_monthly where customer_code=90002002 and
get_fiscal_year(date)=2021
order by date desc;
