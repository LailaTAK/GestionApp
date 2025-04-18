psql --username=freecodecamp --dbname=postgres
CREATE DATABASE universe;
\c universe
-- Galaxy table
CREATE TABLE galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
  age_in_billion_years NUMERIC(5,2) NOT NULL,
  has_life BOOLEAN NOT NULL,
  galaxy_type TEXT,
  distance_from_earth INT
);

-- Star table
CREATE TABLE star (
  star_id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
  galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
  mass INT NOT NULL,
  is_visible BOOLEAN NOT NULL,
  is_spherical BOOLEAN NOT NULL
);

-- Planet table
CREATE TABLE planet (
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
  star_id INT NOT NULL REFERENCES star(star_id),
  radius INT NOT NULL,
  has_rings BOOLEAN NOT NULL,
  is_spherical BOOLEAN NOT NULL
);

-- Moon table
CREATE TABLE moon (
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
  planet_id INT NOT NULL REFERENCES planet(planet_id),
  diameter INT NOT NULL,
  has_ice BOOLEAN NOT NULL,
  is_spherical BOOLEAN NOT NULL
);
-- Galaxies
INSERT INTO galaxy (name, age_in_billion_years, has_life, galaxy_type, distance_from_earth)
VALUES 
  ('Milky Way', 13.51, true, 'Spiral', 0),
  ('Andromeda', 10.00, false, 'Spiral', 2537000),
  ('Triangulum', 9.00, false, 'Spiral', 3000000),
  ('Whirlpool', 8.50, false, 'Spiral', 23000000),
  ('Sombrero', 11.00, false, 'Elliptical', 29000000),
  ('Black Eye', 10.20, false, 'Spiral', 17000000);

-- Stars (use galaxy_id from above, assume Milky Way has ID = 1)
INSERT INTO star (name, galaxy_id, mass, is_visible, is_spherical)
VALUES 
  ('Sun', 1, 1989000, true, true),
  ('Sirius', 1, 2100000, true, true),
  ('Betelgeuse', 2, 20000000, true, true),
  ('Vega', 1, 2400000, true, true),
  ('Proxima Centauri', 1, 120000, false, true),
  ('Alpha Centauri', 1, 1230000, true, true);

-- Planets (assume Sun has star_id = 1)
INSERT INTO planet (name, star_id, radius, has_rings, is_spherical)
VALUES 
  ('Earth', 1, 6371, false, true),
  ('Mars', 1, 3390, false, true),
  ('Jupiter', 1, 69911, true, true),
  ('Venus', 1, 6052, false, true),
  ('Neptune', 1, 24622, true, true),
  ('Uranus', 1, 25362, true, true),
  ('Kepler-22b', 2, 15000, false, true),
  ('Gliese 581g', 2, 12000, false, true),
  ('HD 209458 b', 3, 13500, true, true),
  ('Tau Ceti e', 4, 11000, false, true),
  ('TRAPPIST-1e', 5, 5800, false, true),
  ('TRAPPIST-1f', 5, 5900, false, true);

-- Moons (assume Earth has planet_id = 1, Mars = 2, etc.)
INSERT INTO moon (name, planet_id, diameter, has_ice, is_spherical)
VALUES 
  ('Moon', 1, 3474, false, true),
  ('Phobos', 2, 22, false, false),
  ('Deimos', 2, 12, false, false),
  ('Io', 3, 3643, false, true),
  ('Europa', 3, 3122, true, true),
  ('Ganymede', 3, 5268, true, true),
  ('Callisto', 3, 4821, true, true),
  ('Titan', 5, 5150, true, true),
  ('Oberon', 6, 1522, true, true),
  ('Triton', 5, 2706, true, true),
  ('Charon', 2, 1212, true, true),
  ('Nix', 2, 49, true, false),
  ('Hydra', 2, 43, true, false),
  ('Pan', 3, 28, false, false),
  ('Dione', 3, 1123, true, true),
  ('Rhea', 3, 1528, true, true),
  ('Enceladus', 3, 504, true, true),
  ('Mimas', 3, 396, true, true),
  ('Miranda', 6, 471, true, true),
  ('Ariel', 6, 1157, true, true);
