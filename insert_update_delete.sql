--q1
SET IDENTITY_INSERT PRODUCTS ON
INSERT INTO PRODUCTS (
    PRODUCTID,
    PRODUCTNAME,
    CATEGORYID,
    UNITPRICE
) VALUES (
    2050,
    'Mountain Dew',
    1,
    10
)
SET IDENTITY_INSERT PRODUCTS OFF

--q2
SET IDENTITY_INSERT PRODUCTS
ON INSERT INTO PRODUCTS (PRODUCTID,
PRODUCTNAME,
CATEGORYID,
UNITPRICE) VALUES (2051,
'Tea',
(
    SELECT
        CATEGORYID
    FROM
        CATEGORIES
    WHERE
        CATEGORYNAME LIKE 'Beverages'
),
10)
SET IDENTITY_INSERT PRODUCTS OFF

--q3
    UPDATE PRODUCTS SET UNITPRICE = UNITPRICE + (UNITPRICE * 1.25)
WHERE
    CATEGORYID IN (
        SELECT
            CATEGORYID
        FROM
            CATEGORIES
        WHERE
            CATEGORYNAME LIKE 'Beverages'
    )

--q4
    UPDATE [ORDER DETAILS] SET DISCOUNT = UNITPRICE * (20 /100)
FROM
    ORDERS
WHERE
    ORDERS.ORDERID = [ORDER DETAILS].ORDERID
    AND SHIPPEDDATE IS NULL

--q5
INSERT INTO CATEGORIES (CATEGORYNAME) VALUES ( 'Drinks')

--q6
SET IDENTITY_INSERT PRODUCTS
ON INSERT INTO PRODUCTS(PRODUCTID,
PRODUCTNAME,
SUPPLIERID,
CATEGORYID,
QUANTITYPERUNIT,
UNITPRICE,
UNITSINSTOCK,
UNITSONORDER,
REORDERLEVEL,
DISCONTINUED)
SELECT
    PRODUCTNAME,
    SUPPLIERID,
    (
    SELECT
        CATEGORYID
    FROM
        CATEGORIES
    WHERE
        CATEGORYNAME LIKE 'Drinks'),
        QUANTITYPERUNIT,
        UNITPRICE,
        UNITSINSTOCK,
        UNITSONORDER,
        REORDERLEVEL,
        DISCONTINUED
    FROM
        PRODUCTS,
        CATEGORIES
    WHERE
        PRODUCTS.CATEGORYID = CATEGORIES.CATEGORYID
        AND CATEGORYNAME LIKE 'Beverages' SET IDENTITY_INSERT PRODUCTS OFF

--q7
    UPDATE PRODUCTS SET CATEGORYID = (
        SELECT
            CATEGORYID
        FROM
            CATEGORIES
        WHERE
            CATEGORYNAME LIKE 'Drinks'
    )
WHERE
    CATEGORYID IN (
        SELECT
            CATEGORYID
        FROM
            CATEGORIES
        WHERE
            CATEGORYNAME LIKE 'Beverages'
    )

--q8(a)
    DELETE EMPLOYEETERRITORIES
WHERE
    EMPLOYEEID = (
        SELECT
            EMPLOYEEID
        FROM
            EMPLOYEES
        WHERE
            FIRSTNAME + ' ' + LASTNAME LIKE 'Nancy Davolio'
    )

--q8(b)
 SELECT
    (
    SELECT
        EMPLOYEEID
    FROM
        EMPLOYEES
    WHERE
        FIRSTNAME + ' ' + LASTNAME LIKE 'Nancy Davolio'),
        TERRITORYID
    FROM
        EMPLOYEETERRITORIES
    WHERE
        EMPLOYEEID = (
            SELECT
                EMPLOYEEID
            FROM
                EMPLOYEES
            WHERE
                FIRSTNAME + ' ' + LASTNAME LIKE 'Robert King'
        )




--q9(a)
    UPDATE EMPLOYEES SET REPORTSTO = (
        SELECT
            EMPLOYEEID
        FROM
            EMPLOYEES
        WHERE
            (FIRSTNAME + ' ' + LASTNAME LIKE 'Robert King')
    )
WHERE
    REPORTSTO = (
        SELECT
            EMPLOYEEID
        FROM
            EMPLOYEES
        WHERE
            (FIRSTNAME + ' ' + LASTNAME LIKE 'Steven Buchanan')
    )

 --q9(b)
UPDATE ORDERS SET EMPLOYEEID = (
    SELECT
        REPORTSTO
    FROM
        EMPLOYEES
    WHERE
        (FIRSTNAME + ' ' + LASTNAME LIKE 'Steven Buchanan')
)
WHERE
    EMPLOYEEID = (
        SELECT
            EMPLOYEEID
        FROM
            EMPLOYEES
        WHERE
            (FIRSTNAME + ' ' + LASTNAME LIKE 'Steven Buchanan')
    )

--q9(c)
    DELETE EMPLOYEETERRITORIES
WHERE
    EMPLOYEEID = (
        SELECT
            EMPLOYEEID
        FROM
            EMPLOYEES
        WHERE
            (FIRSTNAME + ' ' + LASTNAME LIKE 'Steven Buchanan')
    )

--q9(d)
    DELETE EMPLOYEES
WHERE
    EMPLOYEEID = (
        SELECT
            EMPLOYEEID
        FROM
            EMPLOYEES
        WHERE
            (FIRSTNAME + ' ' + LASTNAME LIKE 'Steven Buchanan')
    )

--q10
    DELETE PRODUCTS
WHERE
    UNITPRICE > 1000

--q11
    DELETE PRODUCTS
WHERE
    UNITPRICE < 5
    AND CATEGORYID IN (
        SELECT
            CATEGORYID
        FROM
            CATEGORIES
        WHERE
            CATEGORYNAME LIKE 'Seafood'
    )

--q12
    DELETE CATEGORIES
WHERE
    CATEGORYID NOT IN (
        SELECT
            DISTINCT(CATEGORYID)
        FROM
            PRODUCTS
    )

--q13
    DELETE ORDERS
WHERE
    CUSTOMERID LIKE 'ALFKI'

--q14
    DELETE ORDERS
WHERE
    DATEPART(YEAR,
    SHIPPEDDATE) = 1996
    AND DATEPART(MONTH,
    SHIPPEDDATE) = 8
    SELECT
        *
    FROM
        ORDERS