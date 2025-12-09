/*======================================================================================= 
    Name: Database_ProcedureParameterDataDictionary.sql
    Author: Alex McAnnally   
    Last Edited: 12/9/2025
 
    Purpose:
        Generate a data dictionary for stored procedures and their parameters
        in the current database, including extended property descriptions.

=======================================================================================*/

/*

USE Database_Name_Here;
GO

*/

SET NOCOUNT ON;

SELECT
    sch.name                                        AS SchemaName,
    p.name                                          AS ProcedureName,
    CAST(epProc.value AS nvarchar(4000))            AS ProcedureDescription,
    prm.parameter_id                                AS ParameterOrdinal,
    prm.name                                        AS ParameterName,
    typ.name                                        AS ParameterDataType,
    prm.max_length                                  AS MaxLength,
    prm.precision                                   AS [Precision],
    prm.scale                                       AS [Scale],
    prm.is_output                                   AS IsOutputParameter,
    CAST(epParam.value AS nvarchar(4000))           AS ParameterDescription
FROM sys.procedures AS p
INNER JOIN sys.schemas AS sch
    ON p.schema_id = sch.schema_id
LEFT JOIN sys.parameters AS prm
    ON p.object_id = prm.object_id
LEFT JOIN sys.types AS typ
    ON prm.user_type_id = typ.user_type_id
LEFT JOIN sys.extended_properties AS epProc
    ON epProc.major_id = p.object_id
   AND epProc.minor_id = 0
   AND epProc.name = 'MS_Description'
LEFT JOIN sys.extended_properties AS epParam
    ON epParam.major_id = prm.object_id
   AND epParam.minor_id = prm.parameter_id
   AND epParam.name = 'MS_Description'
WHERE
    p.is_ms_shipped = 0
ORDER BY
    sch.name,
    p.name,
    prm.parameter_id;
GO
