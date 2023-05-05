INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Agumon', '2-3-2020', 0, true, '10.23');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Gabumon', '15-11-2018', 2, true, '8');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Pikachu', ' 1-7-2021', 2, false, '15.04');
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Devimon', ' 5-12-2017', 5, true, '11')
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '8-02-2020', 0, false, -11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '15-11-2021', 2, true, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '02-04-1993', 3, false,-12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '12-06-2005', 1, true,-45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '07-06-2005', 7, true,20);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '13-10-1998', 3, true, 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '14-05-2022', 4, true, 22);


-- add data to owners table

INSERT INTO owners(full_name, age) VALUES('Sam Smith', 34);
INSERT INTO owners(full_name, age) VALUES('Jennifer Orwell', 19);
INSERT INTO owners(full_name, age) VALUES('Bob ', 45);
INSERT INTO owners(full_name, age) VALUES('Melody Pond', 77);
INSERT INTO owners(full_name, age) VALUES('Dean Winchester', 14);
INSERT INTO owners(full_name, age) VALUES('Jodie Whittaker', 38);

-- add data to species

INSERT INTO species(name) VALUES('Digimon');
INSERT INTO species(name) VALUES('Pokemon');


-- update species_id in animals

BEGIN TRANSACTION;
UPDATE animals
SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals
SET species_id = 1 WHERE species_id IS NULL;
COMMIT TRANSACTION;



-- update owners_id 

BEGIN TRANSACTION;
UPDATE animals SET owner_id = 1 WHERE name IN ('Agumon');
UPDATE animals SET owner_id=2 WHERE name IN ('Gabumon','Pikachu');
UPDATE animals SET owner_id=3 WHERE name IN ('Devimon','Plantmon');
UPDATE animals SET owner_id=4 WHERE name IN ('Charmander','Squirtle','Blossom');
UPDATE animals SET owner_id=5 WHERE name IN ('Angemon','Boarmon');
COMMIT TRANSACTION;




-- Insert into vets 
BEGIN TRANSACTION;

INSERT INTO vets(name, age, date_of_graduation) VALUES ('William Tatcher', 45, '23-04-2020');
INSERT INTO vets(name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '17-01-2019');
INSERT INTO vets(name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '04-05-1981');
INSERT INTO vets(name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '08-06-2008');

COMMIT TRANSACTION

-- Insert into specialization

BEGIN TRANSACTION;

INSERT INTO specializations(vet_id, species_id) VALUES(1,1), (3,1), (3,2), (4,2);

COMMIT TRANSACTION

-- add data to visits

BEGIN TRANSACTION;

INSERT INTO visits (animals_id, vets_id, date_of_visit) VALUES (1, 1, '24-05-2020'), (1, 3, '22-07-2020'),
(2, 4, '02-02-2021'), (3, 2, '05-01-2020'), (3, 2, '08-03-2020'), (3, 2, '14-05-2020'), (5, 3, '04-05-2021'),
(6, 4, '24-02-2021'), (4, 2, '21-12-2019'), (4, 1, '10-08-2020'), (4, 2, '07-04-2021'), (7, 3, '29-09-2019'), 
(9, 4, '03-10-2020'), (9, 4, '04-11-2020'), (10, 2, '24-01-2019'), (10, 2, '15-05-2019'), (10, 2, '27-02-2020'), 
(10, 2, '03-08-2020'), (10, 3, '24-05-2020'), (10, 1, '11-01-2021');

COMMIT TRANSACTION