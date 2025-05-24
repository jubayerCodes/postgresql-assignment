-- TABLE CREATION
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name varchar(30) NOT NULL,
    region varchar(50) NOT NULL,
);

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name varchar(30) NOT NULL,
    scientific_name varchar(50) NOT NULL,
    discovery_date date NOT NULL,
    conservation_status varchar NOT NULL,
);

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INTEGER REFERENCES rangers (ranger_id) NOT NULL,
    species_id INTEGER REFERENCES species (species_id) NOT NULL,
    sighting_time TIMESTAMP without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "location" VARCHAR(50) NOT NULL,
    notes VARCHAR(50) DEFAULT NULL
);

INSERT INTO rangers (name, region)
VALUES
    ('Alice Green', 'Northern Hills'),
    ('Bob White', 'River Delta'),
    ('Carol King', 'Mountain Range');