create table employe_details6(Employee_ID int,
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

copy employe_details6 from 'D:/Empl_details.csv' DELIMITER ',' csv header;
select * from employe_details6
SELECT first_name AS Name, last_name AS Surname
FROM employe_details6
WHERE Salary BETWEEN 30000 AND 50000;


