CREATE PROCEDURE `get_monthly_gross_sales_for_customer` (
	customer_code int
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
		customer_code=customer_code
	group by s.date
order by s.date asc;
END
