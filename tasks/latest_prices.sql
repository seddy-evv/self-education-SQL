-- For each product in the ProductPricesFact select the most recent price

--- Create tables and insert records
CREATE TABLE ProductPricesFact (
  ID int,
  Product varchar(255),
  EntryDate DATE,
  Price int
);

INSERT INTO
    ProductPricesFact
VALUES
    (1, 'Laptop', '2022-01-01', 2100),
    (2, 'Laptop', '2022-02-02', 1950),
    (3, 'Tablet', '2022-01-01', 2800),
    (4, 'Tablet', '2023-02-02', 3200),
    (5, 'Tablet', '2023-02-02', 3300),
    (6, 'Keyboard', '2022-03-03', NULL),
    (7, 'Keyboard', '2022-03-03', 800);

-- Get most recent prices
WITH ProductPricesRank AS (
  SELECT
    ID,
    Product,
    EntryDate,
    Price,
    row_number() OVER (PARTITION BY product ORDER BY EntryDate DESC, ID DESC) AS price_rank
  FROM
    ProductPricesFact
)
SELECT
  *
FROM
  ProductPricesRank
WHERE
  price_rank = 1
--+--------+-----------+-----------+-------+-------------+
--|      ID|    Product|  EntryDate|  Price|   price_rank|
--+--------+-----------+-----------+-------+-------------+
--|       7|   Keyboard| 2022-03-03|    800|            1|
--|       2|     Laptop| 2022-02-02|   1950|            1|
--|       5|     Tablet| 2023-02-02|   3300|            1|
--+--------+-----------+-----------+-------+-------------+
