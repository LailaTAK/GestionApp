camper: /project$ psql --username=freecodecamp --dbname=postgres
Border style is 2.
Pager usage is off.
psql (12.17 (Ubuntu 12.17-1.pgdg22.04+1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.

postgres=> CREATE DATABASE universe;
CREATE DATABASE
postgres=> \c universe
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
You are now connected to database "universe" as user "freecodecamp".
universe=> -- Galaxy table
universe=> CREATE TABLE galaxy (
universe(>   galaxy_id SERIAL PRIMARY KEY,
universe(>   name VARCHAR NOT NULL UNIQUE,
universe(>   age_in_billion_years NUMERIC(5,2) NOT NULL,
universe(>   has_life BOOLEAN NOT NULL,
universe(>   galaxy_type TEXT,
universe(>   distance_from_earth INT
universe(> );
BLE star (
  star_id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL UNIQUE,
  galaxy_id INT NOT NULL RECREATE TABLE
universe=> 
universe=> -- Star table
universe=> CREATE TABLE star (
universe(>   star_id SERIAL PRIMARY KEY,
universe(>   name VARCHAR NOT NULL UNIQUE,
universe(>   galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
universe(>   mass INT NOT NULL,
universe(>   is_visible BOOLEAN NOT NULL,
universe(>   is_spherical BOOLEAN NOT NULL
universe(> );
CREATE TABLE
universe=> 
universe=> -- Planet table
universe=> CREATE TABLE planet (
universe(>   planet_id SERIAL PRIMARY KEY,
universe(>   name VARCHAR NOT NULL UNIQUE,
universe(>   star_id INT NOT NULL REFERENCES star(star_id),
universe(>   radius INT NOT NULL,
universe(>   has_rings BOOLEAN NOT NULL,
universe(>   is_spherical BOOLEAN NOT NULL
universe(> );
CREATE TABLE
universe=> 
universe=> -- Moon table
universe=> CREATE TABLE moon (
universe(>   moon_id SERIAL PRIMARY KEY,
universe(>   name VARCHAR NOT NULL UNIQUE,
universe(>   planet_id INT NOT NULL REFERENCES planet(planet_id),
universe(>   diameter INT NOT NULL,
universe(>   has_ice BOOLEAN NOT NULL,
universe(>   is_spherical BOOLEAN NOT NULL
universe(> );
CREATE TABLE
universe=> 
universe=> -- Galaxies
universe=> INSERT INTO galaxy (name, age_in_billion_years, has_life, galaxy_type, distance_from_earth)
universe-> VALUES 
universe->   ('Milky Way', 13.51, true, 'Spiral', 0),
universe->   ('Andromeda', 10.00, false, 'Spiral', 2537000),
universe->   ('Triangulum', 9.00, false, 'Spiral', 3000000),
universe->   ('Whirlpool', 8.50, false, 'Spiral', 23000000),
universe->   ('Sombrero', 11.00, false, 'Elliptical', 29000000),
universe->   ('Black Eye', 10.20, false, 'Spiral', 17000000);
INSERT 0 6
universe=> 
universe=> -- Stars (use galaxy_id from above, assume Milky Way has ID = 1)
universe=> INSERT INTO star (name, galaxy_id, mass, is_visible, is_spherical)
universe-> VALUES 
universe->   ('Sun', 1, 1989000, true, true),
universe->   ('Sirius', 1, 2100000, true, true),
universe->   ('Betelgeuse', 2, 20000000, true, true),
universe->   ('Vega', 1, 2400000, true, true),
universe->   ('Proxima Centauri', 1, 120000, false, true),
universe->   ('Alpha Centauri', 1, 1230000, true, true);
INSERT 0 6
universe=> 
universe=> -- Planets (assume Sun has star_id = 1)
universe=> INSERT INTO planet (name, star_id, radius, has_rings, is_spherical)
universe-> VALUES 
universe->   ('Earth', 1, 6371, false, true),
universe->   ('Mars', 1, 3390, false, true),
universe->   ('Jupiter', 1, 69911, true, true),
universe->   ('Venus', 1, 6052, false, true),
universe->   ('Neptune', 1, 24622, true, true),
universe->   ('Uranus', 1, 25362, true, true),
universe->   ('Kepler-22b', 2, 15000, false, true),
universe->   ('Gliese 581g', 2, 12000, false, true),
universe->   ('HD 209458 b', 3, 13500, true, true),
universe->   ('Tau Ceti e', 4, 11000, false, true),
universe->   ('TRAPPIST-1e', 5, 5800, false, true),
universe->   ('TRAPPIST-1f', 5, 5900, false, true);
INSERT 0 12
universe=> 
universe=> -- Moons (assume Earth has planet_id = 1, Mars = 2, etc.)
universe=> INSERT INTO moon (name, planet_id, diameter, has_ice, is_spherical)
universe-> VALUES 
universe->   ('Moon', 1, 3474, false, true),
universe->   ('Phobos', 2, 22, false, false),
universe->   ('Deimos', 2, 12, false, false),
universe->   ('Io', 3, 3643, false, true),
universe->   ('Europa', 3, 3122, true, true),
universe->   ('Ganymede', 3, 5268, true, true),
universe->   ('Callisto', 3, 4821, true, true),
universe->   ('Titan', 5, 5150, true, true),
universe->   ('Oberon', 6, 1522, true, true),
universe->   ('Triton', 5, 2706, true, true),
universe->   ('Charon', 2, 1212, true, true),
universe->   ('Nix', 2, 49, true, false),
universe->   ('Hydra', 2, 43, true, false),
universe->   ('Pan', 3, 28, false, false),
universe->   ('Dione', 3, 1123, true, true),
universe->   ('Rhea', 3, 1528, true, true),
universe->   ('Enceladus', 3, 504, true, true),
universe->   ('Mimas', 3, 396, true, true),
universe->   ('Miranda', 6, 471, true, true),
universe->   ('Ariel', 6, 1157, true, true);
INSERT 0 20
universe=> \q
camper: /project$ pg_dump -cC --inserts -U freecodecamp universe > universe.sql
camper: /project$ pwd
/workspace/project
camper: /project$ psql --username=freecodecamp --dbname=postgres
Border style is 2.
Pager usage is off.
psql (12.17 (Ubuntu 12.17-1.pgdg22.04+1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.

postgres=> \c universe;
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
You are now connected to database "universe" as user "freecodecamp".
universe=> CREATE TABLE black_hole (
universe(>     black_hole_id SERIAL PRIMARY KEY,
universe(>     name VARCHAR NOT NULL UNIQUE,
universe(>     galaxy_id INT REFERENCES galaxy(galaxy_id),
universe(>     mass INT NOT NULL,
universe(>     is_supermassive BOOLEAN NOT NULL,
universe(>     is_spherical BOOLEAN NOT NULL,
universe(>     description TEXT
universe(> );
CREATE TABLE
universe=> INSERT INTO black_hole (name, galaxy_id, mass, is_supermassive, is_spherical, description)
universe-> VALUES 
universe-> ('Sagittarius A*', 1, 4300000, TRUE, TRUE, 'The supermassive black hole at the center of the Milky Way galaxy.');
INSERT 0 1
universe=> 
universe=> INSERT INTO black_hole (name, galaxy_id, mass, is_supermassive, is_spherical, description)
universe-> VALUES 
universe-> ('M87*', 2, 6500000000, TRUE, TRUE, 'A supermassive black hole located at the center of the Virgo A galaxy, first imaged in 2019.');
ERROR:  integer out of range
universe=> 
universe=> INSERT INTO black_hole (name, galaxy_id, mass, is_supermassive, is_spherical, description)
universe-> VALUES 
universe-> ('Cygnus X-1', 3, 15000000, FALSE, FALSE, 'One of the strongest X-ray sources seen from Earth and one of the first suspected black holes.');
INSERT 0 1
universe=> INSERT INTO black_hole (name, galaxy_id, mass, is_supermassive, is_spherical, description)
universe-> VALUES 
universe-> ('M87*', 2, 6500000000, TRUE, TRUE, 'A supermassive black hole located at the center of the Virgo A galaxy, first imaged in 2019.');
ERROR:  integer out of range
universe=> INSERT INTO black_hole (name, galaxy_id, mass, is_supermassive, is_spherical, description)
universe-> VALUES 
universe->   ('Sagittarius A*', 1, 4300000, TRUE, TRUE, 'The supermassive black hole at the center of the Milky Way galaxy.'),
universe->   ('M87*', 2, 6500000000, TRUE, TRUE, 'A supermassive black hole located at the center of the Virgo A galaxy, first imaged in 2019.'),
universe->   ('Cygnus X-1', 3, 15000000, FALSE, FALSE, 'One of the strongest X-ray sources seen from Earth and one of the first suspected black holes.');
ERROR:  integer out of range
universe=> drop table balck_hole;
ERROR:  table "balck_hole" does not exist
universe=> CREATE TABLE black_hole (
universe(>     black_hole_id SERIAL PRIMARY KEY,
universe(>     name VARCHAR NOT NULL UNIQUE,
universe(>     galaxy_id INT REFERENCES galaxy(galaxy_id),
universe(>     mass BIGINT NOT NULL, -- changed from INT to BIGINT
universe(>     is_supermassive BOOLEAN NOT NULL,
universe(>     is_spherical BOOLEAN NOT NULL,
universe(>     description TEXT
universe(> );
ERROR:  relation "black_hole" already exists
universe=> DROP TABLE IF EXISTS black_hole;
DROP TABLE
universe=> CREATE TABLE black_hole (
universe(>     black_hole_id SERIAL PRIMARY KEY,
universe(>     name VARCHAR NOT NULL UNIQUE,
universe(>     galaxy_id INT REFERENCES galaxy(galaxy_id),
universe(>     mass BIGINT NOT NULL, -- changed from INT to BIGINT
universe(>     is_supermassive BOOLEAN NOT NULL,
universe(>     is_spherical BOOLEAN NOT NULL,
universe(>     description TEXT
universe(> );
CREATE TABLE
universe=> INSERT INTO black_hole (name, galaxy_id, mass, is_supermassive, is_spherical, description)
universe-> VALUES 
universe->   ('Sagittarius A*', 1, 4300000, TRUE, TRUE, 'The supermassive black hole at the center of the Milky Way galaxy.'),
universe->   ('M87*', 2, 6500000000, TRUE, TRUE, 'A supermassive black hole located at the center of the Virgo A galaxy, first imaged in 2019.'),
universe->   ('Cygnus X-1', 3, 15000000, FALSE, FALSE, 'One of the strongest X-ray sources seen from Earth and one of the first suspected black holes.');
INSERT 0 3
universe=> 