SELECT * FROM bd_finance.financialsample;

CREATE TABLE currencies (
currency_id INT AUTO_INCREMENT PRIMARY KEY,
currency_name VARCHAR(100) NOT NULL,
currency_symbol VARCHAR(10),
iso_code VARCHAR(5) NOT NULL,
exchange_rate DECIMAL(15, 6), -- Exchange rate with precision for currency conversion
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
country varchar(45)
);

INSERT INTO currencies (currency_name, currency_symbol, iso_code, exchange_rate, country)
VALUES
('Canadian Dollar', 'CAD$', 'CAD', NULL, 'CANADA'),
('Euro', '€', 'EUR', NULL, 'FRANCE'),
('Euro', '€', 'EUR', NULL, 'GERMANY'),
('US Dollar', '$', 'USD', NULL, 'UNITED STATES OF AMERICA'),
('Mexican Peso', '$', 'MXN', NULL, 'MEXICO');

SELECT * FROM currencies;

update currencies set exchange_rate = 20.48 where currency_id = 5;

SELECT * FROM currencies;

SELECT * FROM financialsample;


SELECT t1.Country, t1.Product, t1.SalePrice, t1.ManufacturingPrice, t2.exchange_rate
FROM financialsample as t1
Inner join currencies as t2
 on t1.Country = t2.Country
where t1.Country ='Mexico' and t1.Year = 2014 and t1.MonthNumber in (1,2)
Order by Date ASC;

