--1
SELECT e1.last_name, TO_CHAR(e1.hire_date, 'MONTH-yyyy') "Luna an angajare"
FROM employees e1 JOIN employees e2
USING(department_id)
WHERE UPPER(e2.last_name) = 'GATES'
    AND UPPER(e1.last_name) LIKE '%A%';
    
SELECT e1.last_name, TO_CHAR(e1.hire_date, 'MONTH-yyyy') "Luna an angajare"
FROM employees e1, employees e2
WHERE e1.department_id = e2.department_id
    AND UPPER(e2.last_name) = 'GATES'
    AND UPPER(e1.last_name) LIKE '%A%';

--2
SELECT DISTINCT e1.employee_id, e1.last_name
FROM employees e1 JOIN employees e2
ON (e1.department_id = e2.department_id
    AND e1.employee_id <> e2.employee_id)
WHERE UPPER(e2.last_name) LIKE '%T%'
ORDER BY last_name;

SELECT DISTINCT e1.employee_id, e1.last_name
FROM employees e1, employees e2
WHERE e1.department_id = e2.department_id
    AND e1.employee_id <> e2.employee_id
    AND UPPER(e2.last_name) LIKE '%T%'
ORDER BY last_name;

--3
SELECT e1.last_name, e1.salary, job_title, city, country_name
FROM employees e1, employees e2, departments d, locations l, countries c, jobs j
WHERE e1.manager_id = e2.employee_id
    AND UPPER(e2.last_name) = 'KING'
    AND e1.department_id = d.department_id
    AND d.location_id = l.location_id
    AND l.country_id = c.country_id
    AND j.job_id = e1.job_id;

--4
SELECT d.department_id, d.department_name, e.last_name, j.job_title, TO_CHAR(e.salary, '$99,999.00')
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN jobs j ON e.job_id = j.job_id
WHERE UPPER(e.last_name) LIKE('%TI%')
ORDER BY d.department_name, e.last_name;

--5
SELECT e.last_name, e.department_id, d.department_name, l.city, j.job_title
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN jobs j ON e.job_id = j.job_id
WHERE UPPER(l.city) = 'OXFORD';

--6
SELECT DISTINCT e1.employee_id, e1.last_name, e1.salary
FROM employees e1 JOIN employees e2
ON (e1.department_id = e2.department_id
    AND e1.employee_id <> e2.employee_id)
WHERE UPPER(e2.last_name) LIKE '%T%'
    AND e1.salary > (SELECT AVG(e3.salary)
                     FROM employees e3
                     WHERE e1.job_id = e3.job_id);
                     
--7
SELECT last_name, department_name
FROM employees e1 RIGHT OUTER JOIN departments d
ON (e1.department_id = d.department_id);

SELECT last_name, department_name
FROM departments d, employees e
WHERE d.department_id = e.department_id (+);

--8
SELECT d.department_name, e.last_name
FROM departments d
LEFT OUTER JOIN employees e ON d.department_id = e.department_id;

SELECT d.department_name, e.last_name
FROM departments d, employees e 
WHERE d.department_id = e.department_id (+);

--9
SELECT last_name, department_name
FROM departments d, employees e
WHERE d.department_id (+) = e.department_id
UNION
SELECT last_name, department_name
FROM departments d, employees e
WHERE e.department_id = d.department_id (+);