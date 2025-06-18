/*
------------------------------------------------------------
Create Database and Schemas

Script Purpose:
This script creates a new database named 'DataWarehouse' after checking if it already exists.
If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
within the database: 'bronze', 'silver', and 'gold'.

WARNING:
Running this script will drop the entire 'DataWarehouse' database if it exists.
All data in the database will be permanently deleted. 
Proceed with caution and ensure you have proper backups before running this script.
------------------------------------------------------------
*/

USE master;  -- Switch context to the master database
GO

-- Check if the 'DataWarehouse' database exists, and if so, drop it safely
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    -- Set the database to SINGLE_USER mode to disconnect all users and rollback active transactions
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    -- Drop the 'DataWarehouse' database
    DROP DATABASE DataWarehouse;
END;
GO

-- Create a new database named 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO

-- View all current databases to confirm creation
SELECT name FROM sys.databases;
GO

-- Switch context to the newly created 'DataWarehouse' database
USE DataWarehouse;
GO

-- Create the 'bronze' schema to store raw or lightly processed data
CREATE SCHEMA bronze;
GO

-- Create the 'silver' schema to store cleaned and structured data
CREATE SCHEMA silver;
GO

-- Create the 'gold' schema to store curated, business-ready data
CREATE SCHEMA gold;
GO
