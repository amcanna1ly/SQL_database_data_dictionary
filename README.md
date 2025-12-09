## Data Dictionary / Documentation Tools

This folder contains SQL Server scripts for generating human-readable data dictionaries from database metadata and extended properties.

### 1. Database_TableColumnDataDictionary.sql

Generates a table and column level data dictionary for all user tables in the current database, including:

- Schema name and table name  
- Column ordinal and name  
- Data type, max length, precision, and scale  
- Nullability, identity, and computed flags  
- Table and column descriptions from `MS_Description` extended properties (if present)

Usage:

1. Open the script in SSMS.
2. Replace `Database_Name_Here` with the target database name.
3. Run and export the results to CSV or Excel.

### 2. Database_ProcedureParameterDataDictionary.sql

Generates a data dictionary for stored procedures and their parameters, including:

- Schema and procedure name  
- Procedure description from `MS_Description`  
- Parameter name, order, type, and size  
- Output parameter flag  
- Parameter descriptions from `MS_Description`  

Usage is the same as above.
