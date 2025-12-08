-- =====================================================================
-- Project: Retail Sales Performance & Profitability Analysis
-- File   : Retail_Sales_Analysis_Queries.sql
-- Purpose: Generate KPIs & insights for Power BI Dashboard
-- =====================================================================


-- =====================================================================
-- Phase 1: KPI & Performance Metrics
-- =====================================================================

-- 1) Total Sales and Total Profit
SELECT 
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM retail_sales;


-- 2) Category-wise Revenue & Profit Ranking
SELECT 
    Category,
    SUM(Sales) AS Total_Revenue,
    SUM(Profit) AS Total_Profit
FROM retail_sales
GROUP BY Category
ORDER BY Total_Revenue DESC;


-- 3) State-wise Sales Performance (Top Markets)
SELECT 
    State,
    SUM(Sales) AS Revenue,
    SUM(Profit) AS Profit
FROM retail_sales
GROUP BY State
ORDER BY Revenue DESC;


-- 4) Profit Margin by Region
SELECT 
    Region,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percentage
FROM retail_sales
GROUP BY Region
ORDER BY Profit_Margin_Percentage DESC;


-- 5) Monthly Sales Trend
SELECT 
    Order_Month AS Month,
    SUM(Sales) AS Monthly_Sales
FROM retail_sales
GROUP BY Order_Month
ORDER BY MIN(Order_Date);


-- =====================================================================
-- Phase 2: Advanced Analytical Queries
-- =====================================================================

-- A) Top 10 Best-Selling Sub-Categories by Revenue
SELECT 
    Sub_Category,
    SUM(Sales) AS Revenue,
    SUM(Profit) AS Profit
FROM retail_sales
GROUP BY Sub_Category
ORDER BY Revenue DESC
LIMIT 10;


-- B) City-wise Profitability (Top 10)
SELECT 
    City,
    SUM(Profit) AS Total_Profit
FROM retail_sales
GROUP BY City
ORDER BY Total_Profit DESC
LIMIT 10;


-- B2) City-wise Profitability (Bottom 10)
SELECT 
    City,
    SUM(Profit) AS Total_Profit
FROM retail_sales
GROUP BY City
ORDER BY Total_Profit ASC
LIMIT 10;


-- C) Discount Impact on Profitability
SELECT 
    CASE
        WHEN Discount < 0.10 THEN 'Low Discount'
        WHEN Discount BETWEEN 0.10 AND 0.25 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS Discount_Level,
    SUM(Profit) AS Total_Profit,
    SUM(Sales) AS Total_Revenue,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin
FROM retail_sales
GROUP BY Discount_Level
ORDER BY Profit_Margin DESC;


-- D) Yearly Sales & YoY Growth Trend
WITH yearly_sales AS (
    SELECT 
        YEAR(Order_Date) AS Year,
        SUM(Sales) AS Total_Sales
    FROM retail_sales
    GROUP BY YEAR(Order_Date)
)
SELECT 
    Year,
    Total_Sales,
    LAG(Total_Sales) OVER (ORDER BY Year) AS Previous_Year_Sales,
    ROUND(
        (
            (Total_Sales - LAG(Total_Sales) OVER (ORDER BY Year))
            / LAG(Total_Sales) OVER (ORDER BY Year)
        ) * 100,
        2
    ) AS YoY_Growth_Percentage
FROM yearly_sales
ORDER BY Year;


-- E) Region-wise Profit Margin Ranking
SELECT 
    Region,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin
FROM retail_sales
GROUP BY Region
ORDER BY Profit_Margin DESC;
