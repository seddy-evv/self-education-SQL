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
