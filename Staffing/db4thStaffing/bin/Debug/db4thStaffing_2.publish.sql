/*
Script de implementación para db4thStaffing

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "db4thStaffing"
:setvar DefaultFilePrefix "db4thStaffing"
:setvar DefaultDataPath "C:\Users\User\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\v11.0\"
:setvar DefaultLogPath "C:\Users\User\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\v11.0\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
El tipo de la columna CreatedBy de la tabla [dbo].[Requests] es actualmente  NCHAR (10) NULL pero se está cambiando a  UNIQUEIDENTIFIER NULL. Puede que se pierdan datos.

El tipo de la columna ModifiedBy de la tabla [dbo].[Requests] es actualmente  NCHAR (10) NULL pero se está cambiando a  UNIQUEIDENTIFIER NULL. Puede que se pierdan datos.
*/

IF EXISTS (select top 1 1 from [dbo].[Requests])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
PRINT N'Modificando [dbo].[Requests]...';


GO
ALTER TABLE [dbo].[Requests] ALTER COLUMN [Created] DATETIME2 (7) NULL;

ALTER TABLE [dbo].[Requests] ALTER COLUMN [CreatedBy] UNIQUEIDENTIFIER NULL;

ALTER TABLE [dbo].[Requests] ALTER COLUMN [LastModified] DATETIME2 (7) NULL;

ALTER TABLE [dbo].[Requests] ALTER COLUMN [ModifiedBy] UNIQUEIDENTIFIER NULL;


GO
PRINT N'Creando [dbo].[PositionTypes]...';


GO
CREATE TABLE [dbo].[PositionTypes] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [PositionType] NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creando [dbo].[RequestTypes]...';


GO
CREATE TABLE [dbo].[RequestTypes] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [RequestType] NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creando FK_Requests_ToPositionTypes...';


GO
ALTER TABLE [dbo].[Requests] WITH NOCHECK
    ADD CONSTRAINT [FK_Requests_ToPositionTypes] FOREIGN KEY ([PositionType]) REFERENCES [dbo].[PositionTypes] ([Id]);


GO
PRINT N'Creando FK_Requests_ToRequestType...';


GO
ALTER TABLE [dbo].[Requests] WITH NOCHECK
    ADD CONSTRAINT [FK_Requests_ToRequestType] FOREIGN KEY ([RequestType]) REFERENCES [dbo].[RequestTypes] ([Id]);


GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Requests] WITH CHECK CHECK CONSTRAINT [FK_Requests_ToPositionTypes];

ALTER TABLE [dbo].[Requests] WITH CHECK CHECK CONSTRAINT [FK_Requests_ToRequestType];


GO
PRINT N'Actualización completada.';


GO
