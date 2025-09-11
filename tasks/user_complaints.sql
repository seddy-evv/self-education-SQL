-- Create a query to display the IDs of users whose complaints came on the last day in the table and complaints from 
-- these users were not received before this day
CREATE TABLE Complaints (
  PersonID int,
  Complaint varchar(255),
  EntryDate DATE,
);

INSERT INTO
    Complaints
VALUES
    (1, 'Issue1', '2023-01-01'),
    (2, 'Issue2', '2023-01-01'),
    (2, 'Issue3', '2023-01-02'),
    (3, 'Issue4', '2023-01-02'),
    (4, 'Issue5', '2023-01-02'),
    (1, 'Issue6', '2023-01-03'),
    (5, 'Issue7', '2023-01-03'),
    (5, 'Issue8', '2023-01-03'),
    (6, 'Issue9', '2023-01-03');

With old_ids AS (
  SELECT
    Distinct personid
  FROM
    Complaints
  WHERE
    entrydate < (SELECT MAX(entrydate) FROM Complaints)
)
SELECT
  DISTINCT comp.personid
FROM
  Complaints AS comp
  LEFT JOIN old_ids as old ON comp.personid = old.personid
WHERE
  comp.entrydate = (SELECT MAX(entrydate) FROM Complaints)
  AND old.personid IS NULL
--+----------+
--|  personid|
--+----------+
--|         5|
--|         6|
--+----------+
