/* 
	Name: Chijioke
	
	Chosen Dataset:  Levels_Fyi_Salary_Data
	
	Reason: I chose the "Levels_Fyi_Salary_Data" data set because its structure and 
			content were more readily understandable compared to the other datasets offered. 
			Additionally, the data itself appeared clearer and less ambiguous, making it 
			easier to work with and interpret.
*/


-- Part 1: 
-- Creating the Table and Importing the Data

-- Create the table code

CREATE TABLE salary_data (
    timestamp_col TIMESTAMP,
    company TEXT,
    level TEXT,
    title TEXT,
    total_yearly_compensation BIGINT,
    location TEXT,
    years_of_experience NUMERIC,
    years_at_company NUMERIC,
    tag TEXT,
    base_salary NUMERIC,
    stock_grant_value NUMERIC,
    bonus NUMERIC,
    gender TEXT,
    other_details TEXT,
    city_id INTEGER,
    dmaid TEXT,
    row_number INTEGER,
    masters_degree INTEGER,
    bachelors_degree INTEGER,
    doctorate_degree INTEGER,
    high_school INTEGER,
    some_college INTEGER,
    race_asian INTEGER,
    race_white INTEGER,
    race_two_or_more INTEGER,
    race_black INTEGER,
    race_hispanic INTEGER,
    race TEXT,
    education TEXT
);

--Copy statement to bring/import the data into the database
COPY salary_data FROM 'C:/Program Files/PostgreSQL/16/data/Salary_data.csv' WITH CSV HEADER;

--Basic select statement to verify the data is present and matches what is in the csv file.

SELECT * FROM public.salary_data
LIMIT 100;


--Part 2 (Cleaning)

-- Question 1. 
-- Creating a backup of the imported table
-- This will helps in recovering of the data which was originaly in the table incase
-- We make unnecessary changes to the table.

CREATE TABLE salary_data_backup AS TABLE salary_data;


-- Question  2. 
-- Creating a duplicate column in the table
-- Creating a duplicate column for other details

ALTER TABLE salary_data ADD COLUMN other_details_duplicate TEXT;


-- Question 3. 
-- Locating, updating values representing missing data to column
-- Changing values to NULL for alignment with sql programming

UPDATE salary_data SET other_details = NULL WHERE other_details = 'NA';


--Question 4. 
--Performing step 3 using a second method on a different column
--Chose to use option A to perform on different column(gender)

UPDATE salary_data SET gender = NULL WHERE gender = 'NA';


-- Qusetion 5. 
-- Group similar values for one column
-- Assuming 'level' column has similar values to clean

UPDATE salary_data
SET level = 'Senior'
WHERE level IN ('Senior', 'Snr.', 'Sr');


-- Question 6. 
-- Repeating step 5 on another column
-- Assuming 'location' column has similar values to clean


UPDATE salary_data
SET location = 'Redwood City, CA'
WHERE location IN ('RW', 'R.C.C.A.', 'Redwood City, CA');


-- Question 7

-- Doing additional cleaning method
-- Removing rows with NULL values in 'city_id'
-- this helps clean inconviniences that arise from the use of null values in the case of using this column

DELETE FROM salary_data WHERE city_id IS NULL;

