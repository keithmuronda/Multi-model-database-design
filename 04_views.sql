CREATE VIEW instructor_modules AS
SELECT i.instructor_name, m.module_name
FROM INSTRUCTOR i
JOIN MODULE m
ON i.instructor_id = m.instructor_id;
