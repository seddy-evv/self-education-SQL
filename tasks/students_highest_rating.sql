CREATE TABLE grp(
  id int,
  name varchar(255),
  PRIMARY KEY (id));

INSERT INTO
 grp
VALUES
 (1, 'math'),
 (2, 'biology'),
 (3, 'chemistry');

CREATE TABLE users(
  id int NOT NULL,
  name varchar(255),
  rating int,
  grp_id int NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (grp_id) REFERENCES grp(id)
);

INSERT INTO
 users
VALUES
 (1, 'Alex', 55, 1),
 (2, 'Bob', 60, 1),
 (3, 'Mike', 65, 2),
 (4, 'John', 65, 2);

CREATE INDEX user_name_rating ON users (name, rating);
-- List users who have the highest rating in their groups

WITH user_grp AS (
  SELECT
    users.id AS id,
    users.name AS name,
    users.rating AS rating,
    users.grp_id AS grp_id,
    grp.name AS grp_name
  FROM
    users
    INNER JOIN grp ON users.grp_id = grp.id
),
users_res AS (
SELECT
  id,
  name,
  grp_id,
  grp_name,
  rating,
  ROW_NUMBER() OVER (PARTITION BY grp_id ORDER BY rating DESC) as user_rank
FROM
  user_grp)

SELECT
  *
FROM
  users_res
WHERE
  user_rank = 1
--+----+-----+------+--------+------+---------+
--|  id| name|grp_id|grp_name|rating|user_rank|
--+----+-----+------+--------+------+---------+
--|   2|  Bob|     1|    math|    60|        1|
--|   3| Mike|     2| biology|    65|        1|
--+----+-----+------+--------+------+---------+

--As we can see a student from the "biology" group will be selected randomly, if we need to select several students
--with the highest rating we can use the functions: rank() or dense_rank()
