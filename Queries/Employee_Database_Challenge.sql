-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
	   emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);


CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR(40),
	from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);
	

select * from employees;

SELECT e.emp_no,
e.first_name,
e.last_name,
ti.title,
ti.from_date,
ti.to_date
into unique_titles
From employees AS e
LEFT JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND ti.to_date = ('9999-01-01')
ORDER BY emp_no; 

------------------------------------------------------------------------
--I'M HAPPY TO DO THIS BUT WHY? IF I CAN SORT TO SHOW CURRENT EMPLOYEES BY 'TI.TO_DATE'
--I DON'T GET DUPLICATE DATA.  EACH EMPLOYEE ONLY HAS ONE JOB, RIGHT?

-- Use Dictinct with Orderby to remove duplicate rows
-- SELECT DISTINCT ON (______) _____,
-- ______,
-- ______,
-- ______

-- INTO nameyourtable
-- FROM _______
-- WHERE _______
-- ORDER BY _____, _____ DESC;

SELECT COUNT(u.emp_no) AS C, u.title
INTO retiring_titles
FROM unique_titles AS u
GROUP BY u.title
ORDER BY C DESC;

--Eligible for Mentorship Program
SELECT e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ti.title
--INTO mentor_candidates
FROM employees as e
LEFT JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
RIGHT JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND ti.to_date = ('9999-01-01');

--AGAIN, I'M HAPPY TO DO THIS BUT WHY? IF I CAN SORT TO SHOW CURRENT EMPLOYEES BY 'TI.TO_DATE'
--I DON'T GET DUPLICATE DATA.