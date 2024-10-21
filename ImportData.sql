use CustomerDB
go

BULK INSERT Customers
FROM 'D:\Rewad\Project\dataset\Customer.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);


BULK INSERT transactions
FROM 'D:\Rewad\Project\dataset\Transcations.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

BULK INSERT Interactions
FROM 'D:\Rewad\Project\dataset\Interactions.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
