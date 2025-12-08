-- ===========================================
-- Table: retail_sales
-- Description: Stores retail order transactions
-- Used for Sales Performance & Profitability Analysis
-- ===========================================

DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales (
    OrderID         VARCHAR(20)      NOT NULL,
    Customer_Name   VARCHAR(100)     NOT NULL,
    Category        VARCHAR(50)      NOT NULL,
    Sub_Category    VARCHAR(50)      NOT NULL,
    City            VARCHAR(100)     NOT NULL,
    State           VARCHAR(50)      NOT NULL,
    Region          VARCHAR(20)      NOT NULL,
    Order_Date      DATE             NOT NULL,
    Order_Year      INT,
    Order_Month     VARCHAR(10),
    Order_Quarter   VARCHAR(5),
    Sales           DECIMAL(10,2)    NOT NULL,
    Discount        DECIMAL(5,2)     NOT NULL,
    Profit          DECIMAL(10,2)    NOT NULL
);

-- ===========================================
-- Additional indexes for faster analytics
-- ===========================================
CREATE INDEX idx_order_date ON retail_sales (Order_Date);
CREATE INDEX idx_category ON retail_sales (Category);
CREATE INDEX idx_region ON retail_sales (Region);
CREATE INDEX idx_city ON retail_sales (City);
