SELECT * FROM animals WHERE name LIKE '%mon'
SELECT name FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019
SELECT name FROM animals WHERE neutered IS true and escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu')
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered IS true;
SELECT * FROM animals WHERE name  <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg  BETWEEN 10.4 and 17.3;

UPDATE animals SET species = 'UNSPECIFIED'
UPDATE animals SET species = ''

UPDATE animals SET species = 'digimon ' WHERE name LIKE '%mon'
UPDATE animals SET species = 'pokemon' WHERE species IS null

BEGIN TRANSACTION;

DELETE FROM animals;
-- Verify that all rows have been deleted
SELECT * FROM animals;

ROLLBACK;
SELECT * FROM animals;

-- delete all animals from 2022

DELETE from animals where date_of_birth > '01-01-2022'
Update animals set weight_kg = -1
select * from animals 
ROLLBACK TO SAVEPOINT DELETE2022
UPDATE animals set weight_kg = weight_kg * -1 where weight_kg < 0

-- Aggregation

select count(*) from animals
select count(*) from animals where escape_attempts = 0
select avg(weight_kg) from animals 
SELECT max(escape_attempts) as number_of_escapes, neutered  FROM animals  GROUP BY neutered

SELECT species, max(weight_kg), min(weight_kg)  FROM animals  GROUP BY species
SELECT species, avg(escape_attempts) from animals WHERE  EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000 GROUP BY species
