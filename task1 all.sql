-- Task 1: Create the Employee_DetailsTask1 Table
CREATE TABLE Employee_Details_Task1 (EmployeeID serial,
    FirstName VARCHAR NOT NULL,
    LastName VARCHAR NOT NULL,
    Email VARCHAR UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    HireDate DATE NOT NULL,
    Salary DECIMAL(10,2) CHECK (Salary > 0),
    DepartmentID INTEGER NOT NULL,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
   JobTitle VARCHAR NOT NULL
);

-- Task 2: 
INSERT INTO Employee_Details_Task1 (EmployeeID, FirstName, LastName, Email, PhoneNumber, HireDate, Salary, DepartmentID, IsActive, JobTitle)
VALUES 
('1', 'akash', 'gupta', 'akgupta@gmail.com', '9867594214', '2020-05-10', 45000.00, 3, TRUE, 'Software Engineer'),
('2', 'yash', 'Sharma', 'yashsh@gamil.com', '8975642311', '2019-08-15', 55000.00, 2, TRUE, 'HR Manager'),
('3', 'manoj', 'shon', 'shon@gmail.com', '9586412354', '2021-02-20', 32000.00, 4, FALSE, 'Data Analyst'),
('4', 'Charlie', 'gupta', 'charlie.@gmail.com', '8765423191', '2018-11-25', 60000.00, 1, TRUE, 'Financial Analyst'),
('5', 'Devid', 'jain', 'davidjain@gmail.com', '9658743214', '2017-09-30', 40000.00, 5, FALSE, 'Business Analyst');



-- Task 3: 
COPY Employee_Details_Task1
FROM 'D:/Arc database/Employee_Details.csv'
DELIMITER ','
CSV HEADER;

-- Task 4: 
UPDATE Employee_Details_Task1
SET DepartmentID = 0
WHERE IsActive = FALSE;

-- Task 5: 
UPDATE Employee_Details_Task1
SET Salary = Salary * 1.08
WHERE IsActive = FALSE 
AND DepartmentID = 0
AND JobTitle IN ('HR Manager', 'Financial Analyst', 'Business Analyst', 'Data Analyst');

-- Task 6: 
SELECT FirstName AS Name, LastName AS Surname 
FROM Employee_Details_Task1
WHERE Salary BETWEEN 30000 AND 50000;

 select * from Employee_Details_Task1

-- Task 7: 
SELECT * FROM Employee_Details_Task1
WHERE FirstName LIKE 'A%';

-- Task 8: 
DELETE FROM Employee_Details_task1
WHERE EmployeeID BETWEEN 1 AND 5;

-- Task 9: 
ALTER TABLE Employee_Details_Task1 RENAME TO employee_database;
ALTER TABLE employee_database RENAME COLUMN FirstName TO Name;
ALTER TABLE employee_database RENAME COLUMN LastName TO Surname;

-- Task 10
ALTER TABLE employee_database ADD COLUMN State VARCHAR NOT NULL DEFAULT 'India';


UPDATE employee_database
SET State = 'USA'
WHERE IsActive = FALSE;
 select * from employee_database
