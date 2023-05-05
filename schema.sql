
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

