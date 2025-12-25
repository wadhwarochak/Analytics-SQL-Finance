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


-- Get quarter 4 Data
select * from gdb0041.fact_sales_monthly where customer_code=90002002 and
get_fiscal_year(date)=2021
and get_fiscal_quarter(date)="Q4"
order by date desc;


-- Get Product name and Variant
-- Will use join
select s.date, s.product_code, p.product, p.variant, s.sold_quantity from fact_sales_monthly s
join dim_product p
on p.product_code = s.product_code
where customer_code=90002002 and
get_fiscal_year(date)=2021
and get_fiscal_quarter(date)="Q4"
order by date desc;


-- Adding Gross price column to result
select s.date, s.product_code, p.product, p.variant, s.sold_quantity, g.gross_price from fact_sales_monthly s
join dim_product p
on p.product_code = s.product_code
join fact_gross_price g
	on g.product_code= s.product_code and g.fiscal_year=get_fiscal_year(s.date)
	where customer_code=90002002 and
get_fiscal_year(date)=2021
and get_fiscal_quarter(date)="Q4"
order by date desc;

-- Verify output by checking gross price of a Product
select * from fact_gross_price where product_code = 'A0118150101';

-- Adding Gross Price Total in round-2
select s.date, s.product_code, p.product, p.variant, s.sold_quantity, g.gross_price,
ROUND(g.gross_price * s.sold_quantity,2) as gross_price_total
from fact_sales_monthly s
join dim_product p
on p.product_code = s.product_code
join fact_gross_price g
	on g.product_code= s.product_code and g.fiscal_year=get_fiscal_year(s.date)
	where customer_code=90002002 and
get_fiscal_year(date)=2021
and get_fiscal_quarter(date)="Q4"
order by date desc;




-- Next Problem:
-- Gross Sales report, monthly sales amount
SELECT
	s.date, sum(g.gross_price*s.sold_quantity) as gross_price_total
	FROM fact_sales_monthly s 
join fact_gross_price g
ON
	g.product_code=s.product_code and
	g.fiscal_year=get_fiscal_year(s.date)
WHERE customer_code=90002002
group by s.date
order by s.date asc;


-- Yearly Sales report
	select
            get_fiscal_year(date) as fiscal_year,
            sum(round(sold_quantity*g.gross_price,2)) as yearly_sales
	from fact_sales_monthly s
	join fact_gross_price g
	on 
	    g.fiscal_year=get_fiscal_year(s.date) and
	    g.product_code=s.product_code
	where
	    customer_code=90002002
	group by get_fiscal_year(date)
	order by fiscal_year;