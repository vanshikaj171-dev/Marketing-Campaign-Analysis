-- create table

CREATE TABLE marketing_campaigns (
    Data DATE,
    Campaign VARCHAR(50),
    Channel VARCHAR(50),
    Objective VARCHAR(100),
    AB_Test_Version CHAR(1),
    age INT,
    Age_Group VARCHAR(20),
    Gender VARCHAR(20),
    Region VARCHAR(20),
    Device VARCHAR(20),
    Customer_Segment VARCHAR(30),
    Impressions INT,
    CTR DECIMAL(10,6),
    Clicks INT,
    Conversion_Rate DECIMAL(10,6),
    Conversions INT,
    Cost DECIMAL(12,2),
    Revenue DECIMAL(12,2),
    ROI DECIMAL(10,6),
    Likes INT,
    Shares INT,
    Saves INT,
    Email_Opens INT,
    Retention_After_Campaign DECIMAL(10,6)
);


-- total impressions

SELECT SUM(Impressions) AS total_impressions
FROM marketing_campaigns;


-- total clicks

SELECT SUM(Clicks) AS total_clicks
FROM marketing_campaigns;


-- total engagement (likes + shares + saves)

SELECT SUM(Likes + Shares + Saves) AS total_engagement
FROM marketing_campaigns;


-- total conversions

SELECT SUM(Conversions) AS total_conversions
FROM marketing_campaigns;


-- total ROI

SELECT SUM(ROI) AS total_roi
FROM marketing_campaigns;


-- total retention

SELECT SUM(Retention_After_Campaign) AS total_retention
FROM marketing_campaigns;


-- conversions by campaign

SELECT Campaign, SUM(Conversions) AS conversions
FROM marketing_campaigns
GROUP BY Campaign
ORDER BY conversions DESC;


-- ROI by campaign

SELECT Campaign, SUM(ROI) AS total_roi
FROM marketing_campaigns
GROUP BY Campaign
ORDER BY total_roi DESC;


-- conversions by channel

SELECT Channel, SUM(Conversions) AS conversions
FROM marketing_campaigns
GROUP BY Channel
ORDER BY conversions DESC;


-- gender distribution

SELECT 
    Gender,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct
FROM marketing_campaigns
GROUP BY Gender
ORDER BY count DESC;


-- conversions by customer segment

SELECT Customer_Segment, SUM(Conversions) AS conversions
FROM marketing_campaigns
GROUP BY Customer_Segment
ORDER BY conversions DESC;


-- conversions by channel and ab test version

SELECT Channel, AB_Test_Version, SUM(Conversions) AS conversions
FROM marketing_campaigns
GROUP BY Channel, AB_Test_Version
ORDER BY Channel, AB_Test_Version;


-- conversions by device

SELECT Device, SUM(Conversions) AS conversions
FROM marketing_campaigns
GROUP BY Device
ORDER BY conversions DESC;


-- ROI by region

SELECT Region, SUM(ROI) AS total_roi
FROM marketing_campaigns
GROUP BY Region
ORDER BY total_roi DESC;


-- conversions by age group

SELECT Age_Group, SUM(Conversions) AS conversions
FROM marketing_campaigns
GROUP BY Age_Group
ORDER BY conversions DESC;


-- monthly trend

SELECT 
    DATE_FORMAT(Data, '%Y-%m') AS month,
    SUM(Impressions) AS impressions,
    SUM(Clicks) AS clicks,
    SUM(Conversions) AS conversions,
    ROUND(AVG(ROI), 4) AS avg_roi
FROM marketing_campaigns
GROUP BY DATE_FORMAT(Data, '%Y-%m')
ORDER BY month;


-- campaign and channel performance

SELECT 
    Campaign,
    Channel,
    SUM(Conversions) AS conversions,
    ROUND(AVG(CTR), 4) AS avg_ctr,
    ROUND(SUM(ROI), 2) AS total_roi
FROM marketing_campaigns
GROUP BY Campaign, Channel
ORDER BY conversions DESC;


-- a/b test comparison

SELECT 
    AB_Test_Version,
    COUNT(*) AS total_records,
    SUM(Conversions) AS conversions,
    ROUND(AVG(Conversion_Rate), 4) AS avg_conversion_rate,
    ROUND(AVG(ROI), 4) AS avg_roi
FROM marketing_campaigns
GROUP BY AB_Test_Version;


-- cost vs revenue by campaign

SELECT 
    Campaign,
    ROUND(SUM(Cost), 2) AS total_cost,
    ROUND(SUM(Revenue), 2) AS total_revenue,
    ROUND(SUM(Revenue) - SUM(Cost), 2) AS net_profit,
    ROUND((SUM(Revenue) - SUM(Cost)) / NULLIF(SUM(Cost), 0) * 100, 2) AS profit_margin_pct
FROM marketing_campaigns
GROUP BY Campaign
ORDER BY net_profit DESC;


-- top 5 records by ROI

SELECT Data, Campaign, Channel, Region, Customer_Segment, Conversions, ROUND(ROI, 4) AS roi
FROM marketing_campaigns
ORDER BY roi DESC
LIMIT 5;
