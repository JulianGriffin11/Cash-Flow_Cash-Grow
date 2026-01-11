--Query 2: Which fundamental metric’s long-term trajectory most closely mirrors Amazon’s stock price?

--Goal: Identify which underlying driver explains the stock’s re-rating over time.
--Method: Create indexed growth charts (2015 = 100) for each metric vs stock price. Compare slopes and inflection points.
--Answer: FCF is the valuation-sensitive metric explaining shorter-term deviations.


WITH base_values AS (
	SELECT 
		fiscal_year,
		stock_price 		AS s_price,
		revenue				AS s_rev,
		operating_income	AS s_oi,
		net_income			AS s_ni,
		free_cash_flow		AS s_fcf
	FROM amzn_data 
	ORDER BY fiscal_year ASC LIMIT 1
)

SELECT
	ad.ticker AS ticker_symbol,
	ad.fiscal_year,
	ROUND((ad.stock_price / bv.s_price) * 100, 2) AS indexed_stock_price,
	ROUND((ad.revenue / bv.s_rev) * 100, 2) AS indexed_revenue,
	ROUND((ad.operating_income / bv.s_oi) * 100, 2) AS indexed_operating_income,
	ROUND((ad.net_income / bv.s_ni) * 100, 2) AS indexed_net_income,
	ROUND((ad.free_cash_flow / bv.s_fcf) * 100, 2) AS indexed_free_cash_flow
FROM base_values bv, amzn_data ad
ORDER BY fiscal_year ASC

