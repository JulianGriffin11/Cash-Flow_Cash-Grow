# 📈 Stock Price vs Fundamentals 📈

## 👋 Welcome  
This is my **SQL analysis** project where hype gets stripped away and only numbers get to talk.

---

## 🚀 Foreword  
This section uses **SQL** to answer a brutal question:  
*What actually drives long-term stock prices—stories, sentiment, or fundamentals?*  

By calculating **CAGR**, building **indexed growth series**, and comparing companies across cycles, this chapter exposes the metric that truly anchors valuation. Spoiler: it’s not revenue. It’s not earnings. It’s **Free Cash Flow.**

---

## 🎯 Objectives  
1. Identify which fundamental metric best tracks stock price long-term.  
2. Compare Amazon’s pattern to other major companies.  
3. Separate short-term noise from long-term signal.

---

## 🛠 Skills and Tools  
- **Language:** SQL  
- **Concepts:** CAGR, indexing, time-series comparison  
- **Skills:** Analytical thinking, financial modeling logic, query design

---

## 📊 Data Overview  

Companies include:
- `Amazon - AMZN`
- `Costco - COST`
- `Mastercard - MA`
- `Apple - AAPL`

Key variables analyzed:
- **Stock Price**
- **Revenue**
- **Operating Income**
- **Net Income**
- **Free Cash Flow (FCF)**

---

## 🔧 Methodology

### 1. CAGR Analysis — Long-Term Truth  
**Question:** Over the full period, which metric grows closest to stock price?  

**Method:**  
- Extract first and last year values  
- Compute CAGR for stock and each fundamental  
- Compare distances  

<img src="Plots/CAGR_vs_companies.png" alt="CAGR Comparison Across Companies" width="75%"/>

**Result:**  
> **FCF is the anchor metric explaining Amazon’s long-term stock trajectory.**

---

### 2. Indexed Growth — Shape of the Journey  
**Question:** Which metric visually mirrors the stock over time?  

**Method:**  
- Set base year = 100  
- Index stock and all fundamentals  
- Compare slopes and turning points  

**Result:**  
> FCF doesn’t just match the destination—it matches the *path*.  
> It explains both long-term direction and medium-term re-rating cycles.

📊 *Indexed Growth Output (Query 2)*  
See: `Query_2_Output.csv` for full indexed series.

---

### 3. Cross-Company Test — Is Amazon Special?  
**Question:** Does this pattern hold across other firms?  

**Method:**  
- Union multiple company datasets  
- Run same CAGR logic per ticker  
- Compare metric-to-stock alignment  

**Result:**  
- Long-term: **FCF dominates across companies**  
- Mid-term:  
  - Mature firms → FCF leads stock  
  - Story-driven firms → Stock runs ahead of FCF

📄 *CAGR Table Output (Query 3)*  
See: `Query_3_Output.csv` for company-by-company results.

---

## 🧠 Key Findings  
1. Stock prices ultimately obey **Free Cash Flow** (in the long term), not narratives.  
2. Revenue and earnings matter but they don’t drive valuation alone.  
3. Market timing depends on maturity.

---

## 🎓 Conclusion  

This chapter proves something uncomfortable:  
Markets may flirt with stories, but they marry cash.  

Free Cash Flow isn’t glamorous. It doesn’t trend on Twitter. It doesn’t sound visionary.  
But over time, it drags stock prices to where they deserve to be—whether investors like it or not.

Hype is a spark.  
Revenue is fuel.  
**FCF is gravity.**

---

Sincerely,  
Julian

