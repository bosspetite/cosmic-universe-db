# Cosmic Universe Database

## Description
This project is a PostgreSQL database named `universe`, designed to store data about celestial bodies. It includes tables for galaxies, stars, planets, moons, and nebulae, complete with primary keys, foreign keys, and sample data to meet specific requirements for a database assignment.

## Features
- **Tables**: 
  - `galaxy`: 7 rows (galaxies with names, distances, sizes, etc.)
  - `star`: 7 rows (stars with masses, temperatures, linked to galaxies)
  - `planet`: 13 rows (planets with radii, orbits, linked to stars)
  - `moon`: 21 rows (moons with diameters, gravities, linked to planets)
  - `nebula`: 5 rows (nebulae with densities, ages)
- **Constraints**: Primary keys (`SERIAL`), foreign keys, `UNIQUE` names, `NOT NULL` where required.
- **Data Types**: Uses `INT`, `NUMERIC`, `TEXT`, `BOOLEAN`, and `VARCHAR`.

## Requirements
- PostgreSQL (any recent version, e.g., 13+)
- Command-line access (e.g., `psql`)

## Setup
1. Clone or download this repository.
2. Ensure PostgreSQL is installed and running.
3. Open a terminal and navigate to the folder with `universe.sql`.

## Usage
Run the script to create and populate the database:
```bash
psql -U postgres -f universe.sql# cosmic-universe-db
