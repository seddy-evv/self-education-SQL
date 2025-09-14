-- ONE TABLE HAS DUPLICATE KEYS

-- Create the table1 and insert records
CREATE TABLE table1
(
   num1   INT,
   id1  INT,
   val1  INT
);

INSERT INTO
   table1
VALUES
   (0, 1, 2),
   (1, 1, 2),
   (2, 1, 2),
   (3, 11, 2);

SELECT
  *
FROM
  table1;
--+----+---+----+
--|num1|id1|val1|
--+----+---+----+
--|   0|  1|   2|
--|   1|  1|   2|
--|   2|  1|   2|
--|   3| 11|   2|
--+----+---+----+

-- Create the table2 and insert records
CREATE TABLE table2
(
   num2   INT,
   id2  INT,
   val2  INT
);

INSERT INTO
  table2
VALUES
  (0, 1, 3),
  (1, 22, 3);

SELECT
  *
FROM
  table2;
--+----+---+----+
--|num2|id2|val2|
--+----+---+----+
--|   0|  1|   3|
--|   1| 22|   3|
--+----+---+----+

--INNER JOIN
SELECT
  *
FROM
  table1 INNER JOIN table2
  ON table1.id1 = table2.id2
--+----+---+----+----+---+----+
--|num1|id1|val1|num2|id2|val2|
--+----+---+----+----+---+----+
--|   0|  1|   2|   0|  1|   3|
--|   1|  1|   2|   0|  1|   3|
--|   2|  1|   2|   0|  1|   3|
--+----+---+----+----+---+----+

-- Also INNER JOIN
SELECT
  *
FROM
  table1, table2
  WHERE table1.id1 = table2.id2
--+----+---+----+----+---+----+
--|num1|id1|val1|num2|id2|val2|
--+----+---+----+----+---+----+
--|   0|  1|   2|   0|  1|   3|
--|   1|  1|   2|   0|  1|   3|
--|   2|  1|   2|   0|  1|   3|
--+----+---+----+----+---+----+

--LEFT JOIN
SELECT
  *
FROM
  table1 LEFT JOIN table2
  ON table1.id1 = table2.id2;
--+----+---+----+----+----+----+
--|num1|id1|val1|num2| id2|val2|
--+----+---+----+----+----+----+
--|   0|  1|   2|   0|   1|   3|
--|   1|  1|   2|   0|   1|   3|
--|   2|  1|   2|   0|   1|   3|
--|   3| 11|   2|NULL|NULL|NULL|
--+----+---+----+----+----+----+

-- FULL/OUTER
SELECT
  *
FROM
  table1 FULL JOIN table2
  ON table1.id1 = table2.id2;
--+----+----+----+----+----+----+
--|num1| id1|val1|num2| id2|val2|
--+----+----+----+----+----+----+
--|   0|   1|   2|   0|   1|   3|
--|   1|   1|   2|   0|   1|   3|
--|   2|   1|   2|   0|   1|   3|
--|   3|  11|   2|NULL|NULL|NULL|
--|NULL|NULL|NULL|   1|  22|   3|
--+----+----+----+----+----+----+

-- CROSS JOIN (A cross join creates a set of rows where each row from one table is joined to each row from a second table)
SELECT
  *
FROM
  table1, table2;
-- OR
SELECT
  *
FROM
  table1 CROSS JOIN table2;
--+----+---+----+----+----+----+
--|num1|id1|val1|num2| id2|val2|
--+----+---+----+----+----+----+
--|   0|  1|   2|   0|   1|   3|
--|   1|  1|   2|   0|   1|   3|
--|   2|  1|   2|   0|   1|   3|
--|   3| 11|   2|   0|   1|   3|
--|   1|  1|   2|   1|  22|   3|
--|   3| 11|   2|   1|  22|   3|
--|   2|  1|   2|   1|  22|   3|
--|   3| 11|   2|   1|  22|   3|
--+----+---+----+----+----+----+


-- BOTH TABLES HAVE DUPLICATE KEYS
-- Create the table3 and insert records
CREATE TABLE table3
(
   num3   INT,
   id3  INT,
   val3  INT
);

INSERT INTO
   table3
VALUES
   (0, 1, 2),
   (1, 1, 2),
   (2, 1, 2),
   (3, 11, 2);

SELECT
  *
FROM
  table3;
