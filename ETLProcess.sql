-- Insert unique transaction types with a unique ID
INSERT INTO CustomerDW.dbo.DimTransactionTypes (TransactionType)
SELECT DISTINCT TransactionType
FROM CustomerDB.dbo.Transactions;


-- Load unique interaction types
INSERT INTO CustomerDW.dbo.DimInteractionTypes (InteractionType)
SELECT DISTINCT InteractionType
FROM CustomerDB.dbo.Interactions;



-- Insert into DimDate
INSERT INTO CustomerDW.dbo.DimDate(DateKey, Date, Day, Month, Year, Quarter, DayOfWeek, MonthName, IsWeekend)
SELECT 
    CONVERT(INT, FORMAT(UniqueDate, 'yyyyMMdd')) AS DateKey, -- DateKey in YYYYMMDD format
    UniqueDate AS Date,                                       -- Actual date
    DAY(UniqueDate) AS Day,                                   -- Day of the month
    MONTH(UniqueDate) AS Month,                               -- Month number
    YEAR(UniqueDate) AS Year,                                 -- Year
    DATEPART(QUARTER, UniqueDate) AS Quarter,                 -- Quarter (1-4)
    DATENAME(WEEKDAY, UniqueDate) AS DayOfWeek,               -- Day name (e.g., Monday)
    DATENAME(MONTH, UniqueDate) AS MonthName,                 -- Month name (e.g., January)
    CASE 
        WHEN DATENAME(WEEKDAY, UniqueDate) IN ('Saturday', 'Sunday') THEN 1 
        ELSE 0 
    END AS IsWeekend                                                -- IsWeekend flag (1 = weekend, 0 = not weekend)
FROM 
    (   SELECT DISTINCT CAST(TransactionDate AS DATE) AS UniqueDate
		FROM CustomerDB.dbo.Transactions

		UNION

		SELECT DISTINCT CAST(InteractionDate AS DATE) AS UniqueDate
		FROM CustomerDB.dbo.Interactions) AS DateList;                           -- Ensure unique dates are inserted




-- Insert data into DimCustomer
INSERT INTO CustomerDW.dbo.DimCustomer (CustomerID, Surname, CreditScore, Geography, Gender, Age, Tenure, NumOfProducts, HasCrCard, IsActiveMember, EstimatedSalary, Exited)
SELECT 
    CustomerID,
    Surname,
    CreditScore,
    Geography,
    Gender,
    CAST(Age AS INT),
    Tenure,
    NumOfProducts,
    CAST(HasCrCard AS INT),  
    CAST(IsActiveMember AS INT), 
    EstimatedSalary,
    Exited
FROM 
    CustomerDB.dbo.Customers;


-- Insert data into FactTransactions
INSERT INTO CustomerDW.dbo.FactTransactions (TransactionID, CustomerID, DateKey, TransactionTypeID, TransactionAmount, Balance)
SELECT t.TransactionID, 
       t.CustomerID, 
       CONVERT(INT, FORMAT(t.TransactionDate, 'yyyyMMdd')) AS DateKey,
       (SELECT dt.TransactionTypeID 
        FROM CustomerDW.dbo.DimTransactionTypes dt
        WHERE dt.TransactionType = t.TransactionType) AS TransactionTypeID,
       t.TransactionAmount, 
       t.Balance
FROM CustomerDB.dbo.Transactions t;



-- Insert data into FactInteractions
INSERT INTO CustomerDW.dbo.FactInteractions (InteractionID,CustomerID,DateKey,InteractionTypeID)
SELECT i.InteractionID,
	   i.CustomerID,
	   CONVERT(INT,FORMAT(i.InteractionDate, 'yyyyMMdd')) AS DateKey,
	   (SELECT di.InteractionTypeID
	   FROM CustomerDW.dbo.DimInteractionTypes di
	   WHERE di.InteractionType=i.InteractionType) AS InteractionTypeID
FROM CustomerDB.dbo.Interactions i;
	
	



