-- Purchases table columns: OrderID, UsersID, OrderDate, Amount
-- Users table columns: UsersID, Country, SignupDate
--
-- Enrich each order with the user’s country and signup date.
--
-- Consider only users who signed up in the last 1 year.
-- From those users, return the top 2 countries by total order amount.


--Databricks SQL implementation
CREATE TABLE Purchases (
  OrderID int,
  UsersID int,
  OrderDate DATE,
  Amount int
);

CREATE TABLE Users (
  UsersID int,
  Country varchar(255),
  SignupDate DATE
);


INSERT INTO
    Purchases
VALUES
    (1, 11, "2026-01-01", 250),
    (2, 22, "2024-01-01", 350),
    (3, 33, "2026-02-01", 450),
    (4, 44, "2026-03-01", 150),
    (5, 55, "2025-01-01", 600),
    (6, 11, "2026-01-01", 250);

INSERT INTO
    Users
VALUES
    (11, "USA", "2026-01-01"),
    (22, "Canada", "2024-01-01"),
    (33, "Germany", "2026-02-01"),
    (44, "UK", "2026-03-01"),
    (55, "Poland", "2025-01-01");

WITH UsersFiltered AS (
    SELECT
     *
    FROM
     Users
    WHERE
     to_date(SignupDate) > date_sub(current_date(), 365)
)

SELECT
 Country,
 SUM(Amount) as SumAmount
FROM
 Purchases p
JOIN
 UsersFiltered uf
ON
 p.UsersID = uf.UsersID
GROUP BY
 Country
ORDER BY
 SUM(Amount) DESC
LIMIT 2
--+----------+----------+
--|   Country| SumAmount|
--+----------+----------+
--|       USA|       500|
--|   Germany|       450|
--+----------+----------+
