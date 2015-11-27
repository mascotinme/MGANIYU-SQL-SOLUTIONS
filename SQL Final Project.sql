--- We will be paving a refreshing way for our new database by deleting,
--- creating and using the new created database as our default database.*/

DROP DATABASE IF EXISTS BuildingEnergy;
CREATE DATABASE BuildingEnergy; 
USE BuildingEnergy;


DROP TABLE IF EXISTS EnergyCategories;
DROP TABLE IF EXISTS EnergyTypes;
DROP TABLE IF EXISTS Buildings;
DROP TABLE IF EXISTS CATEGORY_ENERGYTYPE;

--- We can now CREATE our TABLES*/

CREATE TABLE EnergyCategories (
    id INT PRIMARY KEY NOT NULL,
    category VARCHAR(20) NOT NULL
);

CREATE TABLE EnergyTypes (
    id INT NOT NULL PRIMARY KEY,
    energytype VARCHAR(20) NOT NULL,
    category_id INT NOT NULL);

--- Populating Tables */
INSERT INTO EnergyCategories(id, category)
VALUES (1, "Fossil"),
(2,"Renewable");

INSERT INTO EnergyTypes(id, energytype, category_id)
VALUES (1, "gas", 1);
INSERT INTO EnergyTypes(id, energytype, category_id)
VALUES (2, "Electricity", 1);
INSERT INTO EnergyTypes(id, energytype, category_id)
VALUES (3, "Steam", 1);
INSERT INTO EnergyTypes(id, energytype, category_id)
VALUES (4, "Fuel Oil", 1);
INSERT INTO EnergyTypes(id, energytype, category_id)
VALUES (5, "Wind", 2);
INSERT INTO EnergyTypes(id, energytype, category_id)
VALUES (6, "Solar", 2);

--- Table joiner,(joining Energycategories with EnergyTypes.
CREATE TABLE Category_Energytype (
    id INT PRIMARY KEY NOT NULL,
    energytype_id INT,
    building_id INT
);

INSERT INTO Category_Energytype(id, energytype_id,building_id)
VALUES (1,1,1);
INSERT INTO Category_Energytype(id, energytype_id,building_id)
VALUES (2,1,2);
INSERT INTO Category_Energytype(id, energytype_id,building_id)
VALUES (3,1,3);
INSERT INTO Category_Energytype(id, energytype_id,building_id)
VALUES (4,2,1);
INSERT INTO Category_Energytype(id, energytype_id,building_id)
VALUES (5,3,1);
INSERT INTO Category_Energytype(id, energytype_id,building_id)
VALUES (6,3,3);
INSERT INTO Category_Energytype(id, energytype_id,building_id)
VALUES (7,3,5);
INSERT INTO Category_Energytype(id, energytype_id,building_id)
VALUES (8,5,3);


--- Question 3. Selecting using a JOIN Statements 

SELECT 
    energytypes.energytype, energycategories.category
FROM
    energycategories
        LEFT JOIN energytypes
        ON energytypes.category_id = energycategories.id;


--- QUESTION 4: Adding Another Table Called Buildings

CREATE TABLE BuildingS (
    id INT NOT NULL REFERENCES EnergyCategories(id),
    category_id INT NOT NULL,
    name VARCHAR(255),
    PRIMARY KEY(category_id)
);

--- Populating The Building Table 

INSERT INTO Buildings(id, category_id, name)
VALUES (1, 1, "Empire State Building"),
(2, 2, "Empire State Building"),
(3, 3, "Empire State Building"),
(3, 4, "Chrysler Building"),
(2, 5, "Chrysler Building"),
(6, 6, "Borough of Manhattan Community College"),
(3, 7, "Borough of Manhattan Community College"),
(2, 8, "Borough of Manhattan Community College");

SELECT * FROM BUILDINGS;

--- QUESTION 5: Using a JOIN Statement to display Buildings and Associated Energy Types */

SELECT b.name, e.energytype
from EnergyTypes e
right join Buildings b on e.id=b.id
left join EnergyCategories ec on b.id=ec.id
order by b.name, e.energytype asc;

--- QUESTION 6: Adding by Inserting another columns into both EnergyTypes and Buildings Tables */

INSERT INTO EnergyTypes(id, energytype, category_id)
VALUES (7, "Geothermal", 2);

INSERT INTO Buildings(id, category_id, name)
VALUES
(7, 12, "Bronx Lion House");
INSERT INTO Buildings(id, category_id, name)
VALUES
(2, 10, "Brooklyn Children Museum");

INSERT INTO Buildings(id, category_id, name)
VALUES
(7, 11, "Brooklyn Children Museum");

--- QUESTION 7: Displaying Building Using Renewable Energies-----

SELECT 
    a.name as 'BUILDING NAME', b.energytype, c.category
FROM
    energytypes b
        INNER JOIN
    energycategories  c ON b.category_id = c.id
        INNER JOIN
    category_energytype d ON d.energytype_id = b.id
        INNER JOIN
    buildings a ON a.id = d.building_id
WHERE
    c.category = 'Renewable';

---- QUESTION 8: Counting and Displaying Frequencies of Building energy types------

SELECT EnergyTypes.energytype, COUNT(buildings.id)
FROM
EnergyTypes
INNER JOIN
Buildings ON
EnergyTypes.id=Buildings.id
Group By EnergyTypes.energytype
ORDER BY COUNT(buildings.id) DESC;

--- THANK YOU ----