-- Clear the last database
DROP DATABASE IF EXISTS universe;

-- Create the new database
CREATE DATABASE universe;

-- Connect to it
\c universe

-- Table 1: galaxy
CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    distance_from_earth INT NOT NULL,
    size_in_light_years INT,
    is_spiral BOOLEAN NOT NULL,
    description TEXT
);

-- Table 2: star
CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    mass INT NOT NULL,
    temperature INT,
    is_supernova BOOLEAN NOT NULL,
    galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id)
);

-- Table 3: planet
CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    radius INT NOT NULL,
    orbital_period INT,
    has_rings BOOLEAN NOT NULL,
    star_id INT NOT NULL REFERENCES star(star_id)
);

-- Table 4: moon
CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    diameter INT NOT NULL,
    surface_gravity NUMERIC(5,2),
    is_habitable BOOLEAN NOT NULL,
    planet_id INT NOT NULL REFERENCES planet(planet_id)
);

-- Table 5: nebula
CREATE TABLE nebula (
    nebula_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    density INT NOT NULL,
    age_in_millions INT,
    is_visible BOOLEAN NOT NULL
);

-- Insert into galaxy (7 rows)
INSERT INTO galaxy (name, distance_from_earth, size_in_light_years, is_spiral, description) VALUES
('Milky Way', 0, 100000, TRUE, 'Our home galaxy'),
('Andromeda', 2500000, 220000, TRUE, 'Nearest spiral galaxy'),
('Triangulum', 3000000, 60000, TRUE, 'Small spiral galaxy'),
('Sombrero', 29000000, 50000, FALSE, 'Hat-shaped galaxy'),
('Whirlpool', 23000000, 60000, TRUE, 'Classic spiral'),
('Centaurus A', 13000000, 60000, FALSE, 'Elliptical with dust lane'),
('Pinwheel', 21000000, 70000, TRUE, 'Another spiral beauty');

-- Insert into star (7 rows)
INSERT INTO star (name, mass, temperature, is_supernova, galaxy_id) VALUES
('Sun', 1, 5778, FALSE, 1),
('Betelgeuse', 20, 3500, FALSE, 1),
('Sirius', 2, 9940, FALSE, 1),
('Proxima Centauri', 0, 3042, FALSE, 1),
('Vega', 2, 9602, FALSE, 2),
('Arcturus', 1, 4286, FALSE, 3),
('Rigel', 21, 12100, FALSE, 7);

-- Insert into planet (13 rows)
INSERT INTO planet (name, radius, orbital_period, has_rings, star_id) VALUES
('Earth', 6371, 365, FALSE, 1),
('Mars', 3390, 687, FALSE, 1),
('Jupiter', 69911, 4333, TRUE, 1),
('Saturn', 58232, 10759, TRUE, 1),
('Venus', 6052, 225, FALSE, 1),
('Mercury', 2439, 88, FALSE, 1),
('Alpha Prox b', 7000, 11, FALSE, 4),
('Beta Prox c', 8000, 20, FALSE, 4),
('Vega Prime', 12000, 300, TRUE, 5),
('Sirius B1', 5000, 50, FALSE, 3),
('Arcturus X', 9000, 400, FALSE, 6),
('Betelgeuse I', 15000, 1000, TRUE, 2),
('Rigel Z', 11000, 600, FALSE, 7);

-- Insert into moon (21 rows)
INSERT INTO moon (name, diameter, surface_gravity, is_habitable, planet_id) VALUES
('Luna', 3474, 1.62, FALSE, 1),
('Phobos', 22, 0.01, FALSE, 2),
('Deimos', 12, 0.00, FALSE, 2),
('Io', 3643, 1.80, FALSE, 3),
('Europa', 3122, 1.31, TRUE, 3),
('Ganymede', 5268, 1.43, FALSE, 3),
('Callisto', 4821, 1.24, FALSE, 3),
('Titan', 5150, 1.35, TRUE, 4),
('Rhea', 1528, 0.26, FALSE, 4),
('Iapetus', 1469, 0.22, FALSE, 4),
('Dione', 1123, 0.23, FALSE, 4),
('Tethys', 1062, 0.15, FALSE, 4),
('Enceladus', 504, 0.11, FALSE, 4),
('Mimas', 396, 0.06, FALSE, 4),
('Oberon', 1523, 0.35, FALSE, 4),
('Titania', 1578, 0.38, FALSE, 4),
('Prox Moon A', 200, 0.05, FALSE, 7),
('Prox Moon B', 300, 0.07, FALSE, 8),
('Vega Luna', 1000, 0.20, FALSE, 9),
('Sirius Satellite', 500, 0.10, FALSE, 10),
('Rigel Moon', 800, 0.15, FALSE, 13);

-- Insert into nebula (5 rows)
INSERT INTO nebula (name, density, age_in_millions, is_visible) VALUES
('Orion Nebula', 100, 2, TRUE),
('Crab Nebula', 50, 1, TRUE),
('Horsehead Nebula', 80, 3, FALSE),
('Eagle Nebula', 120, 4, TRUE),
('Carina Nebula', 90, 5, FALSE);

-- Verify all tables have required row counts
DO $$
BEGIN
    IF (SELECT COUNT(*) FROM galaxy) < 6 THEN
        RAISE EXCEPTION 'Galaxy has fewer than 6 rows';
    END IF;
    IF (SELECT COUNT(*) FROM star) < 6 THEN
        RAISE EXCEPTION 'Star has fewer than 6 rows';
    END IF;
    IF (SELECT COUNT(*) FROM planet) < 12 THEN
        RAISE EXCEPTION 'Planet has fewer than 12 rows';
    END IF;
    IF (SELECT COUNT(*) FROM moon) < 20 THEN
        RAISE EXCEPTION 'Moon has fewer than 20 rows';
    END IF;
    IF (SELECT COUNT(*) FROM nebula) < 3 THEN
        RAISE EXCEPTION 'Nebula has fewer than 3 rows';
    END IF;
    RAISE NOTICE 'All table row requirements met!';
END $$;

-- Show row counts
SELECT 'Galaxy rows:', COUNT(*) FROM galaxy;
SELECT 'Star rows:', COUNT(*) FROM star;
SELECT 'Planet rows:', COUNT(*) FROM planet;
SELECT 'Moon rows:', COUNT(*) FROM moon;
SELECT 'Nebula rows:', COUNT(*) FROM nebula;
