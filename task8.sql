create table employe_details8(Employee_ID int,
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
copy employe_details8 from 'D:/Empl_details.csv' DELIMITER ',' csv header;
select * from employe_details8

DELETE FROM Employe_details8
WHERE employee_id BETWEEN 1 AND 5;

