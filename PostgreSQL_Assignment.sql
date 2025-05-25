-- TABLE CREATION
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    "name" varchar(30) NOT NULL,
    region varchar(50) NOT NULL
);

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name varchar(30) NOT NULL,
    scientific_name varchar(50) NOT NULL,
    discovery_date date NOT NULL,
    conservation_status varchar NOT NULL
);

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INTEGER REFERENCES rangers (ranger_id) NOT NULL,
    species_id INTEGER REFERENCES species (species_id) NOT NULL,
    sighting_time TIMESTAMP without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "location" VARCHAR(50) NOT NULL,
    notes VARCHAR(50) DEFAULT NULL
);

-- SAMPLE DATA INSERTION

INSERT INTO
    rangers (name, region)
VALUES (
        'Alice Green',
        'Northern Hills'
    ),
    ('Bob White', 'River Delta'),
    (
        'Carol King',
        'Mountain Range'
    );

INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

INSERT INTO
    sightings (
        ranger_id,
        species_id,
        sighting_time,
        location,
        notes
    )
VALUES (
        1,
        1,
        '2024-05-10 07:45:00',
        'Peak Ridge',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        '2024-05-12 16:20:00',
        'Bankwood Area',
        'Juvenile seen'
    ),
    (
        3,
        3,
        '2024-05-15 09:10:00',
        'Bamboo Grove East',
        'Feeding observed'
    ),
    (
        2,
        1,
        '2024-05-18 18:30:00',
        'Snowfall Pass',
        NULL
    ),
    (
        2,
        3,
        '2024-05-20 08:00:00',
        'River Delta',
        NULL
    ),
    (
        3,
        2,
        '2025-05-24 20:28:10',
        'Mountain Range',
        NULL
    );

-- Problem 1
INSERT INTO
    rangers ("name", region)
VALUES ('Derek Fox', 'Coastal Plains');

-- Problem 2

SELECT count(DISTINCT species_id) FROM sightings;

-- Problem 3

SELECT * FROM sightings WHERE location LIKE '%Pass%';

-- Problem 4

SELECT name, count(sightings.sighting_id) as total_sightings
FROM rangers
    LEFT JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY
    rangers.ranger_id;

-- Problem 5

SELECT common_name
FROM species
    LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE
    sighting_id IS NULL;

-- Problem 6

SELECT common_name, sighting_time, name
FROM
    sightings
    JOIN rangers ON sightings.ranger_id = rangers.ranger_id
    JOIN species ON sightings.species_id = species.species_id
ORDER BY sighting_time DESC
LIMIT 2;

-- Problem 7
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    discovery_date < '1800-01-01';

--Problem 8
SELECT
    sighting_id,
    CASE
        WHEN extract(
            HOUR
            FROM sighting_time
        ) < 12 THEN 'Morning'
        WHEN extract(
            HOUR
            FROM sighting_time
        ) BETWEEN 12 AND 17  THEN 'Afternoon'
        ELSE 'Evening'
    END as time_of_day
FROM sightings;

--Problem 9

DELETE FROM rangers
WHERE
    ranger_id NOT IN (
        SELECT DISTINCT
            ranger_id
        FROM sightings
    )