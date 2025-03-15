SELECT * FROM public.employee_details
copy employee_details from 'D:/Empl_details.csv' DELIMITER ',' csv header;