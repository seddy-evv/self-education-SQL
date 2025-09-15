-- Find the 3-month rolling average of total revenue from purсhases given a table with users,
-- their purchase amount, and date purchases (YYYY-MM-DD).
-- Output the year-month (YYYY-MM) and 3-month rolling average of revenue, sorted form earliest month to latest month.

 CREATE TABLE purchases1 (
    user_id INT,
    purchase_amount DOUBLE,
    purchase_date DATE
 );

--OR

 CREATE TABLE purchases1 (
    user_id INT,
    purchase_amount DECIMAL(9,2),
    purchase_date DATE
 );

 INSERT INTO purchases1 VALUES
     (1, 100.0, '2021-01-10'),
     (2, 150.0, '2021-01-20'),
     (3, 250.0, '2021-01-30'),
     (1, 200.0, '2021-02-15'),
     (2, 300.0, '2021-02-22'),
     (1, 150.0, '2021-03-01'),
     (3, 180.0, '2021-03-18'),
     (1, 120.0, '2021-04-05'),
     (2, 220.0, '2021-04-25'),
     (3, 160.0, '2021-05-16'),
     (1, 140.0, '2021-05-29'),
     (2, 280.0, '2021-06-10');

WITH purchases1_sum AS (
  SELECT
    FORMAT(purchase_date, 'yyyy-MM') AS year_month, -- or '%Y-%m' or DATE_FORMAT
    SUM(purchase_amount) AS purchase_amount_sum
  FROM
    purchases1
  GROUP BY
    FORMAT(purchase_date, 'yyyy-MM') -- or '%Y-%m' or DATE_FORMAT
)

SELECT
  year_month,
  AVG(purchase_amount_sum) OVER (
    ORDER BY year_month
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
  ) AS rolling_avg
FROM
  purchases1_sum
ORDER BY
  year_month ASC;
--+----------+--------------+
--|year_month|   rolling_avg|
--+----------+--------------+
--|   2021-01|        500.00|
--|   2021-02|        500.00|
--|   2021-03|        443.33|
--|   2021-04|        390.00|
--|   2021-05|        323.33|
--|   2021-06|        306.66|
--+----------+--------------+
