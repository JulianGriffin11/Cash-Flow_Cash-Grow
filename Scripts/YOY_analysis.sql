-- Query 1: Which fundamental metric has historically tracked Amazon’s stock growth most closely?

WITH jan1_price AS (
	SELECT
		DISTINCT ON
		(
			EXTRACT(YEAR FROM ap.date)
		)
        EXTRACT(YEAR FROM ap.date)::int AS fiscal_year,
		ap.date 						AS first_trading_date,
		ap.CLOSE:: NUMERIC 				AS stock_price
	FROM
		amzn_prices ap
	ORDER BY
		EXTRACT(YEAR FROM ap.date),
		ap.date
),

base AS (
	SELECT  
		af.fiscal_year,
		jp.stock_price,
		af.revenue:: numeric 									AS revenue,
		af.operating_income:: numeric							AS operating_income,
		af.net_income:: NUMERIC									AS net_income,
		af.net_cash_from_ops - af.capex_purchases_ppe:: numeric AS free_cash_flow
	FROM  
		amzn_financials af
	LEFT JOIN jan1_price jp ON
		af.fiscal_year = jp.fiscal_year
	WHERE
		af.period_type = 'annual'
	ORDER BY
		af.fiscal_year DESC
)

SELECT
	fiscal_year,
	stock_price,
    ROUND((stock_price       / NULLIF(LAG(stock_price)       OVER (ORDER BY fiscal_year), 0) - 1.0),2) AS stock_price_yoy,
    ROUND((revenue           / NULLIF(LAG(revenue)           OVER (ORDER BY fiscal_year), 0) - 1.0),2) AS revenue_yoy,
    ROUND((operating_income  / NULLIF(LAG(operating_income)  OVER (ORDER BY fiscal_year), 0) - 1.0),2) AS operating_income_yoy,
    ROUND((net_income        / NULLIF(LAG(net_income)        OVER (ORDER BY fiscal_year), 0) - 1.0),2) AS net_income_yoy,
    ROUND((free_cash_flow    / NULLIF(LAG(free_cash_flow)    OVER (ORDER BY fiscal_year), 0) - 1.0),2) AS free_cash_flow_yoy
FROM
	base
WHERE fiscal_year >= '2015'
ORDER BY
	fiscal_year
	
	
	
	