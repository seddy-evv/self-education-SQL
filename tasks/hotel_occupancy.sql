--We have a log of hotel check-ins and check-outs.
--The log is presented as records with the following fields:
--user_id (VARCHAR) — unique user identifier.
--event_type (VARCHAR) — event type: 'IN' — user checked in. 'OUT' — user checked out.
--ts (TIMESTAMP) — date and time of the event.
--
--We need to display how many people were in the hotel by day.


CREATE TABLE hotel(
  user_id INT,
  event_type varchar(255),
  ts DATETIME
);

INSERT INTO
	hotel
VALUES
    (1, 'IN','2022-01-01 10:00:00'),
	(2, 'IN','2022-01-01 10:00:00'),
	(1, 'OUT','2022-01-06 10:00:00'),
    (4, 'IN','2022-01-06 10:00:00'),
    (5, 'IN','2022-01-06 10:00:00'),
    (6, 'IN','2022-01-07 10:00:00'),
    (8, 'IN','2022-01-10 10:00:00'),
    (2, 'OUT','2022-01-10 10:00:00'),
    (1, 'IN','2022-02-01 10:00:00');


WITH hotel_agg AS (
  SELECT
    FORMAT(ts, 'yyyy-MM-dd') AS day,
    CASE
      WHEN event_type = 'IN' THEN COUNT (user_id)
      WHEN event_type = 'OUT' THEN (- COUNT(user_id))
      ELSE 0
    END AS res
  FROM
    hotel
  GROUP by
    event_type,
    FORMAT(ts, 'yyyy-MM-dd')
),
hotel_sum AS(
  SELECT
    day,
    SUM(res) AS sum_res
  FROM
    hotel_agg
  GROUP BY
    day
)
SELECT
  day,
  SUM(sum_res) OVER(ORDER BY day ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS agg_res
FROM
  hotel_sum
ORDER BY
  day asc;
--+----------+--------+
--|       day| agg_res|
--+----------+--------+
--|2022-01-01|       2|
--|2022-01-06|       3|
--|2022-01-07|       4|
--|2022-01-10|       4|
--|2022-02-01|       5|
--+----------+--------+
