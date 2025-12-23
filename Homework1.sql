-- Student: أيمن حمدان
-- University ID: 202220609


CREATE TABLE employee (
    ID INT PRIMARY KEY,
    person_name NVARCHAR(50),
    street NVARCHAR(50),
    city NVARCHAR(50)
);

CREATE TABLE company (
    company_name NVARCHAR(50) PRIMARY KEY,
    city NVARCHAR(50)
);

CREATE TABLE works (
    ID INT,
    company_name NVARCHAR(50),
    salary DECIMAL(10,2),
    PRIMARY KEY (ID, company_name),
    FOREIGN KEY (ID) REFERENCES employee(ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (company_name) REFERENCES company(company_name)
        ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE manages (
    ID INT PRIMARY KEY,
    manager_id INT NULL,
    FOREIGN KEY (ID) REFERENCES employee(ID)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (manager_id) REFERENCES employee(ID)
);



--Q2

--A) Customers who have account but NOT loan

SELECT DISTINCT d.ID
FROM depositor d
WHERE NOT EXISTS (
    SELECT 1
    FROM borrower b
    WHERE b.ID = d.ID
);

--B) Same street & city as customer '12345'

SELECT c1.ID
FROM customer c1
CROSS JOIN (
    SELECT customer_street, customer_city
    FROM customer
    WHERE ID = '12345'
) x
WHERE c1.customer_street = x.customer_street
  AND c1.customer_city = x.customer_city
  AND c1.ID <> '12345';

--C) Branch with customer from Harrison having account

SELECT DISTINCT b.branch_name
FROM branch b
WHERE EXISTS (
    SELECT *
    FROM account a
    JOIN depositor d ON a.account_number = d.account_number
    JOIN customer c ON c.ID = d.ID
    WHERE a.branch_name = b.branch_name
      AND c.customer_city = 'Harrison'

    --Q3
--A) Cumulative Sum
SELECT 
    day,
    qty,
    SUM(qty) OVER (ORDER BY day) AS cumQty
FROM demand;
 
 --B) Two worst qty days per product (SQL Server)

 WITH ranked AS (
    SELECT 
        product,
        day,
        qty,
        ROW_NUMBER() OVER (
            PARTITION BY product
            ORDER BY qty ASC
        ) AS RN
    FROM demand_table
)
SELECT product, day, qty, RN
FROM ranked
WHERE RN <= 2;



