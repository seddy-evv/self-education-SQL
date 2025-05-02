-- Count the number of buyers who buy different products
-- Create tables and insert records
CREATE TABLE Purchases (
  PersonID int,
  Product varchar(255),
  City varchar(255)
);

INSERT INTO
    Purchases
VALUES
    (1, 'Laptop', 'Springfield'),
    (2, 'Smartphone', 'Riverside'),
    (3, 'Tablet', 'Lakeside'),
    (1, 'Laptop', 'Springfield'),
    (2, 'Monitor', 'Greenville'),
    (6, 'Keyboard', 'Sunnyvale'),
    (7, 'Mouse', 'Fairview'),
    (8, 'Smartwatch', 'Elmwood'),
    (9, 'Camera', 'Brookfield'),
    (3, 'Gaming Console', 'Ridgewood');

-- Get the number of buyers
WITH persons_agg AS
	(SELECT
      PersonID
    FROM
      Purchases
    GROUP BY
      PersonID
    HAVING
      Count(DISTINCT Product) > 1)

SELECT
  COUNT (PersonID) AS result
FROM persons_agg;
--+------+
--|result|
--+------+
--|     2|
--+------+
