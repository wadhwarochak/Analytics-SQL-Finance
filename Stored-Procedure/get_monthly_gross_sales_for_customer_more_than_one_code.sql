CREATE DEFINER=`root`@`localhost` PROCEDURE `get_monthly_gross_sales_for_customer`(
	in_customer_codes int
)
BEGIN
	SELECT
		s.date,
        sum(round(g.gross_price*s.sold_quantity,2)) as monthly_sales
	FROM fact_sales_monthly s 
	join fact_gross_price g
		ON g.fiscal_year=get_fiscal_year(s.date)
        and g.product_code=s.product_code
	WHERE
		find_in_set(s.customer_code, in_customer_codes) >0
	group by s.date
order by s.date asc;
END