--+----+---+----+
--|num3|id3|val3|
--+----+---+----+
--|   0|  1|   2|
--|   1|  1|   2|
--|   2|  1|   2|
--|   3| 11|   2|
--+----+---+----+

-- Create the table4 and insert records
CREATE TABLE table4
(
   num4   INT,
   id4  INT,
   val4  INT
);

INSERT INTO
  table4
VALUES
  (0, 1, 3),
  (1, 1, 3),
  (2, 22, 3);

SELECT
  *
FROM
  table4;
--+----+---+----+
--|num4|id4|val4|
--+----+---+----+
--|   0|  1|   3|
--|   1|  1|   3|
--|   2| 22|   3|
--+----+---+----+

--INNER JOIN
SELECT
  *
FROM
  table3 INNER JOIN table4
  ON table3.id3 = table4.id4;
--+----+---+----+----+---+----+
--|num3|id3|val3|num4|id4|val4|
--+----+---+----+----+---+----+
--|   0|  1|   2|   0|  1|   3|
--|   1|  1|   2|   0|  1|   3|
--|   2|  1|   2|   0|  1|   3|
--|   0|  1|   2|   1|  1|   3|
--|   1|  1|   2|   1|  1|   3|
--|   2|  1|   2|   1|  1|   3|
--+----+---+----+----+---+----+

-- Also INNER JOIN
SELECT
  *
FROM
  table3, table4
  WHERE table3.id3 = table4.id4;
--+----+---+----+----+---+----+
--|num3|id3|val3|num4|id4|val4|
--+----+---+----+----+---+----+
--|   0|  1|   2|   0|  1|   3|
--|   1|  1|   2|   0|  1|   3|
--|   2|  1|   2|   0|  1|   3|
--|   0|  1|   2|   1|  1|   3|
--|   1|  1|   2|   1|  1|   3|
--|   2|  1|   2|   1|  1|   3|
--+----+---+----+----+---+----+

--LEFT JOIN
SELECT
  *
FROM
  table3 LEFT JOIN table4
  ON table3.id3 = table4.id4;
--+----+---+----+----+----+----+
--|num3|id3|val3|num4| id4|val4|
--+----+---+----+----+----+----+
--|   0|  1|   2|   0|   1|   3|
--|   1|  1|   2|   0|   1|   3|
--|   2|  1|   2|   0|   1|   3|
--|   0|  1|   2|   1|   1|   3|
--|   1|  1|   2|   1|   1|   3|
--|   2|  1|   2|   1|   1|   3|
--|   3| 11|   2|NULL|NULL|NULL|
--+----+---+----+----+----+----+

-- FULL/OUTER
SELECT
  *
FROM
  table3 FULL JOIN table4
  ON table3.id3 = table4.id4;
--+----+----+----+----+----+----+
--|num3| id3|val3|num4| id4|val4|
--+----+----+----+----+----+----+
--|   0|   1|   2|   0|   1|   3|
--|   1|   1|   2|   0|   1|   3|
--|   2|   1|   2|   0|   1|   3|
--|   0|   1|   2|   1|   1|   3|
--|   1|   1|   2|   1|   1|   3|
--|   2|   1|   2|   1|   1|   3|
--|   3|  11|   2|NULL|NULL|NULL|
--|NULL|NULL|NULL|   2|  22|   3|
--+----+----+----+----+----+----+

-- CROSS JOIN (A cross join creates a set of rows where each row from one table is joined to each row from a second table)
SELECT
  *
FROM
  table3, table4;
-- OR
SELECT
  *
FROM
  table3 CROSS JOIN table4;
--+----+---+----+----+----+----+
--|num3|id3|val3|num4| id4|val4|
--+----+---+----+----+----+----+
--|   0|  1|   2|   0|   1|   3|
--|   1|  1|   2|   0|   1|   3|
--|   2|  1|   2|   0|   1|   3|
--|   3| 11|   2|   0|   1|   3|
--|   0|  1|   2|   1|   1|   3|
--|   1|  1|   2|   1|   1|   3|
--|   2|  1|   2|   1|   1|   3|
--|   3| 11|   2|   1|   1|   3|
--|   0|  1|   2|   2|  22|   3|
--|   1|  1|   2|   2|  22|   3|
--|   2|  1|   2|   2|  22|   3|
--|   3| 11|   2|   2|  22|   3|
--+----+---+----+----+----+----+
