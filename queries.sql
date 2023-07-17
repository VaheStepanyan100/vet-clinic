/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT *
FROM animals
WHERE name
LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name
FROM animals
WHERE date_of_birth
BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name
FROM animals
WHERE (neutered = true AND escape_attempts < 3);

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth
FROM animals
WHERE (name = 'Agumon' OR name = 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts
FROM animals
WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT *
FROM animals
WHERE neutered = true;

-- Find all animals not named Gabumon.
SELECT *
FROM animals
WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT *
FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;

-- Inside a transaction:
  -- update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
  BEGIN;
  UPDATE animals
  SET species = 'digimon'
  WHERE name LIKE '%mon';

  -- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
  UPDATE animals
  SET species = 'pokemon'
  WHERE species IS NULL;

  -- Commit the transaction.
  COMMIT;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
ROLLBACK;

-- Inside a transaction:
BEGIN;
  -- Delete all animals born after Jan 1st, 2022.
  DELETE FROM animals
  WHERE date_of_birth > '2022-01-01';

  -- Create a savepoint for the transaction.
  SAVEPOINT SP1;

  -- Update all animals' weight to be their weight multiplied by -1.
  UPDATE animals
  SET weight_kg = weight_kg * -1;

  -- Rollback to the savepoint
  ROLLBACK TO SP1;

  -- Update all animals' weights that are negative to be their weight multiplied by -1.
  UPDATE animals
  SET weight_kg = weight_kg * -1
  WHERE weight_kg < 0;

  -- Commit transaction
  COMMIT;

-- How many animals are there?
SELECT COUNT(*) as animals 
FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(name) as animals_never_escaped
FROM animals
WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) as average_weight
FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) as max_escape_attempts
FROM animals
GROUP BY neutered;
  
-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) as min_weight_kg, MAX(weight_kg) as max_weight_kg
FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) as avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;
  

-- What animals belong to Melody Pond?
SELECT name as "Melody Pond's animals"
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name as "Animals that are pokemon"
FROM animals
JOIN species ON species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name as owner, animals.name as animal
FROM owners
LEFT JOIN animals ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.name, COUNT(*)
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT * 
FROM animals
JOIN owners ON owner_id = owners.id
JOIN species ON species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT * 
FROM animals
JOIN owners ON owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT full_name, COUNT(animals.name) as total
FROM owners
JOIN animals ON animals.owner_id = owners.id
GROUP BY full_name
ORDER BY total DESC LIMIT 1;