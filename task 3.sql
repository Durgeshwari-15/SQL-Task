create table course (course_id int,	course_name varchar,	category varchar,	created_at date)

create table enrollement(enrollment_id int,	student_id int,	course_id int,	enrolled_on date,	status varchar)

create table student(student_id int,	name varchar,	email varchar,	registration_date date)


 Retrieve all students who have an active enrollment

SELECT DISTINCT s.*
FROM student s
JOIN enrollement e ON s.student_id = e.student_id
WHERE e.status = 'active';

Find the most enrolled courses

SELECT course_id, COUNT(*) AS total_enrollment
FROM enrollement e
GROUP BY course_id
ORDER BY total_enrollment DESC
LIMIT 1;

Find students who enrolled in at least 2 courses

SELECT student_id
FROM enrollement
GROUP BY student_id
HAVING COUNT(DISTINCT course_id) >= 2;

List courses that have no students enrolled

SELECT c.*
FROM course c
LEFT JOIN enrollement e ON c.course_id = e.course_id
WHERE e.course_id IS NULL;


 Find enrollments with conditional labels

SELECT *
FROM enrollement
WHERE label IS NOT NULL;

Count the number of enrollments per course

SELECT course_id, COUNT(*) AS enrollement_count
FROM enrollement
GROUP BY course_id;

Get students who have never enrolled in any course

SELECT s.*
FROM student s
LEFT JOIN enrollement e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

Get students who have enrolled in both 'Python for Data Science' and
'SQL Mastery'

SELECT e1.student_id
FROM enrollement e1
JOIN course c1 ON e1.course_id = c1.course_id AND c1.course_name = 'Python for Data Science'
JOIN enrollement e2 ON e1.student_id = e2.student_id
JOIN course c2 ON e2.course_id = c2.course_id AND c2.course_name = 'SQL Mastery';


Get the latest enrolled students (last 5 enrollments)

SELECT s.*
FROM enrollement e
JOIN student s ON e.student_id = s.student_id
ORDER BY e.enrollement_date DESC
LIMIT 5;

Count the number of students enrolled in each category of courses

SELECT cat.name, COUNT(DISTINCT e.student_id) AS student_count
FROM enrollement e
JOIN course c ON e.course_id = c.id
JOIN categories cat ON c.category_id = cat.id
GROUP BY cat.name;

Find students who have completed at least one course

SELECT DISTINCT s.*
FROM enrollement e
JOIN student s ON e.student_id = s.student_id
WHERE e.status = 'completed';

Retrieve students enrolled in courses under 'Programming' category

SELECT DISTINCT s.*
FROM enrollement e
JOIN student s ON e.student_id = s.student_id
JOIN course c ON e.course_id = c.course_id
JOIN categories cat ON c.category_id = category_id
WHERE cat.name = 'Programming';

Get the total number of enrollments per month

SELECT DATE_TRUNC('month', enroll_on date) AS month, COUNT(*) AS total
FROM enrollement
GROUP BY month
ORDER BY month;

Find students who enrolled but never completed a course

SELECT s. *
FROM student s
JOIN enrollement e ON s.student_id = e.student_id
GROUP BY s.student_id
HAVING SUM(CASE WHEN e.status = 'completed' THEN 1 ELSE 0 END) = 0;

Get the earliest and latest enrollment date

SELECT MIN(enrollement date) AS earliest, MAX(enrollement date) AS latest
FROM enrollement;

Get students who enrolled in the last 6 months

SELECT DISTINCT s.*
FROM enrollement e
JOIN student s ON e.student_id = s.student_id
WHERE e.enrollement date >= CURRENT_DATE - INTERVAL '6 months';

Find courses with more than 5 enrollments

SELECT course_id, COUNT(*) AS enrollment_count
FROM enrollement
GROUP BY course_id
HAVING COUNT(*) > 5;

Get students and their most recent enrollment date

SELECT student_id, MAX(registration_date) AS latest_enrollment
FROM enrollement
GROUP BY student_id;

Find students who enrolled but dropped a course

SELECT DISTINCT s.*
FROM enrollement e
JOIN student s ON e.student_id = s.student_id
WHERE e.status = 'dropped';

List courses with the highest number of enrollments

SELECT c.*, COUNT(e.course_id) AS total_enrollement
FROM course c
JOIN enrollement e ON c.course_id = e.course_id
GROUP BY c.course_id
ORDER BY total_enrollement DESC
LIMIT 5;
