create table employe_details9(Employee_ID int,
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
copy employe_details from 'D:/Empl_details.csv' DELIMITER ',' csv header;

select * from employe_details9

alter table employe_details9 rename to employee_database
select * from employee_database
ALTER TABLE employee_database RENAME COLUMN First_name TO Name;
ALTER TABLE employee_database RENAME COLUMN last_name TO Surname;




