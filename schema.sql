
CREATE TABLE animals (
    id int GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg FLOAT 
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(100)

-- create owners and species tables

CREATE TABLE species (
	id BIGSERIAL PRIMARY KEY,
	name VARCHAR(100)
);

CREATE TABLE owners (
id BIGSERIAL PRIMARY KEY,
full_name varchar(100),
age INT
)

ALTER TABLE animals
DROP COLUMN species

ALTER TABLE animals
add COLUMN species_id INT

ALTER TABLE animals
ADD COLUMN owner_id INTEGER REFERENCES owners(id);

-- This is the fourth day. 


BEGIN TRANSACTION;

CREATE TABLE vets (
id BIGSERIAL PRIMARY KEY,
name varchar(100),
age INT,
date_of_graduation DATE
);

CREATE TABLE specializations (
vet_id INT REFERENCES vets(id),
species_id INT REFERENCES species(id),
PRIMARY KEY (vet_id,species_id)
);

CREATE TABLE visits (
  animals_id INTEGER REFERENCES animals(id),
  vets_id INTEGER REFERENCES vets(id),
  date_of_visit DATE,
  PRIMARY KEY (animals_id, vets_id, date_of_visit)
);
COMMIT TRANSACTION;