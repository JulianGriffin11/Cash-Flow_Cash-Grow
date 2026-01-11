--Query 3: How does Amazon’s stock–fundamental relationship compare to other public companies?

--Goal: Test if the results are unique to Amazon or if this pattern holds.
--Method: Run the same queries on other companies
--Answer: FCF is the main driver of stock price over the long term but in the mid term, 
-- the maturity and predictability of the company determines whether FCF leads stock price or
-- whether the stock price climbs before FCF improvements are evident


WITH all_data AS (
	SELECT * FROM amzn_data
	UNION ALL
	SELECT * FROM cost_data
	UNION ALL
	SELECT * FROM ma_data
	UNION ALL
	SELECT * FROM aapl_data
),

bounds AS (
	SELECT
		ticker,
		MAX(fiscal_year) AS end_year,
		MIN(fiscal_year) AS start_year
	FROM all_data
	GROUP BY ticker
),

start_all_values AS (
  SELECT DISTINCT ON (ad.ticker)
         ad.ticker,
         ad.stock_price      AS s_price,
         ad.revenue          AS s_rev,
         ad.operating_income AS s_oi,
         ad.net_income       AS s_ni,
         ad.free_cash_flow   AS s_fcf
  FROM all_data ad
  ORDER BY ad.ticker, ad.fiscal_year ASC
),

end_all_values AS (
  SELECT DISTINCT ON (ad.ticker)
         ad.ticker,
         ad.stock_price      AS e_price,
         ad.revenue          AS e_rev,
         ad.operating_income AS e_oi,
         ad.net_income       AS e_ni,
         ad.free_cash_flow   AS e_fcf
  FROM all_data ad
  ORDER BY ad.ticker, ad.fiscal_year DESC
),

joined_all_values AS ( 
	SELECT 
		b.ticker,
		b.start_year,
		b.end_year,
		(b.end_year - b.start_year) AS n_years,
		s.s_price, s.s_rev, s.s_oi, s.s_ni, s.s_fcf,
    	e.e_price, e.e_rev, e.e_oi, e.e_ni, e.e_fcf
	FROM bounds b
	JOIN end_all_values e   USING (ticker)
	JOIN start_all_values s USING (ticker)
)

SELECT
	ticker, 
	ROUND(POWER(e_price / s_price, 1.0 / (end_year - start_year)) - 1, 2) AS stock_price_cagr,
	ROUND(POWER(e_rev  / s_rev, 1.0 / (end_year - start_year)) - 1, 2) AS revenue_price_cagr,
	ROUND(POWER(e_oi  / s_oi, 1.0 / (end_year - start_year)) - 1, 2) AS operating_income_price_cagr,
	ROUND(POWER(e_ni  / s_ni, 1.0 / (end_year - start_year)) - 1, 2) AS net_income_price_cagr,
	ROUND(POWER(e_fcf  / s_fcf, 1.0 / (end_year - start_year)) - 1, 2) AS fcf_price_cagr
FROM joined_all_values
ORDER BY ticker ASC