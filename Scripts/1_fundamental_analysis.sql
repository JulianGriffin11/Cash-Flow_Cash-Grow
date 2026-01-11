--Query 1: Over the entire period, which metric grew at a rate closest to Amazon’s stock price?
 
--Goal: Strip out volatility and give the simliest answer
--Method: Find the CAGR of each finanical metric and then compare it to the CAGR of the stock price
--Answer: FCF is the anchor metric explaining long-term trajectory


WITH years_in_between AS (
	SELECT
		MAX(fiscal_year) AS end_year,
		MIN(fiscal_year) AS start_year
	FROM amzn_data
),

start_values AS (
	SELECT 
		stock_price 		AS s_price,
		revenue				AS s_rev,
		operating_income	AS s_oi,
		net_income			AS s_ni,
		free_cash_flow		AS s_fcf
	FROM amzn_data 
	ORDER BY fiscal_year ASC LIMIT 1
),

end_values AS (
	SELECT 
		stock_price 		AS e_price,
		revenue				AS e_rev,
		operating_income	AS e_oi,
		net_income			AS e_ni,
		free_cash_flow		AS e_fcf
	FROM amzn_data 
	ORDER BY fiscal_year DESC LIMIT 1
),

ticker AS (
  SELECT DISTINCT ticker AS ticker_symbol FROM amzn_data LIMIT 1
)

SELECT
	ticker_symbol, 
	ROUND(POWER(e_price / s_price, 1.0 / (end_year - start_year)) - 1, 2) AS stock_price_cagr,
	ROUND(POWER(e_rev  / s_rev, 1.0 / (end_year - start_year)) - 1, 2) AS revenue_price_cagr,
	ROUND(POWER(e_oi  / s_oi, 1.0 / (end_year - start_year)) - 1, 2) AS operating_income_price_cagr,
	ROUND(POWER(e_ni  / s_ni, 1.0 / (end_year - start_year)) - 1, 2) AS net_income_price_cagr,
	ROUND(POWER(e_fcf  / s_fcf, 1.0 / (end_year - start_year)) - 1, 2) AS fcf_price_cagr
FROM years_in_between, start_values, end_values, ticker






