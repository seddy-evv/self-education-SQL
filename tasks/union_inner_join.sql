-- The situation in which a UNION will provide fewer records than a INNER JOIN

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
   (0, 1, 2);

-- Create the table2 and insert records
CREATE TABLE table2
(
   num1   INT,
   id1  INT,
   val1  INT
);

INSERT INTO
  table2
VALUES
  (0, 1, 2),
  (0, 1, 2),
  (1, 22, 3);

-- INNER JOIN
SELECT
  *
FROM
  table1 INNER JOIN table2
  ON table1.id1 = table2.id1
--+----+---+----+----+---+----+
--|num1|id1|val1|num1|id1|val1|
--+----+---+----+----+---+----+
--|   0|  1|   2|   0|  1|   2|
--|   0|  1|   2|   0|  1|   2|
--|   0|  1|   2|   0|  1|   2|
--|   0|  1|   2|   0|  1|   2|
--+----+---+----+----+---+----+

-- UNION
SELECT
  *
FROM
  table1
UNION
SELECT
  *
FROM
  table2
--+----+---+----+
--|num1|id1|val1|
--+----+---+----+
--|   0|  1|   2|
--|   1| 22|   3|
--+----+---+----+

-- UNION ALL
SELECT
  *
FROM
  table1
UNION ALL
SELECT
  *
FROM
  table2
--+----+---+----+
--|num1|id1|val1|
--+----+---+----+
--|   0|  1|   2|
--|   0|  1|   2|
--|   0|  1|   2|
--|   0|  1|   2|
--|   1| 22|   3|
--+----+---+----+
