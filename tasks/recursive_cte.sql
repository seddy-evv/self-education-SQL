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
