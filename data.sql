/* Populate database with sample data. */

INSERT INTO animals
VALUES
  (1, 'Agumon', '2020-02-03', 0, true, 10.23),
  (2, 'Gabumon', '2018-11-15', 2, true, 8),
  (3, 'Pikachu', '2021-01-07', 1, false, 15.04),
  (4, 'Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals
VALUES
  (5, 'Charmander', '2020-02-08', 0, false, -11),
  (6, 'Plantmon', '2021-11-15', 2, true, -5.7),
  (7, 'Squirtle', '1993-04-02', 3, false, -12.13),
  (8, 'Angemon', '2005-06-12', 1, true, -45),
  (9, 'Boarmon', '2005-06-07', 7, true, 20.4),
  (10, 'Blossom', '1998-10-13', 3, true, 17),
  (11, 'Ditto', '2022-05-14', 4, true, 22);

  INSERT INTO owners(full_name, age)
  VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

  INSERT INTO species(name)
  VALUES
    ('Pokemon'),
    ('Digimon');

  -- Update the animals table to set the species_id based on the name
UPDATE animals
SET species_id = (CASE
    WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
    ELSE (SELECT id FROM species WHERE name = 'Pokemon')
    END);

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name = 'Gabumon' OR name = 'Pikachu';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');

INSERT INTO vets (name, age, date_of_graduation)
VALUES
  ('William Tatcher', 45, '2000-04-23'), 
  ('Maisy Smith', 26, '2019-01-17'), 
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '1981-06-08');

  INSERT INTO specializations (vet_id, species_id)
  SELECT v.id, s.id
  FROM vets v, species s
  WHERE v.name = 'William Tatcher'
    AND s.name = 'Pokemon';

  INSERT INTO specializations (vet_id, species_id)
  SELECT v.id, s.id
  FROM vets v, species s
  WHERE v.name = 'Stephanie Mendez'
    AND s.name = 'Digimon';

  INSERT INTO specializations (vet_id, species_id)
  SELECT v.id, s.id
  FROM vets v, species s
  WHERE v.name = 'Stephanie Mendez'
    AND s.name = 'Pokemon';


  INSERT INTO specializations (vet_id, species_id)
  SELECT v.id, s.id
  FROM vets v, species s
  WHERE v.name = 'Jack Harkness'
    AND s.name = 'Digimon';


  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2020-05-24'
  FROM vets v, animals a
  WHERE v.name = 'William Tatcher'
    AND a.name = 'Agumon';

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2020-07-22'
  FROM vets v, animals a
  WHERE v.name = 'Stephanie Mendez'
    AND a.name = 'Agumon';

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2021-02-02'
  FROM vets v, animals a
  WHERE v.name = 'Jack Harkness'
    AND a.name = 'Gabumon';

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2020-01-05'
  FROM vets v, animals a
  WHERE v.name = 'Maisy Smith'
    AND a.name = 'Pikachu';

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2020-03-08'
  FROM vets v, animals a
  WHERE v.name = 'Maisy Smith'
    AND a.name = 'Pikachu';

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2020-05-14'
  FROM vets v, animals a
  WHERE v.name = 'Maisy Smith'
    AND a.name = 'Pikachu';
  

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2021-05-04'
  FROM vets v, animals a
  WHERE v.name = 'Stephanie Mendez'
    AND a.name = 'Devimon';

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2021-02-24'
  FROM vets v, animals a
  WHERE v.name = 'Jack Harkness'
    AND a.name = 'Charmander';

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2019-12-21'
  FROM vets v, animals a
  WHERE v.name = 'Maisy Smith'
    AND a.name = 'Plantmon';

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2020-08-10'
  FROM vets v, animals a
  WHERE v.name = 'William Tatcher'
    AND a.name = 'Plantmon';

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2021-04-07'
  FROM vets v, animals a
  WHERE v.name = 'Maisy Smith'
    AND a.name = 'Plantmon';

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2019-04-29'
  FROM vets v, animals a
  WHERE v.name = 'Stephanie Mendez'
    AND a.name = 'Squirtle';

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2020-10-03'
  FROM vets v, animals a
  WHERE v.name = 'Jack Harkness'
    AND a.name = 'Angemon';

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2020-11-04'
  FROM vets v, animals a
  WHERE v.name = 'Jack Harkness'
    AND a.name = 'Angemon';

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2019-01-24'
  FROM vets v, animals a
  WHERE v.name = 'Maisy Smith'
    AND a.name = 'Boarmon';

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2019-05-15'
  FROM vets v, animals a
  WHERE v.name = 'Maisy Smith'
    AND a.name = 'Boarmon';

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2020-02-27'
  FROM vets v, animals a
  WHERE v.name = 'Maisy Smith'
    AND a.name = 'Boarmon';
  
  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2020-10-03'
  FROM vets v, animals a
  WHERE v.name = 'Maisy Smith'
    AND a.name = 'Boarmon';

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2020-05-24'
  FROM vets v, animals a
  WHERE v.name = 'Stephanie Mendez'
    AND a.name = 'Blossom';

  INSERT INTO visits (vet_id, animal_id, date_of_visits)
  SELECT v.id, a.id, '2021-01-11'
  FROM vets v, animals a
  WHERE v.name = 'William Tatcher'
    AND a.name = 'Blossom';

  
  CREATE INDEX idx_visits_animal_id ON visits (animal_id);
  CREATE INDEX idx_visits_vet_id ON visits (vet_id);
  CREATE INDEX idx_owners_email ON owners (email);