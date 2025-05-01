-- Select rows from the second table that are not in the first.
-- Create tables and insert records
CREATE TABLE Persons (
  PersonID int,
  LastName varchar(255),
  FirstName varchar(255),
  Address varchar(255),
  City varchar(255)
);

INSERT INTO
    Persons
VALUES
    (1, 'Smith', 'John', '123 Elm St', 'Springfield'),
    (2, 'Johnson', 'Emma', '456 Maple Ave', 'Riverside'),
    (3, 'Brown', 'Oliver', '789 Oak Dr', 'Lakeside'),
    (4, 'Jones', 'Sophia', '101 Pine Rd', 'Hillview'),
    (5, 'Garcia', 'Liam', '202 Birch Ln', 'Greenville'),
    (6, 'Martinez', 'Isabella', '303 Cedar Ct', 'Sunnyvale'),
    (7, 'Davis', 'Ethan', '404 Spruce Blvd', 'Fairview'),
    (8, 'Rodriguez', 'Mia', '505 Willow St', 'Elmwood'),
    (9, 'Wilson', 'Ava', '606 Ash Way', 'Brookfield'),
    (10, 'Moore', 'Lucas', '707 Cherry Cir', 'Ridgewood');

CREATE TABLE Persons1 (
  PersonID int,
  LastName varchar(255),
  FirstName varchar(255),
  Address varchar(255),
  City varchar(255)
);

INSERT INTO
    Persons1
VALUES
    (1, 'Smith', 'John', '123 Elm St', 'Springfield'),
    (2, 'Johnson', 'Emma', '456 Maple Ave', 'Riverside'),
    (3, 'Brown', 'Oliver', '789 Oak Dr', 'Lakeside'),
    (4, 'Jones', 'Sophia', '101 Pine Rd', 'Hillview'),
    (5, 'Garcia', 'Liam', '202 Birch Ln', 'Greenville');

-- Select rows
SELECT
  Persons.*
FROM
  Persons
  LEFT JOIN Persons1 ON Persons.PersonID = Persons1.PersonID
WHERE
  Persons1.PersonID IS NULL
--+--------+-----------+-----------+------------------+-------------+
--|PersonID|   LastName|  FirstName|           Address|         City|
--+--------+-----------+-----------+------------------+-------------+
--|       6|   Martinez|   Isabella|      303 Cedar Ct|    Sunnyvale|
--|       7|      Davis|      Ethan|   404 Spruce Blvd|     Fairview|
--|       8|  Rodriguez|        Mia|     505 Willow St|      Elmwood|
--|       9|     Wilson|        Ava|       606 Ash Way|   Brookfield|
--|      10|      Moore|      Lucas|    707 Cherry Cir|    Ridgewood|
--+--------+-----------+-----------+------------------+-------------+
