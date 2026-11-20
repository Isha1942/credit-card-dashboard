-- Credit Card Customer Report: MySQL setup
-- Database: ccdb_pbi_project
-- Tables: cc_details (credit_card.csv), cust_details (customer.csv)

CREATE DATABASE IF NOT EXISTS ccdb_pbi_project;
USE ccdb_pbi_project;

-- STEP 1: create the tables.
-- Copy the exact CREATE TABLE statements from your own database:
--   SHOW CREATE TABLE cc_details;
--   SHOW CREATE TABLE cust_details;
-- and paste them below, so the column names and types match your data.

-- CREATE TABLE cc_details ( ... );
-- CREATE TABLE cust_details ( ... );

-- STEP 2: import the CSV files.
-- Option A: MySQL Workbench > right-click table > Table Data Import Wizard.
-- Option B: LOAD DATA (change the path to your own file location):
-- LOAD DATA LOCAL INFILE 'C:/path/to/credit_card.csv'
-- INTO TABLE cc_details
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;
--
-- LOAD DATA LOCAL INFILE 'C:/path/to/customer.csv'
-- INTO TABLE cust_details
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- STEP 3: quick checks after import.
SELECT COUNT(*) AS cc_rows FROM cc_details;       -- about 10,108
SELECT COUNT(*) AS cust_rows FROM cust_details;   -- about 10,108

-- Client_Num should be unique in cust_details.
-- If this returns rows, remove duplicates (I fixed this in Power Query).
SELECT Client_Num, COUNT(*) AS times
FROM cust_details
GROUP BY Client_Num
HAVING COUNT(*) > 1;

-- Check the join between the two tables.
SELECT COUNT(*) AS matched_rows
FROM cc_details c
JOIN cust_details u ON c.Client_Num = u.Client_Num;
