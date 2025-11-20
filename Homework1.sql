-- Student: أيمن حمدان
-- University ID: 202220609



-- Q1) Employee Database DDL


CREATE TABLE employee (
    ID INT PRIMARY KEY,
    person_name VARCHAR(100),
    street VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE company (
    company_name VARCHAR(100) PRIMARY KEY,
    city VARCHAR(50)
);

CREATE TABLE works (
    ID INT,
    company_name VARCHAR(100),
    salary DECIMAL(10,2),
    PRIMARY KEY (ID, company_name),
    FOREIGN KEY (ID) REFERENCES employee(ID),
    FOREIGN KEY (company_name) REFERENCES company(company_name)
);

CREATE TABLE manages (
    ID INT PRIMARY KEY,
    manager_id INT,
    FOREIGN KEY (ID) REFERENCES employee(ID),
    FOREIGN KEY (manager_id) REFERENCES employee(ID)
);


-- Q2) Bank Database Queries


-- A) Customers who have an account but not a loan
SELECT DISTINCT d.ID
FROM depositor d
WHERE d.ID NOT IN (
    SELECT b.ID
    FROM borrower b
);

-- B) Customers who live on the same street and city as customer '54321'
SELECT c.ID
FROM customer c
WHERE c.customer_street = (
        SELECT customer_street 
        FROM customer 
        WHERE ID = '54321'
    )
  AND c.customer_city = (
        SELECT customer_city 
        FROM customer 
        WHERE ID = '54321'
    )
  AND c.ID <> '54321';  -- Exclude the same customer

-- C) Branches that have at least one customer living in "Harrison"
SELECT DISTINCT a.branch_name
FROM account a
JOIN depositor d ON a.account_number = d.account_number
JOIN customer c ON d.ID = c.ID
WHERE c.customer_city = 'Harrison';
