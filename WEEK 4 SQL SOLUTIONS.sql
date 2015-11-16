/*SQL Assignment – Self-Joins Page 1
SQL Assignment – Self-Joins
In the assignment submission link, please provide a link to a GitHub repository that contains your .SQL file. Please work
by yourself on this assignment. I should be able to run your provided SQL code twice in succession without errors in my
environment, so please test accordingly!
Please create an organization chart for a real or imagined organization, implemented in a single SQL table. Your
deliverable script should:
1. Create the table. Each row should minimally include the person’s name, the person’s supervisor, and the
person’s job title. Using ID columns is encouraged.
2. Populate the table with a few sample rows.
3. Provide a single SELECT statement that displays the information in the table, showing who reports to whom.
You might have an organization with a depth of three levels. For example: there could be a CEO, two vice presidents
that report to the CEO, and two managers that report to each of the two vice presidents. An assistant might also report
directly to the CEO. Your table should be designed so that the reporting hierarchy could go to any practical depth. You
may use the example below if you are not able to come up with your own hierarchical data example.
A sample organization chart – yours can be much smaller!

*/

DROP DATABASE IF EXISTS ORGANIZATION;
CREATE DATABASE ORGANIZATION; 
USE ORGANIZATION;

CREATE TABLE SELFJOIN
(EMPLOYEE_ID INT NULL, LAST_NAME VARCHAR(255) NOT NULL, FIRST_NAME
VARCHAR(255) NOT NULL, MANAGER_ID INT NULL, JOB_TITLE VARCHAR(255) NULL,
DEPARTMENT VARCHAR(255) NULL);


INSERT INTO SELFJOIN(EMPLOYEE_ID, LAST_NAME, FIRST_NAME,
MANAGER_ID, JOB_TITLE, DEPARTMENT)
VALUES (1, "STEVE", "JOBS", NULL, "CEO", NULL);

INSERT INTO SELFJOIN(EMPLOYEE_ID, LAST_NAME, FIRST_NAME,
MANAGER_ID, JOB_TITLE, DEPARTMENT)
VALUES (2, "GANIYU", "MUSA", 1, "DEPUTY CEO", NULL);

INSERT INTO SELFJOIN(EMPLOYEE_ID, LAST_NAME, FIRST_NAME,
MANAGER_ID, JOB_TITLE, DEPARTMENT)
VALUES (3, "DAVID", "LOVELY", 2, "HEAD OF OPERATION", 1);

INSERT INTO SELFJOIN(EMPLOYEE_ID, LAST_NAME, FIRST_NAME,
MANAGER_ID, JOB_TITLE, DEPARTMENT)
VALUES (4, "ANDREW", "GREEN", 3, "DEPUTY HEAD OF OPERATION", 2);

INSERT INTO SELFJOIN(EMPLOYEE_ID, LAST_NAME, FIRST_NAME,
MANAGER_ID, JOB_TITLE, DEPARTMENT)
VALUES (5, "BLAND", "NICS", 4, "MANAGER", 4);

INSERT INTO SELFJOIN(EMPLOYEE_ID, LAST_NAME, FIRST_NAME,
MANAGER_ID, JOB_TITLE, DEPARTMENT)
VALUES (6, "MILO", "SWEET", 5, "ASSISTANT MANAGER", 4);

INSERT INTO SELFJOIN(EMPLOYEE_ID, LAST_NAME, FIRST_NAME,
MANAGER_ID, JOB_TITLE, DEPARTMENT)
VALUES (7, "BRUCE", "ROSE", 1, "SPY", 4);

INSERT INTO SELFJOIN(EMPLOYEE_ID, LAST_NAME, FIRST_NAME,
MANAGER_ID, JOB_TITLE, DEPARTMENT)
VALUES (8, "AYAD", "KINGS", 5, "SECRETARY", 5);

INSERT INTO SELFJOIN(EMPLOYEE_ID, LAST_NAME, FIRST_NAME,
MANAGER_ID, JOB_TITLE, DEPARTMENT)
VALUES (9, "CHUNG", "LIKELY", 5, "SECRETARY II", 5);

INSERT INTO SELFJOIN(EMPLOYEE_ID, LAST_NAME, FIRST_NAME,
MANAGER_ID, JOB_TITLE, DEPARTMENT)
VALUES (10, "JONATHAN", "JOBS", 5, "CUSTODIAN", 10);

INSERT INTO SELFJOIN(EMPLOYEE_ID, LAST_NAME, FIRST_NAME,
MANAGER_ID, JOB_TITLE, DEPARTMENT)
VALUES (11, "STEVE", "JANET", 5, "COMMUNITY ASSISTANT", 5);

INSERT INTO SELFJOIN(EMPLOYEE_ID, LAST_NAME, FIRST_NAME,
MANAGER_ID, JOB_TITLE, DEPARTMENT)
VALUES (12, "AKINOLA", "KATIE", 5, "STAFF RELATION", 5);

SELECT * FROM SELFJOIN;

/* THIS SHOWS WHICH BOSS THEY REPORTED TO. THE "MANAGER ID" REPORTS TO "EMPLOYEE ID" 
I.E THE ID ON MANAGER ID LINK TO THE EMPLOYEE ID (BOSS) YOU REPORT TO. E.G 
MUSA GANIYU REPORTS TO STEVE JOB E.T.C. */

SELECT S.EMPLOYEE_ID AS 'EMPLOYEE ID',
S.LAST_NAME AS 'LAST NAME', S.FIRST_NAME AS 'FIRST NAME',
S.MANAGER_ID AS 'MANAGER ID', S.JOB_TITLE AS 'JOB TITLE',
S.DEPARTMENT AS 'DEPARTMENT'
FROM SELFJOIN S
INNER JOIN SELFJOIN AS MYJOINS
ON S.EMPLOYEE_ID = MYJOINS.MANAGER_ID
GROUP BY S.EMPLOYEE_ID, MYJOINS.MANAGER_ID
ORDER BY S.EMPLOYEE_ID, S.MANAGER_ID ASC;


