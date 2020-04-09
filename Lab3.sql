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

--10
SELECT e.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND UPPER(d.department_name) LIKE('%RE%')
UNION
SELECT e.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND UPPER(d.department_name) = 'SA_REP';
    
--11 APARE REZULTATUL CU DUPLICATE

--12 
SELECT d.department_id
FROM departments d
LEFT OUTER JOIN employees e ON d.department_id = e.department_id
MINUS
SELECT d.department_id
FROM departments d
JOIN employees e ON d.department_id = e.department_id;

SELECT d.department_id
FROM departments d, employees e 
WHERE d.department_id = e.department_id (+)
MINUS
SELECT d.department_id
FROM departments d, employees e 
WHERE d.department_id = e.department_id;

--13
SELECT e.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND UPPER(d.department_name) LIKE('%RE%')
INTERSECT
SELECT e.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND UPPER(job_id) = 'HR_REP';
    
--14
SELECT employee_id, job_id, last_name
FROM employees
WHERE salary > 3000
UNION
SELECT e.employee_id, j.job_id, last_name
FROM employees e, jobs j
WHERE e.job_id = j.job_id
    AND salary = (min_salary + max_salary)/2;

--15
SELECT last_name, hire_date
FROM employees
WHERE hire_date > (SELECT hire_date
                   FROM employees
                   WHERE UPPER(last_name) = 'GATES');
                   
--16
SELECT last_name, salary
FROM employees e
WHERE employee_id NOT IN (SELECT employee_id
                          FROM employees
                          WHERE INITCAP(last_name) = 'Gates'
                            AND e.department_id = department_id)
ORDER BY 1;

--daca cererea returneaza mai mult de o linie, atunci nu putem folosi =, altfel putem folosi ambele variante

--17 
SELECT a.last_name, a.salary
FROM employees a
WHERE a.manager_id = (SELECT m.employee_id
                      FROM employees m
                      WHERE m.manager_id IS NULL);
                      
--18 
SELECT a.last_name, a.department_id, a.salary
FROM employees a
WHERE a.salary IN (SELECT b.salary
                  FROM employees b
                  WHERE b.employee_id <> a.employee_id
                    AND b.department_id = a.department_id
                    AND b.commission_pct IS NOT NULL);
    
--20 
SELECT *
FROM employees e
WHERE salary > ALL(SELECT salary
                FROM employees c
                WHERE UPPER(c.job_id) LIKE ('%CLERK%'))
ORDER BY salary;
--ALL, se selecteaza doar angajatii care au salariul > decat cel mai mare salariu
--ANY, > cel mai mic

--21
SELECT e.department_id, department_name, salary
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND commission_pct IS NULL
    AND e.manager_id IN (SELECT manager_id
                      FROM employees
                      WHERE manager_id = e.manager_id
                        AND commission_pct IS NOT NULL);
                        
--22 
SELECT e.last_name, e.department_id, e.salary, e.job_id
FROM employees e
WHERE salary IN (SELECT o.salary
                 FROM employees o, departments d, locations l
                 WHERE o.commission_pct = e.commission_pct
                    AND o.department_id = d.department_id
                    AND d.location_id = l.location_id
                    AND UPPER(l.city) = 'OXFORD');

--23 
SELECT e.last_name, e.department_id, e.job_id
FROM employees e
WHERE e.department_id = (SELECT d.department_id
                         FROM departments d, locations l
                         WHERE d.location_id = l.location_id
                            AND UPPER(l.city) = 'TORONTO');






