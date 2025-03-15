SELECT * FROM public.employe_details
UPDATE employe_details
SET department_id = 0
WHERE is_active = FALSE;
ALTER TABLE employee_database ADD COLUMN State VARCHAR(50);
UPDATE employee_database
SET State = CASE 
    WHEN is_active = TRUE THEN 'Active' 
    ELSE 'Inactive' 
END;
SELECT * FROM employee_database;
