--find users making 2+ purchases within last 24 hours
SELECT
    user_id,
    COUNT(purchase_id) AS total_purchases
FROM purchases
WHERE purchase_time >= CURRENT_TIMESTAMP() - INTERVAL 24 HOURS
-- PostgreSQL / MySQL: NOW() - INTERVAL '24 hour' (or NOW() - INTERVAL 1 DAY)
-- SQL Server (T-SQL): DATEADD(hour, -24, GETDATE())
-- Oracle: SYSDATE - 1
-- BigQuery: TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 24 HOUR)
GROUP BY user_id
HAVING COUNT(purchase_id) >= 2;


-- in case if we need 2 or more purchases within ANY 24-hour window.
WITH RankedPurchases AS (
    SELECT
        user_id,
        purchase_time,
        LEAD(purchase_time, 1) OVER (
            PARTITION BY user_id
            ORDER BY purchase_time
        ) AS next_purchase_time
    FROM purchases
)
SELECT DISTINCT user_id
FROM RankedPurchases
WHERE next_purchase_time <= purchase_time + INTERVAL 24 HOURS;
-- WHERE next_purchase_time <= purchase_time + INTERVAL '24 hour': Filters for rows where the gap between the current
-- purchase and the next one is 24 hours or less.
