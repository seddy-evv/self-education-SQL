--There is data on sales, car, model, price, date, city. It is necessary to output the result in the form of car,
--model and average sale price if the average price exceeds 20k.

 CREATE TABLE car_sales (
    car varchar(255),
    model varchar(255),
    price DECIMAL(9,2),
    sale_date DATE,
    city varchar(255)
 );

 INSERT INTO car_sales VALUES
 	('Audi', 'RS', 15000.00, '2021-01-10', 'NY'),
    ('BMW', 'X5', 10000.00, '2021-01-10', 'NY'),
    ('Audi', 'RS', 30000.00, '2021-01-10', 'LA'),
    ('BMW', 'X6', 40000.00, '2021-01-10', 'NY'),
    ('Audi', 'RS', 25000.00, '2021-01-10', 'Paris'),
    ('BMW', 'X6', 50000.00, '2021-01-10', 'LA');

SELECT
  car,
  model,
  AVG(price) AS avg_price
FROM
  car_sales
GROUP BY
  car,
  model
HAVING
  AVG(price) > 20000
--+----------+--------------+--------------+
--|       car|         model|     avg_price|
--+----------+--------------+--------------+
--|      Audi|            RS|      23333.33|
--|       BMW|            X6|      45000.00|
--+----------+--------------+--------------+
