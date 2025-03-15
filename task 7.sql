create table employe_details7(Employee_ID int,
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
copy employe_details7 from 'D:/Empl_details.csv' DELIMITER ',' csv header;
select * from employe_details7
SELECT * FROM employe_details7
WHERE first_name LIKE 'A%';



