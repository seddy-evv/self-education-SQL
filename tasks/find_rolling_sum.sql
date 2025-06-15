-- Coding Question: SQL. find the daily overall rolling sum of total amount from purсhases.

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    total_amount INT,
    order_date DATE
);

CREATE TABLE payments (
    order_id INT,
    payment_amount DECIMAL(9, 2)
);

CREATE TABLE customers (
    customer_id INT,
    customer_name varchar(255),
    region varchar(255)
);

INSERT INTO orders VALUES
     (1, 1, 100, '2021-01-10'),
     (2, 2, 150, '2021-01-20'),
     (3, 3, 250, '2021-01-30'),
     (4, 1, 200, '2021-02-15'),
     (5, 2, 300, '2021-02-22'),
     (6, 1, 150, '2021-03-01'),
     (7, 3, 180, '2021-03-18'),
     (8, 1, 120, '2021-04-05'),
     (9, 2, 220, '2021-04-25'),
     (10, 3, 160, '2021-05-16'),
     (11, 1, 140, '2021-05-29'),
     (12, 2, 280, '2021-06-10');


INSERT INTO payments VALUES
     (1, 1000.0),
     (2, 1110.55),
     (3, 2530.3),
     (4, 2003.0),
     (5, 3100.0),
     (6, 1250.0),
     (7, 1380.44),
     (8, 1420.0),
     (9, 2120.0),
     (10, 1160.66),
     (11, 1340.0),
     (12, 2811.3);

INSERT INTO customers VALUES
     (1, 'Alex', 'NY'),
     (2, 'Bob', 'LA'),
     (3, 'John', 'Texas');

WITH order_payments AS (
SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.total_amount,
    COALESCE(SUM(p.payment_amount), 0) AS total_paid
FROM orders o
LEFT JOIN payments p ON o.order_id = p.order_id
GROUP BY o.order_id, o.customer_id, o.order_date, o.total_amount
)

SELECT
c.customer_id,
c.customer_name,
c.region,
op.order_id,
op.order_date,
op.total_amount,
op.total_paid,
SUM(op.total_amount) OVER (
    PARTITION BY c.customer_id
    ORDER BY op.order_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS running_total_by_customer
FROM order_payments op
JOIN customers c ON op.customer_id = c.customer_id
ORDER BY c.customer_id, op.order_date;
--+----+-----------+--------------+-------+---------+------------+-------------+-----------+--------------------------+
--| row|customer_id| customer_name| region| order_id|  order_date| total_amount| total_paid| running_total_by_customer|
--+----+-----------+--------------+-------+---------+------------+-------------+-----------+--------------------------+
--|   1|          1|          Alex|     NY|        1|  2021-01-10|          100|    1000.00|                       100|
--|   2|          1|          Alex|     NY|        4|  2021-02-15|          200|    2003.00|                       300|
--|   3|          1|          Alex|     NY|        6|  2021-03-01|          150|    1250.33|                       450|
--|   4|          1|          Alex|     NY|        8|  2021-04-05|          120|    1420.00|                       570|
--|   5|          1|          Alex|     NY|       11|  2021-05-29|          140|    1340.00|                       710|
--|   6|          2|           Bob|     LA|        2|  2021-01-20|          150|    1110.55|                       150|
--|   7|          2|           Bob|     LA|        5|  2021-02-22|          300|    3100.00|                       450|
--|   8|          2|           Bob|     LA|        9|  2021-04-25|          220|    2120.00|                       670|
--|   9|          2|           Bob|     LA|       12|  2021-06-10|          280|    2811.30|                       950|
--|  10|          3|          John|     LA|        3|  2021-01-30|          250|    2530.30|                       250|
--|  11|          3|          John|     LA|        7|  2021-03-18|          180|    1380.44|                       430|
--|  12|          3|          John|     LA|       10|  2021-01-10|          160|    1160.66|                       590|
--+----+-----------+--------------+-------+---------+------------+-------------+-----------+--------------------------+
