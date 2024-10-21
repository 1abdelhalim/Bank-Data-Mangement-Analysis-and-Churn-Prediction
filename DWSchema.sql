CREATE DATABASE CustomerDW;
USE CustomerDW;


CREATE TABLE DimCustomer
(
    CustomerID INT PRIMARY KEY,   
    Surname VARCHAR(50),          
    CreditScore INT,              
    Geography VARCHAR(50),        
    Gender VARCHAR(10),           
    Age INT,                     
    Tenure INT,                   
    NumOfProducts INT,            
    HasCrCard INT,                
    IsActiveMember INT,           
    EstimatedSalary DECIMAL(10, 2),
	Exited INT
);

CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,        -- Unique Key (YYYYMMDD format)
    Date DATE,                      -- Actual Date
    Day INT,                        -- Day of the month
    Month INT,                      
    Year INT,                       
    Quarter INT,                    
    DayOfWeek VARCHAR(10),          
    MonthName VARCHAR(15),          
    IsWeekend BIT                   -- 1 if it's a weekend, 0 if not
);


CREATE TABLE DimTransactionTypes (
    TransactionTypeID INT IDENTITY(1,1) PRIMARY KEY, 
    TransactionType VARCHAR(50)         
);

CREATE TABLE DimInteractionTypes (
    InteractionTypeID INT IDENTITY(1,1) PRIMARY KEY, 
    InteractionType VARCHAR(50)         
);

CREATE TABLE FactTransactions (
    TransactionID INT PRIMARY KEY,
    CustomerID INT,                 
    DateKey INT,                    
	TransactionTypeID INT,
    TransactionAmount DECIMAL(10, 2),
    Balance DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID),
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
	FOREIGN KEY (TransactionTypeID) REFERENCES DimTransactionTypes(TransactionTypeID)
);

CREATE TABLE FactInteractions (
    InteractionID INT PRIMARY KEY,
    CustomerID INT,
    DateKey INT,                   
    InteractionTypeID INT,
    FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID),
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
	FOREIGN KEY (InteractionTypeID) REFERENCES DimInteractionTypes(InteractionTypeID)
);



