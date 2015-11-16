/* We have to drop any existing table or database if already exist
, otherwise the table may not be created */

DROP DATABASE IF EXISTS PROJECTS;
CREATE DATABASE PROJECTS; 
USE PROJECTS;

/* There are six users, and four groups. Modesto and Ayine are in group “I.T.” Christopher and Cheong woo are in group
“Sales”. There are four rooms: “101”, “102”, “Auditorium A”, and “Auditorium B”. Saulat is in group
“Administration.” Group “Operations” currently doesn’t have any users assigned. I.T. should be able to access Rooms
101 and 102. Sales should be able to access Rooms 102 and Auditorium A. Administration does not have access to any
rooms. Heidy is a new employee, who has not yet been assigned to any group.
After you determine the tables any relationships between the tables (One to many? Many to one? Many to many?), you
should create the tables and populate them with the information indicated above.
Next, write SELECT statements that provide the following information:
• All groups, and the users in each group. A group should appear even if there are no users assigned to the group.
• All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been
assigned to them.
• A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted
alphabetically by user, then by group, then by room.


SOLUTIONS */


CREATE TABLE GROUPS
(
  IT VARCHAR(255) PRIMARY KEY,
  SALES varchar(100) NOT NULL UNIQUE,
  ADMINISTRATION VARCHAR(255),
  OPERATION VARCHAR(255)
);


INSERT INTO GROUPS(IT, SALES, ADMINISTRATION, OPERATION)
VALUES ("Modesto", "Christopher", "Saulat", Null);
INSERT INTO GROUPS(IT, SALES, ADMINISTRATION, OPERATION)
VALUES ("Ayine", "Cheong Woo", NULL, NULL);

SELECT * FROM GROUPS;

CREATE TABLE ROOM
(
  ID int PRIMARY KEY,
  AUDITORIUM varchar(30) NOT NULL
);

INSERT INTO ROOM(ID, AUDITORIUM)
VALUES (101, "AUDITORIUM A");
INSERT INTO ROOM(ID, AUDITORIUM)
VALUES (102, "AUDITORIUM B");

SELECT * FROM ROOM;

CREATE TABLE GROUPSROOM
(
  IT VARCHAR(255) NOT NULL REFERENCES GROUPS(IT),
  SALES VARCHAR(255) NULL,
  ID INT NOT NULL REFERENCES ROOM(ID),
  NEW_EMPLOYEE VARCHAR(255),
  CONSTRAINT pk_title_authors PRIMARY KEY(IT, ID)
 );
 

INSERT INTO GROUPSROOM(IT, SALES, ID, NEW_EMPLOYEE)
VALUES ("MODESTO", "CHEONG WOO", 101, "HEIDI");
INSERT INTO GROUPSROOM(IT, SALES, ID, NEW_EMPLOYEE)
VALUES ("AYINE", NULL, 102, NULL);

SELECT * FROM GROUPSROOM;


SELECT G.IT, G.SALES, G.ADMINISTRATION, G.OPERATION,
GR.ID 'NEW ID', GR.IT 'AS NEW IT' , GR.SALES, GR.NEW_EMPLOYEE
FROM GROUPSROOM GR
RIGHT JOIN GROUPS G ON (GR.IT=G.IT)
WHERE GR.IT IS NOT NULL
GROUP BY G.SALES
ORDER BY GR.ID;


SELECT G.IT, G.SALES, G.ADMINISTRATION, G.OPERATION,
GR.IT 'AS NEW IT' 
FROM GROUPS G
RIGHT JOIN GROUPSROOM GR ON (GR.IT=G.IT)
WHERE G.IT IS NULL;

SELECT G.IT, G.SALES, G.ADMINISTRATION, G.OPERATION,
GR.ID 'NEW ID', GR.IT 'NEW IT' , GR.SALES, GR.NEW_EMPLOYEE, R.ID,
R.AUDITORIUM
FROM GROUPSROOM GR
INNER JOIN GROUPS G ON (GR.IT=G.IT)
LEFT JOIN ROOM R ON (GR.ID=R.ID)
GROUP BY G.IT
ORDER BY R.ID ASC;


