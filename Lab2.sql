--1
SELECT last_name || ' ' ||
    first_name || ' castiga ' ||
    salary || ' lunar dar doreste ' ||
    salary * 3 info
FROM employees;

SELECT CONCAT(last_name, CONCAT(' ', 
    CONCAT(first_name, CONCAT(' castiga ',
    CONCAT(salary, CONCAT(' lunar dar doreste ',
    salary * 3)))))) info
FROM employees;

--2
SELECT INITCAP(last_name),
    UPPER(first_name),
    LENGTH(first_name) lungime
FROM employees
WHERE first_name LIKE ('J%') --substr(first_name, 1,1) = 'J'
OR first_name LIKE('M%')     --substr(first_name, 1,1) = 'M'
OR first_name LIKE ('__A%')  --substr(first_name, 3,1) = 'J'
ORDER BY lungime DESC;

--3
SELECT employee_id, first_name, last_name, department_id
FROM employees
WHERE INITCAP(TRIM(BOTH FROM first_name)) = 'Steven';

--4
SELECT employee_id, last_name, LENGTH(last_name) "lungime nume", INSTR(UPPER(last_name), 'A') "pozitie a"
FROM employees
WHERE UPPER(last_name) LIKE ('%E');

--5
SELECT *
FROM employees
WHERE MOD(ROUND(SYSDATE - hire_date), 7) = 0;

--6
SELECT employee_id, first_name, last_name, 
    TRUNC(salary * 1.15, 2) "Salariul nou",
    ROUND(TRUNC(salary * 1.15, 2)/100, 2) "Nr. sute"
FROM employees
WHERE MOD(salary, 1000) <> 0;

--7
SELECT last_name "Nume angajat", RPAD(hire_date, 15, ' ') "Data angajarii"
FROM employees
WHERE commission_pct IS NOT NULL;

--8
SELECT TO_CHAR(SYSDATE + 30, 'Month Day YYYY, HH24:MI:SS') data
FROM DUAL;

--9
SELECT TO_DATE('01 01 2021', 'DD MM YYYY') - SYSDATE
FROM DUAL;

--10
SELECT SYSDATE + 0.5
FROM DUAL;

SELECT TO_CHAR(SYSDATE + 1/24/60*5, 'DD MM YYYY HH24:MI:SS')
FROM DUAL;

--11
SELECT last_name, hire_date, 
    NEXT_DAY(ADD_MONTHS(hire_date, 6), 'Monday') "Negociere"
FROM employees;

--12
SELECT last_name, 
    ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) "Luni lucrate"
FROM employees
ORDER BY "Luni lucrate";

--13
SELECT last_name, hire_date, TO_CHAR(hire_date, 'Day') "Zi"
FROM employees
ORDER BY hire_date - NEXT_DAY(hire_date - 7, 'Monday');

--14
SELECT last_name, NVL(to_char(commission_pct), 'Fara comision') "Comision"
FROM employees;

--15
SELECT last_name, salary, commission_pct
FROM employees
WHERE salary > 10000;

--16
SELECT last_name, job_id, salary, 
    CASE job_id
        WHEN 'IT_PROG' THEN salary*1.2
        WHEN 'SA_REP' THEN salary*1.25
        WHEN 'SA_MAN' THEN salary*1.35
        ELSE salary
    END "salariu renegociat"
FROM employees;

---17
SELECT last_name,d. department_id, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

--- Standard
SELECT last_name,d. department_id, department_name
FROM employees e INNER JOIN departments d ON 
e.department_id = d.department_id;


---18
SELECT DISTINCT d.department_id, j.job_id, job_title
FROM employees e JOIN departments d ON
e.department_id = d.department_id
JOIN jobs j ON
j.job_id = e.job_id
WHERE d. department_id = 30;

--19
SELECT e.last_name, d.department_name, l.city, c.country_name
FROM employees e 
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
WHERE e.commission_pct IS NOT NULL;

--20
SELECT e.last_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND UPPER(e.last_name) LIKE('%A%');
   
--21
SELECT e.last_name, j.job_title, d.department_id, d.department_name
FROM employees e
JOIN jobs j on e.job_id = j.job_id
JOIN departments d on e.department_id = d.department_id
JOIN locations l on d.location_id = l.location_id
WHERE UPPER(l.city) = 'OXFORD';

--22
SELECT angajat.employee_id "Ang#", angajat.last_name "Angajat",
    sef.employee_id "Mgr#", sef.last_name "Manager"
FROM employees angajat, employees sef
WHERE angajat.manager_id = sef.employee_id;

--23
SELECT angajat.employee_id "Ang#", angajat.last_name "Angajat",
    sef.employee_id "Mgr#", sef.last_name "Manager"
FROM employees angajat
LEFT OUTER JOIN employees sef ON angajat.manager_id = sef.employee_id;

---24
SELECT e1.employee_id, e1.last_name, e1.department_id, 
    e2.employee_id, e2.last_name
FROM employees e1, employees e2
WHERE e1.department_id = e2.department_id
AND e1.employee_id <> e2.employee_id;

---25
DESC jobs;

SELECT last_name, j.job_id, job_title,
    department_name, salary
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id (+)
AND j.job_id = e.job_id;

---26
SELECT *
FROM employees
WHERE UPPER(last_name) = 'GATES';

SELECT e1.last_name, e1.hire_date
FROM employees e1, employees e2
WHERE UPPER(e2.last_name) = 'GATES'
    AND e1.hire_date > e2.hire_date
ORDER BY e1.hire_date;

SELECT e1.last_name, e1.hire_date
FROM employees e1 
JOIN employees e2 ON e1.hire_date > e2.hire_date
WHERE UPPER(e2.last_name) = 'GATES'
ORDER BY e1.hire_date;

--27
SELECT angajat.last_name "Angajat", angajat.hire_date "Data_ang",
    sef.last_name "Manager", sef.hire_date "Data_mgr"
FROM employees angajat, employees sef
WHERE angajat.manager_id = sef.employee_id
    AND angajat.hire_date < sef.hire_date;
