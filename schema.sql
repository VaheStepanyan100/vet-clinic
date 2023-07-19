/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL(10, 2) NOT NULL
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(255);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(255),
    age INT
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255)
);

ALTER TABLE animals
ALTER COLUMN id
ADD GENERATED ALWAYS AS IDENTITY;

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT
REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT
REFERENCES owners(id);


CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    vet_id INT REFERENCES vets (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    species_id INT REFERENCES species (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (vet_id, species_id)
);

CREATE TABLE visits (
    vet_id INT REFERENCES vets (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    animal_id INT REFERENCES animals (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    date_of_visits DATE
);