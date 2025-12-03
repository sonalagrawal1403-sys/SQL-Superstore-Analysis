-- 1. Total Sales, Profit & Quantity
SELECT 
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity
FROM superstore;

-- 2. Sales by Category
SELECT Category, ROUND(SUM(Sales),2) AS Sales
FROM superstore
GROUP BY Category
ORDER BY Sales DESC;

-- 3. Profit by Sub-Category
SELECT Sub_Category, ROUND(SUM(Profit),2) AS Profit
FROM superstore
GROUP BY Sub_Category
ORDER BY Profit DESC;

-- 4. Sales by Region
SELECT Region, ROUND(SUM(Sales),2) AS Sales
FROM superstore
GROUP BY Region
ORDER BY Sales DESC;

-- 5. Top 10 Most Profitable Products
SELECT Product_Name, ROUND(SUM(Profit),2) AS Profit
FROM superstore
GROUP BY Product_Name
ORDER BY Profit DESC
LIMIT 10;

-- 6. Worst 10 Loss-Making Products
SELECT Product_Name, ROUND(SUM(Profit),2) AS Loss
FROM superstore
GROUP BY Product_Name
ORDER BY Loss ASC
LIMIT 10;

-- 7. Customer Lifetime Value
SELECT Customer_Name, ROUND(SUM(Sales),2) AS Total_Sales
FROM superstore
GROUP BY Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;

-- 8. Sales over Years
SELECT YEAR(Order_Date) AS Year, ROUND(SUM(Sales),2) AS Sales
FROM superstore
GROUP BY YEAR(Order_Date)
ORDER BY Year;

-- 9. Month-wise Sales Trend
SELECT MONTH(Order_Date) AS Month, ROUND(SUM(Sales),2) AS Sales
FROM superstore
GROUP BY MONTH(Order_Date)
ORDER BY Month;

-- 10. Average Delivery Time
SELECT 
    AVG(DATEDIFF(Ship_Date, Order_Date)) AS Avg_Delivery_Days
FROM superstore;

-- 11. Most Frequent Ship Mode
SELECT Ship_Mode, COUNT(*) AS Usage_Count
FROM superstore
GROUP BY Ship_Mode
ORDER BY Usage_Count DESC;

-- 12. Discount vs Profit Correlation Check
SELECT 
    Discount,
    ROUND(AVG(Profit), 2) AS Avg_Profit
FROM superstore
GROUP BY Discount
ORDER BY Discount;

-- 13. State-wise Profitability
SELECT State, ROUND(SUM(Profit),2) AS Profit
FROM superstore
GROUP BY State
ORDER BY Profit DESC;

-- 14. Cities generating most orders
SELECT City, COUNT(*) AS Order_Count
FROM superstore
GROUP BY City
ORDER BY Order_Count DESC
LIMIT 20;

-- 15. Market Basket (Co-purchased Items)
SELECT 
    a.Sub_Category AS Item_A,
    b.Sub_Category AS Item_B,
    COUNT(*) AS Frequency
FROM superstore a
JOIN superstore b
    ON a.Order_ID = b.Order_ID
    AND a.Sub_Category <> b.Sub_Category
GROUP BY Item_A, Item_B
ORDER BY Frequency DESC
LIMIT 20;

-- 16. Profit Margins
SELECT 
    Category,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS Profit_Margin_Percent
FROM superstore
GROUP BY Category
ORDER BY Profit_Margin_Percent DESC;

-- 17. Top 10 Cheapest High-Profit Items
SELECT Product_Name, Sales, Profit
FROM superstore
WHERE Sales < 50 AND Profit > 20
ORDER BY Profit DESC;

-- 18. Loss due to High Discounts
SELECT 
    Sub_Category,
    ROUND(SUM(Profit),2) AS Profit,
    ROUND(AVG(Discount),2) AS Avg_Discount
FROM superstore
GROUP BY Sub_Category
HAVING Avg_Discount > 0.2
ORDER BY Profit ASC;

-- 19. Sales by Segment
SELECT Segment, ROUND(SUM(Sales),2) AS Sales
FROM superstore
GROUP BY Segment
ORDER BY Sales DESC;

-- 20. Shipment Delay Analysis
SELECT 
    Ship_Mode,
    AVG(DATEDIFF(Ship_Date, Order_Date)) AS Ship_Delay
FROM superstore
GROUP BY Ship_Mode
ORDER BY Ship_Delay DESC;
