USE CustomerDB;
--SQL Queries for Data Extraction

--Retrieve all customer information
SELECT * FROM Customers;


--Find all transactions made by a specific customer
SELECT * 
FROM Transactions
WHERE CustomerID= 15569120;


--Get all interactions of a specific customer
SELECT * 
FROM Interactions
WHERE CustomerID= 15569120;


--Find the total amount spent by each customer
SELECT CustomerID, SUM(TransactionAmount) AS TotalAmount
FROM Transactions
GROUP BY CustomerID;


--List the top 5 customers who spent the most
SELECT TOP 5 C.Surname,SUM(T.TransactionAmount) AS TotalAmountSpent
FROM Customers C
JOIN Transactions T 
ON C.CustomerId=T.CustomerID
GROUP BY C.Surname
ORDER BY TotalAmountSpent DESC;


--Get customers who have had interactions but haven’t made any transactions
SELECT C.Surname
FROM Customers C
LEFT JOIN Transactions T 
ON C.CustomerID=T.CustomerID
LEFT JOIN Interactions I 
ON C.CustomerId = I.CustomerID
WHERE T.TransactionID IS NULL AND I.CustomerID IS NOT NULL;





--SQL Queries for Basic Analysis

--Find the number of transactions per customer
SELECT CustomerID,COUNT(*) AS NumOfTransactions
FROM Transactions
GROUP BY CustomerID;

--Calculate the average transaction amount per customer
SELECT CustomerID , AVG(TransactionAmount) AS AvgTransactionAmount 
FROM Transactions 
GROUP BY CustomerID;

--Get the most popular transaction type by the number of transactions
SELECT TOP 1 TransactionType , COUNT(*) AS TransactionCount
FROM Transactions
GROUP BY TransactionType
ORDER BY TransactionCount DESC;


--Get the total number of interactions per customer
SELECT CustomerID,COUNT(*) AS InteractionCount
FROM Interactions
GROUP BY CustomerID;

--Find all transactions and corresponding customer information
SELECT C.CustomerId,C.Surname,T.TransactionType,T.TransactionAmount,T.TransactionDate
FROM Transactions T 
JOIN Customers C
ON T.CustomerID=C.CustomerId;


--List all interactions along with customer details
SELECT C.CustomerId,C.Surname,I.InteractionType,I.InteractionDate
FROM Customers C
JOIN Interactions I 
ON C.CustomerId=I.CustomerID;


--Get a summary report with the total amount spent and number of interactions for each customer
SELECT I.CustomerID, SUM(T.TransactionAmount) AS TotalAmount , COUNT(InteractionID) AS NumOfInteractions
FROM Interactions I 
JOIN Transactions T
ON I.CustomerID=T.CustomerID
GROUP BY I.CustomerID;



