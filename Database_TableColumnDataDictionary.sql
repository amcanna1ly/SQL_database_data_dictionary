/*======================================================================================= 
    Name: Database_TableColumnDataDictionary.sql
    Author: Alex McAnnally   
    Last Edited: 12/9/2025
 
    Purpose:
        Generate a data dictionary for all user tables and columns in the current
        database, including extended property descriptions where available.

    Notes:
        - Designed for SQL Server.
        - Extended properties use the standard 'MS_Description' convention.
        - Output is suitable for export to CSV or use in documentation tools.
=======================================================================================*/

/*

USE Database_Name_Here;
GO

*/

SET NOCOUNT ON;

SELECT
    sch.name                                       AS SchemaName,
    tbl.name                                       AS TableName,
    CAST(epTbl.value AS nvarchar(4000))            AS TableDescription,
    col.column_id                                  AS ColumnOrdinal,
    col.name                                       AS ColumnName,
    typ.name                                       AS DataType,
    col.max_length                                 AS MaxLength,
    col.precision                                  AS [Precision],
    col.scale                                      AS [Scale],
    col.is_nullable                                AS IsNullable,
    col.is_identity                                AS IsIdentity,
    col.is_computed                                AS IsComputed,
    CAST(epCol.value AS nvarchar(4000))            AS ColumnDescription
FROM sys.tables AS tbl
INNER JOIN sys.schemas AS sch
    ON tbl.schema_id = sch.schema_id
INNER JOIN sys.columns AS col
    ON tbl.object_id = col.object_id
INNER JOIN sys.types AS typ
    ON col.user_type_id = typ.user_type_id
LEFT JOIN sys.extended_properties AS epTbl
    ON epTbl.major_id = tbl.object_id
   AND epTbl.minor_id = 0
   AND epTbl.name = 'MS_Description'
LEFT JOIN sys.extended_properties AS epCol
    ON epCol.major_id = col.object_id
   AND epCol.minor_id = col.column_id
   AND epCol.name = 'MS_Description'
WHERE
    tbl.is_ms_shipped = 0
ORDER BY
    sch.name,
    tbl.name,
    col.column_id;
GO
