--The recursive CTE (Common Table Expression) is useful for scenarios like hierarchical data traversal, such as
--organizational charts, bill of materials, or tree structures.
--For example find all employees under a specific manager (e.g., Alice).
CREATE TABLE employees (
  employee_id int,
  manager_id int,
  name varchar(255)
);

INSERT INTO employees VALUES
  (1, NULL, "Alice"),
  (2, 1, "Bob"),
  (3, 1, "Carol"),
  (4, 2, "Dave"),
  (5, 2, "Eve");

--Recursive CTEs are common table expressions defined with the RECURSIVE keyword. They consist of two parts combined
--by using UNION ALL:
WITH RECURSIVE employee_hierarchy AS (
    -- This runs once and seeds the recursion
    SELECT employee_id,
      manager_id,
      "" as manager_name,
      name,
      1 AS level
    FROM
      employees
    WHERE
      manager_id IS NULL  -- Start from top manager (Alice)

    UNION ALL

    -- This refers to the CTE itself and is repeatedly applied to build new rows.
    -- This continues until no new rows are produced.
    SELECT
      e.employee_id,
      e.manager_id,
      eh.name,
      e.name,
      eh.level + 1
    FROM
      employees e
    INNER JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT
  *
FROM
  employee_hierarchy
ORDER BY
  level, employee_id;
--+-------------+-----------+--------------+------+--------+
--|  employee_id| manager_id|  manager_name|  name|   level|
--+-------------+-----------+--------------+------+--------+
--|            1|       null|              | Alice|       1|
--|            2|          1|         Alice|   Bob|       2|
--|            3|          1|         Alice| Carol|       2|
--|            4|          2|           Bob|  Dave|       3|
--|            5|          2|           Bob|   Eve|       3|
--+-------------+-----------+--------------+------+--------+
