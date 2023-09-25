-- ### Please provide a SQL statement for each question
-- 1. Write a query to get the sum of impressions by day.

SELECT 
    date, 
    SUM(impressions) AS total_impressions 
FROM marketing_data 
GROUP BY date
ORDER BY date ASC

-- 2. Write a query to get the top three revenue-generating states in order of best to worst. How much revenue did the third best state generate?

-- The third best state is OH with total revenue of $37,577. 
SELECT 
    state, 
    SUM(revenue) AS total_revenue 
FROM website_revenue
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 3 

-- 3. Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.

SELECT 
    mk.campaign_id, 
    info.name AS campaign_name, 
    SUM(mk.cost) AS total_cost, 
    SUM(mk.impressions) AS total_impressions, 
    SUM(mk.clicks) AS total_clicks,
    SUM(rev.revenue) AS total_revenue
FROM marketing_data mk 
JOIN 
    campaign_info info ON mk.campaign_id = info.id
LEFT JOIN 
    website_revenue rev on mk.campaign_id = rev.campaign_id 
GROUP BY mk.campaign_id 
ORDER BY campaign_name

-- 4. Write a query to get the number of conversions of Campaign5 by state. Which state generated the most conversions for this campaign?

-- GA generates the most conversion for Campaign5. 
SELECT 
    mk.campaign_id,
    info.name AS campaign_name,
    mk.geo AS state,
    SUM(mk.conversions) AS total_conversions
FROM marketing_data mk
JOIN
    campaign_info info ON mk.campaign_id = info.id 
WHERE info.name = "Campaign5" 
GROUP BY mk.campaign_id, mk.geo
ORDER BY total_conversions DESC

-- 5. In your opinion, which campaign was the most efficient, and why?

/* To measure the efficiency of a campaign we can look at the following metrics: 
ROI: Return on Investment to calculate the profitability of the campaign
CPA: Cost per Acquisition to calculate cost to acquire one customer or to get one conversion
CTR: Click through rate to calculate the effectiveness of the campaign in leading to clicks
CVR: Conversion rate to calculate the effectiveness of the campaign in terms of conversions. */ 

SELECT performance.*, roi.ROI FROM 
    (SELECT 
        mk.campaign_id, 
        info.name AS campaign_name,
        SUM(mk.cost) / SUM(mk.conversions) AS CPA,
        (SUM(mk.clicks) / SUM(mk.impressions)) * 100 AS CTR,
        (SUM(mk.conversions) / SUM(mk.clicks)) * 100 AS CVR
    FROM marketing_data mk
    JOIN campaign_info info ON mk.campaign_id = info.id
    GROUP BY mk.campaign_id, info.name) performance
LEFT JOIN (
    SELECT 
        mk.campaign_id,
        info.name AS campaign_name,
        SUM(mk.cost) AS total_cost,
        SUM(rev.revenue) AS total_revenue,
        (SUM(rev.revenue) - SUM(mk.cost)) / SUM(mk.cost) AS ROI
    FROM marketing_data mk
    INNER JOIN website_revenue rev ON mk.campaign_id = rev.campaign_id AND mk.date = rev.date
    JOIN campaign_info info ON mk.campaign_id = info.id
    GROUP BY mk.campaign_id, info.name) roi
ON performance.campaign_id = roi.campaign_id
ORDER BY campaign_id

/* Since the given data on revenue is limited in aligning with the ads spends, 
which does not allow us to showcase a broader picture of ROI. Therefore, let's look at other metrics to measure performance.
Assume: 
1. All campaigns have the same objective and target audience.
2. External factors affecting the campaigns are consistent across all of them.
3. $1,000 budget of total cost for each campaign to yield proportional results based on their current metrics. */ 

SELECT 
    campaign_id,
    campaign_name,
    1000 / perf.CPA AS Exp_Conversions,
    1000 / perf.CPA / perf.CVR AS Exp_Clicks,
    1000 / perf.CPA / perf.CVR / perf.CTR AS Exp_Imp
FROM 
    (SELECT 
        mk.campaign_id, 
        info.name AS campaign_name,
        SUM(mk.cost) / SUM(mk.conversions) AS CPA,
        (SUM(mk.clicks) / SUM(mk.impressions)) AS CTR,
        (SUM(mk.conversions) / SUM(mk.clicks)) AS CVR
    FROM marketing_data mk
    JOIN campaign_info info ON mk.campaign_id = info.id
    GROUP BY mk.campaign_id, info.name) perf

-- If we determine efficiency based on the expected conversion, Campaign4 is the most efficient with the most conversion given the budget.


-- **Bonus Question**
-- 6. Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.

-- If we determine the best day to run ads using the revenue data, Sunday generates the highest revenue on average daily. 
SELECT 
    day_of_week,
    (total_revenue/day_count) AS day_avg_rev 
FROM
    (SELECT 
        DAYNAME(date) AS day_of_week, 
        SUM(revenue) AS total_revenue,
        COUNT(DAYNAME(date)) AS day_count
    FROM website_revenue
    GROUP BY day_of_week 
    ORDER BY total_revenue DESC) rev 
ORDER BY day_avg_rev DESC 

-- Alternatively, Friday is the best day to run ads if we use conversion rate as the metric to determine performance. 
SELECT 
    DAYNAME(date) AS day_of_week, 
    SUM(mk.cost) / SUM(mk.conversions) AS CPA,
    (SUM(mk.clicks) / SUM(mk.impressions)) AS CTR,
    (SUM(mk.conversions) / SUM(mk.clicks)) AS CVR
FROM marketing_data mk 
GROUP BY day_of_week
ORDER BY CVR DESC 

