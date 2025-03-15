create table employe_details5(Employee_ID int,
First_Name	varchar,
Last_Name varchar,	
Email varchar,	
Phone_Number int,	
Hire_Date	date,
Salary	int,
Department_ID int,
Is_Active	Boolean,
Job_Title varchar
)

copy employe_details5 from 'D:/Empl_details.csv' DELIMITER ',' csv header;

select * from employe_details5

UPDATE Employe_details5
SET Salary = Salary * 1.08  -- Increases salary by 8%
WHERE Is_Active = FALSE 
AND Department_ID = 0 
AND Job_Title IN ('HR Manager', 'Financial Analyst', 'Business Analyst', 'Data Analyst');





