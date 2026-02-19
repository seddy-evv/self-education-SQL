-- pivot and unpivot SQL functions

 CREATE TABLE predictions (
    prediction varchar(255),
    actual varchar(255),
    date_pred DATE,
    model varchar(255)
 );

 INSERT INTO predictions VALUES
 	(1, 0, '2025-10-01', 'XGB'),
    (1, 1, '2025-10-02', 'XGB'),
    (0, 1, '2025-10-03', 'XGB'),
    (1, 0, '2025-10-04', 'XGB'),
    (1, 1, '2025-10-05', 'XGB'),
    (0, 0, '2025-10-06', 'XGB'),
    (1, 0, '2025-10-07', 'XGB'),
    (0, 1, '2025-10-08', 'XGB'),
    (1, 0, '2025-10-09', 'XGB'),
    (0, 0, '2025-10-10', 'XGB'),
    (0, 1, '2025-10-11', 'XGB'),
    (1, 1, '2025-10-12', 'XGB'),
    (1, 0, '2025-10-13', 'XGB');

-- PIVOT
WITH confusion_matrix AS (
  SELECT
    model,
    CASE WHEN (prediction = 1 AND actual = 1) THEN'TP'
      WHEN (prediction = 1 AND actual = 0) THEN 'FP'
      WHEN (prediction = 0 AND actual = 1) THEN 'FN'
      WHEN (prediction = 0 AND actual = 0) THEN 'TN'
      ELSE NULL
    END AS confusion
  FROM
    predictions
)
-- Databricks SQL
SELECT
  *
FROM
  (
    SELECT
      model,
      confusion
    FROM
      confusion_matrix
  )
    PIVOT (count(confusion) FOR confusion IN ('TP' AS TP, 'FP' AS FP, 'TN' AS TN, 'FN' AS FN))
--+----------+-------+------+------+------+
--|     model|     TP|    FP|    TN|    FN|
--+----------+-------+------+------+------+
--|       XGB|      3|     5|     2|     3|
--+----------+-------+------+------+------+

-- MS SQL
SELECT model, [TP], [FP], [TN], [FN]
FROM
(
    SELECT model, confusion
    FROM confusion_matrix
) AS SourceTable
PIVOT
(
    COUNT(confusion)
    FOR confusion IN ([TP], [FP], [TN], [FN])
) AS PivotTable;
