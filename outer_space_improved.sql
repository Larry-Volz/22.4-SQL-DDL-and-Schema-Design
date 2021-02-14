-- from the terminal run:
-- psql < outer_space_improved.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE galaxy 
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE stars
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  size FLOAT,
  galaxy_id INTEGER REFERENCES galaxy
);

CREATE TABLE planets
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  orbital_period_in_years FLOAT NOT NULL,
  orbits_around INTEGER NOT NULL REFERENCES stars
  -- galaxy TEXT NOT NULL
  -- moons TEXT[]
);

CREATE TABLE moons
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  size FLOAT,
  orbits_around INTEGER NOT NULL REFERENCES planets,
  orbital_period_in_hours FLOAT
);

INSERT INTO galaxy
  (name) 
VALUES 
  ('Milky Way');


INSERT INTO stars
  (name, galaxy_id) 
VALUES 
  ('Sol: The Sun', 1), 
  ('Proxima Centauri', 1), 
  ( 'Gliese 876', 1);


INSERT INTO planets
  (name, orbital_period_in_years, orbits_around)
VALUES
  ('Earth', 1.00, 1),
  ('Mars', 1.88, 1),
  ('Venus', 0.62, 1),
  ('Neptune', 164.8, 1),
  ('Proxima Centauri b', 0.03, 2),
  ('Gliese 876 b', 0.23, 3);


INSERT INTO moons
  (name, orbits_around)
VALUES  
  ('luna: The Moon', 1),
  ('Phobos', 2),
  ('Deimos', 2),
  ('Naiad', 4),
  ('Thalassa', 4),
  ('Despina', 4),
  ('Galatea', 4),
  ('Larissa', 4),
  ('S/2004 N 1', 4),
  ('Proteus', 4),
  ('Triton', 4),
  ('Nereid', 4),
  ('Halimede', 4),
  ('Sao', 4),
  ('Laomedeia', 4),
  ('Psamathe', 4),
  ('Neso', 4);

