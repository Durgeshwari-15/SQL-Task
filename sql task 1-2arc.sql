create table employe_details(Employee_ID int,
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

select * from employe_details 


insert into employe_details (Employee_id, First_Name, Last_Name, Email, Phone_Number, Hire_Date, Salary,Department_ID, Is_Active, Job_Title) values
( 1, 'Jay', 'paik', 'jay12@gamil.com', 876569822, '2022-05-15', 75000, 10, 'yes', 'Devloper'),
(2, 'Yash', 'Yadav', 'yashd123@gmil.com', 876564534, '2021-08-10', 68000, 13, 'yes', 'HR'),
(3, 'vijay', 'Sharma', 'vijaysh@gamil.com',876758883 , '2020-11-20',82000, 18, 'No', 'Finance'),
(4, 'Ajay', 'chavan', 'ajay@gamil.com', 865439238, '2023-02-01', 72000, 12, 'yes', 'Marketing'),
(5, 'sushil', 'Gupta', 'sush@gmail.com', 854398654, '2019-06-25', 65000, 14, 'No', 'Operations');



