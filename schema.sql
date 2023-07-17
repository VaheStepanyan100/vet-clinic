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