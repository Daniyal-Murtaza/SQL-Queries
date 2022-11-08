--q1
select * from Customers

--q2
select OrderId, OrderDate, ShipCity, ShipCountry from Orders

--q3
select OrderId, OrderDate, CustomerID from Orders where ShipCountry = 'France'

--q4
select OrderId, OrderDate, CustomerID from Orders where ShipCountry = 'France' or ShipCountry =  'Germany'

--q5
select OrderId, OrderDate, Freight, ShipCountry from Orders where Freight > 40 and ShipCountry = 'France' or ShipCountry =  'Germany'

--q6
select OrderId, OrderDate, Freight, ShipName from Orders where ShipName = 'Quick-Stop'

--q7
select TitleOFCourtesy + ' ' + firstname + ' ' + lastname as 'Employee Full Name', title as 'Employee Title' from employees 

--q8
select OrderId, OrderDate, ShipName, ShipAddress, ShipCity, ShipCountry from Orders where ShipAddress like '%box%'

--q9
select  OrderId, CustomerID from Orders where CustomerID like 'A%I'

--q10
select firstname + ' ' + lastname as 'EmployeeName' from employees  where YEAR(GETDATE()) - YEAR(HireDate) > 10

--q11
select *, datediff(day, OrderDate, shippedDate) from Orders

--q12
select OrderID from Orders where DATEPART(Month, OrderDate) = 6

--q13
select *, Fax from Customers where Fax is NULL

--q14
select QuantityPerUnit from Products where QuantityPerUnit like '%boxes%'

--q15
select SupplierID from Suppliers where Fax is not NULL

--q16
select count(CustomerID) from Customers where Fax is NULL

--q17
select count(SupplierID) from Suppliers

--q18
select OrderID, OrderDate from Orders where  DATEPART(Year, OrderDate) = 1997

--q19
select CustomerID, country from Customers where country = 'UK'

--q20
select sum(UnitsinStock) from Products

--q21
select sum(UnitsinStock*unitprice) from Products