CREATE DATABASE CustomerDB;
USE CustomerDB;


CREATE TABLE Customers (
    CustomerId INT PRIMARY KEY,					
    Surname VARCHAR(50),                        
    CreditScore int,                             
    Geography VARCHAR(50),                      
    Gender VARCHAR(10),                         
    Age int,                         
    Tenure int,                                 
    NumOfProducts int,                 
    HasCrCard int,                             
    IsActiveMember int,                        
    EstimatedSalary decimal(10,2),              
    Exited int                                   
);

ALTER TABLE Customers
ALTER COLUMN Age VARCHAR(10);

ALTER TABLE Customers
ALTER COLUMN HasCrCard VARCHAR(10);


ALTER TABLE Customers
ALTER COLUMN IsActiveMember VARCHAR(10);


CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    TransactionDate DATE,
    TransactionAmount DECIMAL(10, 2),
    TransactionType VARCHAR(50),
	Balance DECIMAL(10, 2),
);

CREATE TABLE Interactions (
    InteractionID INT PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    InteractionType VARCHAR(50),
    InteractionDate DATE,
);


