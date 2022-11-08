--Q1
SELECT
    COMPANYNAME
FROM
    CUSTOMERS
WHERE
    CUSTOMERID NOT IN(
        SELECT
            CUSTOMERID
        FROM
            ORDERS
    )

 --Q2
SELECT
    DISTINCT ORDERID
FROM
    [ORDER DETAILS]
WHERE
    PRODUCTID IN(
        SELECT
            PRODUCTID
        FROM
            PRODUCTS
        WHERE
            CATEGORYID IN (
                SELECT
                    CATEGORYID
                FROM
                    CATEGORIES
                WHERE
                    CATEGORYNAME = 'Meat\poultry'
                    OR CATEGORYNAME = 'Dairy Products'
            )
    )

 --Q3
SELECT
    DISTINCT ORDERID
FROM
    [ORDER DETAILS]
WHERE
    PRODUCTID IN(
        SELECT
            PRODUCTID
        FROM
            PRODUCTS
        WHERE
            CATEGORYID NOT IN (
                SELECT
                    CATEGORYID
                FROM
                    CATEGORIES
                WHERE
                    CATEGORYNAME = 'Meat\poultry'
                    OR CATEGORYNAME = 'Dairy Products'
            )
    )

--Q4
SELECT
    TOP 1 EMPLOYEES.FIRSTNAME+EMPLOYEE.LASTNAME
FROM
    ORDERS.EMPLOYEES
WHERE
    ORDERS.EMPLOYEEID = EMPLOYEES.EMPLOYEEID
    AND DATEPART(YEAR.ORDERDATE) = "1997"

--Q5
SELECT
    EMPLOYEES.FIRSTNAME + EMPLOYEES.LASTNAME,
    EMPLOYEEID
FROM
    EMPLOYEES
WHERE
    EMPLOYEES.REPORTSTO = (
        SELECT
            EMPLOYEEID
        FROM
            EMPLOYEES
        WHERE
            REPORTSTO IS NULL
    )

-- Q6
SELECT
    DISTINCT EMPLOYEEID
FROM
    EMPLOYEETERRITORIES
WHERE
    TERRITORYID IN (
        SELECT
            TERRITORYID
        FROM
            TERRITORIES
        WHERE
            REGIONID IN (
                SELECT
                    REGIONID
                FROM
                    REGION
                WHERE
                    REGIONDESCRIPTION = 'Western'
            )
    )

 -- Q7
SELECT
    EMPLOYEEID
FROM
    EMPLOYEES
WHERE
    EMPLOYEEID NOT IN (
        SELECT
            DISTINCT EMPLOYEEID
        FROM
            EMPLOYEETERRITORIES
        WHERE
            TERRITORYID IN (
                SELECT
                    TERRITORYID
                FROM
                    TERRITORIES
                WHERE
                    REGIONID IN (
                        SELECT
                            REGIONID
                        FROM
                            REGION
                        WHERE
                            REGIONDESCRIPTION = 'Western'
                    )
            )
    )

--Q8
SELECT
    ORDERID
FROM
    ORDERS
WHERE
    ORDERS.EMPLOYEEID IN (
        SELECT
            DISTINCT EMPLOYEES.EMPLOYEEID
        FROM
            EMPLOYEES,
            TERRITORIES,
            EMPLOYEETERRITORIES,
            REGION
    )
WHERE
    (EMPLOYEES.EMPLOYEEID = EMPLOYEETERRITORIES.EMPLOYEEID
    AND TERRITORIES.TERRITORYID = EMPLOYEETERRITORIES.TERRITORYID
    AND REGION.REGIONID = TERRITORIES.REGIONID)
    AND (REGIONDESCRIPTION<>"Western"))

--Q9
(
    SELECT
        COMPANYNAME AS NAME
    FROM
        CUSTOMERS
    WHERE
        CUSTOMERS.COUNTRY = 'USA'
) UNION (
    SELECT
        COMPANYNAME AS NAME
    FROM
        SUPPLIERS
    WHERE
        SUPPLIERS.COUNTRY = 'USA'
)

 --Q10
SELECT
    TOP 1 PRODUCTNAME,
    UNITPRICE
FROM
    PRODUCTS
ORDER BY
    UNITPRICE ASC

--Q11
SELECT
    DISTINCT SUPPLIERS.COMPANYNAME
FROM
    SUPPLIERS,
    PRODUCTS,
    CATEGORIES
WHERE
    (SUPPLIERS.SUPPLIERID = PRODUCTS.SUPPLIERID
    AND PRODUCTS.CATEGORYID = CATEGORIES.CATEGORYID)
    AND (CATEGORIES.CATEGORYNAME = 'Beverages')

--Q12
SELECT
    MIN(PRODUCTS.PRODUCTNAME) AS PRODUCTNAME,
    MIN(PRODUCTS.CATEGORYID) AS CATEGORYID,
    COUNT(*)

 --Q13
SELECT
    EMPLOYEEID,
    CASE
        WHEN DATEDIFF(YEAR, EMPLOYEES, HIREDATE, '2022') > 5 THEN
            'Seniority Level = 3'
        WHEN DATEDIFF(YEAR, EMPLOYEES, HIREDATE, '2022') > 3 THEN
            'Seniority Level = 2'
        ELSE
            'Seniority Level = 1'
    END AS SENIORITYLEVEL
FROM
    EMPLOYEES

 --Q14
SELECT
    PRODUCTNAME,
    CASE
        WHEN UNITPRICE > 80 THEN
            'Costly'
        WHEN UNITPRICE > 30 THEN
            'Economical'
        WHEN UNITPRICE < 30 THEN
            'Cheap'
    END AS TYPES
FROM
    PRODUCTS