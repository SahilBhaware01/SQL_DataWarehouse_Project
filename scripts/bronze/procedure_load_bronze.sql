/*
Stored Procedure: Load Bronze Layer (Source -> Bronze)

Script Purpose:
This stored procedure loads data into the 'bronze' schema from external CSV files.
It performs the following actions:
- Truncates the bronze tables before loading data.
- Uses the 'BULK INSERT' command to load data from CSV files to bronze tables.

Parameters:
None.
This stored procedure does not accept any parameters or return any values.

Usage Example:
EXEC bronze.load_bronze;
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    -- Declare variables to track processing and batch timing
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

    BEGIN TRY 
        -- Print procedure header
        PRINT '=====================================';
        PRINT 'Loading Bronze Layer';
        PRINT '==================================== =';
        
        -- Load CRM Data
        PRINT '-----------------------------------------------';
        PRINT 'Loading CRM data'
        PRINT '-----------------------------------------------';

        SET @batch_start_time = GETDATE(); -- Start batch timer

        -- Load CRM Customer Info
        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>>Inserting data into: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM '/data/source_crm/cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>>Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- Load CRM Product Info
        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>>Inserting data into: bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM '/data/source_crm/prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>>Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        SELECT COUNT(*) FROM bronze.crm_prd_info;

        -- Load CRM Sales Details
        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>>Inserting data into: bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM '/data/source_crm/sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>>Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        SELECT COUNT(*) FROM bronze.crm_sales_details;

        -- Load ERP Data
        PRINT '-----------------------------------------------';
        PRINT 'Loading ERP data'
        PRINT '-----------------------------------------------';

        -- Load ERP Customer Data
        SET @start_time = GETDATE();
        PRINT 'Truncating Table: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT 'Inserting data into: bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM '/data/source_erp/cust_az12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>>Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        SELECT COUNT(*) FROM bronze.erp_cust_az12;

        -- Load ERP Product Category Data
        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>>Inserting data into: bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM '/data/source_erp/px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>>Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2;

        -- Load ERP Location Data
        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>>Inserting data into: bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM '/data/source_erp/loc_a101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();

        -- Calculate total batch time
        SET @batch_end_time = GETDATE();
        PRINT '>>Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>>Total Batch Load Duration:' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';

        -- Completion message
        PRINT '=====================================';
        PRINT 'Loading Bronze Layer Completed!';
        PRINT '==================================== =';

    END TRY 
    BEGIN CATCH
        -- Error handling block
        PRINT '==========================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'ERROR :' + ERROR_MESSAGE();
        PRINT 'ERROR CODE :' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'ERROR STATE :' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '==========================================';
    END CATCH 
END
