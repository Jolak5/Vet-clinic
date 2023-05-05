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


-- join tables Day 3


-- What animals belong to Melody Pond?
select  name, owner_id, full_name from animals inner join owners OO ON owner_id = OO.id WHERE full_name = 'Melody Pond'


-- What animals belong to Melody Pond?
select  AA.name, ss.name from animals AA join species ss ON AA.species_id = ss.id WHERE ss.name = 'Pokemon'


-- List all owners and their animals, remember to include those that don't own any animal.
select  AA.name, oo.full_name from animals AA  full outer join owners oo ON AA.owner_id = oo.id 
ORDER BY full_name ASC

-- How many animals are there per species?

select  ss.name, count(AA.name)  from animals AA  join species ss ON AA.species_id = ss.id GROUP BY ss.name

-- List all Digimon owned by Jennifer Orwell.

select  AA.name  
from animals AA  
join species ss ON AA.species_id = ss.id 
join owners oo ON AA.owner_id = oo.id
WHERE oo.full_name = 'Jennifer Orwell' and ss.name ='Digimon'

-- List all animals owned by Dean Winchester that haven't tried to escape. 

select  AA.name  
from animals AA  
join owners oo ON AA.owner_id = oo.id
WHERE oo.full_name = 'Dean Winchester' and AA.escape_attempts =0

-- Who owns the most animals?

SELECT 
    owners.full_name,
    COUNT(animals.name) AS total_animalss
FROM 
    owners 
JOIN animals
ON animals.owner_id=owners.id
GROUP BY owners.full_name 
ORDER BY total_animalss DESC 
LIMIT 1;

-- Day 4 of the Sql

select  oo.full_name, (COUNT(AA.owner_id)) as count
from animals AA  
join owners oo ON AA.owner_id = oo.id
GROUP BY oo.full_name 
ORDER BY count DESC
LIMIT 1

-- Who was the last animal seen by William Tatcher?
SELECT aa.name, vi.date_of_visit FROM animals aa 
join vets vv ON aa.id = vv.id
join visits vi ON aa.id =vi.animals_id
WHERE vv.name = 'William Tatcher' 
ORDER BY vi.date_of_visit DESC
LIMIT 1;


-- How many different animals did Stephanie Mendez see?

SELECT VET.name, COUNT(DISTINCT V.animals_id) AS animal_seen 
FROM animals A 
JOIN visits V 
ON A.id = V.animals_id 
JOIN vets VET 
ON VET.id = V.vets_id 
WHERE VET.name = 'Stephanie Mendez' 
GROUP BY VET.name;

-- List all vets and their specialties, including vets with no specialties.

SELECT V.name AS vet_name, SP.name AS specialities 
FROM vets V 
FULL JOIN specializations S 
ON V.id = S.vet_id 
FULL JOIN species SP 
ON S.species_id = SP.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020

SELECT A.name AS animals_name, VET.name AS vets_name, V.date_of_visit 
FROM animals A 
JOIN visits V 
ON A.id = V.animals_id 
JOIN vets VET 
ON V.vets_id = VET.id 
WHERE VET.name = 'Stephanie Mendez' 
AND V.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets

SELECT A.name AS animal_name, COUNT(A.name) AS visits 
FROM animals A 
JOIN visits V 
ON A.id=V.animals_id 
GROUP BY A.name 
ORDER BY COUNT(A.name) DESC LIMIT 1;


-- Who was Maisy Smith's first visit

SELECT V.name AS vet_name, A.name AS animal_name, VET.date_of_visit
FROM vets V 
JOIN visits VET 
ON V.id=VET.vets_id 
JOIN animals A 
ON VET.animals_id = A.id 
WHERE V.name='Maisy Smith' 
ORDER BY VET.date_of_visit ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT A.name AS animal_name, V.name AS vet_name, VET.date_of_visit
FROM vets V 
JOIN visits VET 
ON V.id = VET.vets_id 
JOIN animals A 
ON VET.animals_id = A.id  
ORDER BY VET.date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(*) FROM visits V 
JOIN animals A 
ON V.animals_id = A.id 
JOIN vets VET 
ON V.vets_id = VET.id 
FULL JOIN specializations S 
ON VET.id=S.vet_id 
WHERE A.species_id 
NOT IN ( SELECT species_id FROM specializations WHERE vet_id = V.vets_id );


-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT S.name AS species, COUNT(*) 
FROM visits V 
JOIN animals A 
ON V.animals_id = A.id 
JOIN vets VET 
ON V.vets_id = VET.id 
JOIN species S 
ON A.species_id = S.id 
WHERE VET.name='Maisy Smith' 
GROUP BY S.name 
ORDER BY COUNT(*) DESC LIMIT 1;