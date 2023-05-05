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


-- join tables day 3

-- What animals belong to Melody Pond?
select  name, owner_id, full_name from animals inner join owners OO ON owner_id = OO.id WHERE full_name = 'Melody Pond'

-- List of all animals that are pokemon (their type is Pokemon).

select  AA.name, ss.name from animals AA join species ss ON AA.species_id = ss.id WHERE ss.name = 'Pokemon'

-- List all owners and their animals, remember to include those that don't own any animal.
select  AA.name, oo.full_name from animals AA  full outer join owners oo ON AA.owner_id = oo.id 
ORDER BY full_name ASC


-- How many animals are there per species?
select  ss.name, count(AA.name)  from animals AA  join species ss ON AA.species_id = ss.id GROUP BY ss.name

-- List all Digimon owned by Jennifer Orwell.

SELECT 
    O.full_name AS owner,
    A.name AS animal,
    S.name AS species 
FROM 
    owners O 
JOIN animals A 
ON O.id=A.owner_id 
JOIN species S 
ON A.species_id=S.id 
WHERE S.name='Digimon' AND  O.full_name='Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape. 

select  AA.name  
from animals AA  
join owners oo ON AA.owner_id = oo.id
WHERE oo.full_name = 'Dean Winchester' and AA.escape_attempts =0

-- Who owns the most animals?

select  oo.full_name, (COUNT(AA.owner_id)) as count
from animals AA  
join owners oo ON AA.owner_id = oo.id
GROUP BY oo.full_name 
ORDER BY count DESC
LIMIT 1