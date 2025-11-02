/*
==============================================
Stored Procedure: Load Bronze Layer (Source --> bronze)
==============================================
Script purpose:
	This stored procedure loads data into the 'bronze' schema from external CSV files.
	It performs the following actions:
		- Truncates the bronze tables before loading data.
		- uses the 'bulk insert' command to load data from CSV files to bronze tables.

Parameters:
	None.
This stored procedure does not accept any parameters or return any values.

usage example:
EXEC bronze.load_bronze;
  ===============================================================
  */


EXEC bronze.load_bronze -- no need to select everything.

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME
	BEGIN TRY
-- If we constantly re-use the same code, we can store it as "stored procedures" to avoid writing it all over again. We can give the command above and execute everything in another query.
-- DataWareHouse Project > Programmability > Stored Procedures
		
		PRINT '=====================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=====================================================';

		PRINT '-----------------------------------------------------';
		PRINT 'Loading CRM tables';
		PRINT '-----------------------------------------------------';
	



		SET @start_time = GETDATE();
		PRINT '>> Truncating table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		-- Do this to avoid duplicating it again. This function erases the table and recreates it. 
		PRINT '>> Inserting table: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		-- Instead of inserting row by row, we can bulk add them in just one operation.
		FROM 'C:\Users\anupe\OneDrive\Documents\SQL_data_with_baraa\crm\cust_info.csv'
		-- Define the source properly from the file explorer. No errors should be there.
		WITH (
			FIRSTROW = 2, -- Number 1 will be the header.
			FIELDTERMINATOR = ',', -- How are the columns separated.
			TABLOCK -- locking the table when importing data.
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';



		SET @start_time = GETDATE();
		PRINT '>> Truncating table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting table: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\anupe\OneDrive\Documents\SQL_data_with_baraa\crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';




		SET @start_time = GETDATE();
		PRINT '>> Truncating table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Truncating table: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\anupe\OneDrive\Documents\SQL_data_with_baraa\crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';




		PRINT '-----------------------------------------------------';
		PRINT 'Loading ERP tables';
		PRINT '-----------------------------------------------------';


		SET @start_time = GETDATE();
		PRINT '>> Truncating table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Inserting table: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\anupe\OneDrive\Documents\SQL_data_with_baraa\erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';




		SET @start_time = GETDATE();
		PRINT '>> Truncating table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting table: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\anupe\OneDrive\Documents\SQL_data_with_baraa\erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';




		SET @start_time = GETDATE();
		PRINT '>> Truncating table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Truncating table: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\anupe\OneDrive\Documents\SQL_data_with_baraa\erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';



	END TRY
	BEGIN CATCH
		PRINT '===============================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT '===============================================';
		-- This is done to catch errors in the code. it is good practice to clearly define the things you're doing.
	END CATCH
END
