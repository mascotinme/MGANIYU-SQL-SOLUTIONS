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

CREATE TABLE GROUPSROOM(IT VARCHAR(255),
SALES VARCHAR(255),
ID INT,
NEW_EMPLOYEE VARCHAR(255));

CREATE TABLE GROUPS
(
IT VARCHAR(255),
SALES varchar(255),
ADMINISTRATION varchar(255) NULL,
OPERATION varchar(255) NULL);


CREATE TABLE ROOM(ID INT,
AUDITORIUM VARCHAR(105));


ALTER TABLE `projects`.`groups` 
ADD PRIMARY KEY (`IT`, `SALES`),
ADD UNIQUE INDEX `IT_UNIQUE` (`IT` ASC),
ADD UNIQUE INDEX `SALES_UNIQUE` (`SALES` ASC);


ALTER TABLE `projects`.`room` 
ADD PRIMARY KEY (`ID`),
ADD UNIQUE INDEX `ID_UNIQUE` (`ID` ASC);


ALTER TABLE `projects`.`groupsroom` 
ADD PRIMARY KEY (`IT`, `SALES`),
ADD UNIQUE INDEX `IT_UNIQUE` (`IT` ASC),
ADD UNIQUE INDEX `SALES_UNIQUE` (`SALES` ASC);


ALTER TABLE `projects`.`groupsroom` 
ADD INDEX `COMBB_idx` (`ID` ASC);
ALTER TABLE `projects`.`groupsroom` 
ADD CONSTRAINT `COMB`
  FOREIGN KEY (`IT`)
  REFERENCES `projects`.`groups` (`IT`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `COMBB`
  FOREIGN KEY (`ID`)
  REFERENCES `projects`.`room` (`ID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


INSERT INTO GROUPS(IT, SALES, ADMINISTRATION, OPERATION)
VALUES ("Modesto", "Christopher", "Saulat", Null);
INSERT INTO GROUPS(IT, SALES, ADMINISTRATION, OPERATION)
VALUES ("Ayine", "Cheong Woo", NULL, NULL);

INSERT INTO ROOM(ID, AUDITORIUM)
VALUES (101, "AUDITORIUM A");
INSERT INTO ROOM(ID, AUDITORIUM)
VALUES (102, "AUDITORIUM B");


SELECT G.IT, G.SALES, G.ADMINISTRATION, G.OPERATION,
GR.ID 'NEW ID', GR.IT 'AS NEW IT' , GR.SALES, GR.NEW_EMPLOYEE, R.ID,
R.AUDITORIUM
FROM GROUPSROOM GR
RIGHT JOIN GROUPS G ON (GR.IT=G.IT)
LEFT JOIN ROOM R ON (GR.ID=R.ID)
WHERE GR.IT IS NOT NULL;


SELECT G.IT, G.SALES, G.ADMINISTRATION, G.OPERATION,
GR.IT 'AS NEW IT' 
FROM GROUPS G
RIGHT JOIN GROUPSROOM GR ON (GR.IT=G.IT)
WHERE G.IT IS NULL;

SELECT G.IT, G.SALES, G.ADMINISTRATION, G.OPERATION,
GR.ID 'NEW ID', GR.IT 'AS NEW IT' , GR.SALES, GR.NEW_EMPLOYEE, R.ID,
R.AUDITORIUM
FROM GROUPSROOM GR
RIGHT JOIN GROUPS G ON (GR.IT=G.IT)
LEFT JOIN ROOM R ON (GR.ID=R.ID)
GROUP BY GR.IT
ORDER BY G.SALES ASC;


