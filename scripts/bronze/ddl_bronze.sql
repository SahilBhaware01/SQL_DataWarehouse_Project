/*
DDL Script: Create Bronze Tables

Script Purpose:
This script creates tables in the 'bronze' schema, dropping existing tables if they already exist.
Run this script to re-define the DDL structure of 'bronze' Tables.
*/

-- Drop the table 'crm_cust_info' from the 'bronze' schema if it already exists
IF OBJECT_ID('bronze.crm_cust_info','U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;

-- Create a new table to store customer information
CREATE TABLE bronze.crm_cust_info (
    cst_id INT,                         -- Customer ID (integer)
    cst_key NVARCHAR(50),               -- Unique customer key
    cst_firstname NVARCHAR(50),         -- Customer's first name
    cst_lastname NVARCHAR(50),          -- Customer's last name
    cst_marital_status NVARCHAR(50),    -- Marital status of the customer
    cst_gndr NVARCHAR(50),              -- Gender of the customer
    cst_create_date DATE                -- Date when the customer record was created
);

-- Drop the table 'crm_prd_info' if it already exists
IF OBJECT_ID('bronze.crm_prd_info','U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;

-- Create a new table to store product information
CREATE TABLE bronze.crm_prd_info (
    prd_id INT,                         -- Product ID (integer)
    prd_key NVARCHAR(50),               -- Unique product key
    prd_nm NVARCHAR(50),                -- Product name
    prd_cost INT,                       -- Cost of the product
    prd_line NVARCHAR(50),              -- Product line or category
    prd_start_dt DATETIME,              -- Product start/launch date
    prd_end_dt DATETIME                 -- Product end/discontinuation date
);

-- Drop the table 'crm_sales_details' if it already exists
IF OBJECT_ID('bronze.crm_sales_details','U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;

-- Create a new table to store sales transaction details
CREATE TABLE bronze.crm_sales_details ( 
    sls_ord_num NVARCHAR(50),           -- Sales order number
    sls_prd_key NVARCHAR(50),           -- Product key associated with the sale
    sls_cust_id INT,                    -- Customer ID associated with the sale
    s1s_order_dt INT,                   -- Order date (should likely be DATE/DATETIME instead of INT)
    s1s_ship_dt INT,                    -- Shipping date (same note as above)
    sls_due_dt INT,                     -- Due date for delivery/payment
    s1s_sales INT,                      -- Total sales amount
    sls_quantity INT,                   -- Quantity sold
    sls_price INT                       -- Price per unit
); 

-- Drop the table 'erp_loc_a101' if it already exists
IF OBJECT_ID('bronze.erp_loc_a101','U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;

-- Create a new table to store customer location information
CREATE TABLE bronze.erp_loc_a101 (
    cid NVARCHAR(50),                   -- Customer ID or code
    cntry NVARCHAR(50)                  -- Country of the customer
);

-- Drop the table 'erp_cust_az12' if it already exists
IF OBJECT_ID('bronze.erp_cust_az12','U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;

-- Create a new table to store ERP customer demographic data
CREATE TABLE bronze.erp_cust_az12 (
    cid NVARCHAR(50),                   -- Customer ID or code
    bdate DATE,                         -- Birthdate of the customer
    gen NVARCHAR(50)                    -- Gender of the customer
);

-- Drop the table 'erp_px_cat_g1v2' if it already exists
IF OBJECT_ID('bronze.erp_px_cat_g1v2','U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;

-- Create a new table to store product category and maintenance information
CREATE TABLE bronze.erp_px_cat_g1v2 (
    id NVARCHAR(50),                    -- Product or item ID
    cat NVARCHAR(50),                   -- Product category
    subcat NVARCHAR(50),                -- Sub-category of the product
    maintenance NVARCHAR(50)            -- Maintenance-related info (e.g., schedule, type)
);
