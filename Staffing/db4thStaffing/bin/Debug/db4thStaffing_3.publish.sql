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
La columna Email de la tabla [dbo].[Contacts] debe cambiarse de NULL a NOT NULL. Si la tabla contiene datos, puede que no funcione el script ALTER. Para evitar este problema, debe agregar valores en todas las filas de esta columna, marcar la columna de modo que permita valores NULL o habilitar la generación de valores predeterminados inteligentes como opción de implementación.

La columna FirstName de la tabla [dbo].[Contacts] debe cambiarse de NULL a NOT NULL. Si la tabla contiene datos, puede que no funcione el script ALTER. Para evitar este problema, debe agregar valores en todas las filas de esta columna, marcar la columna de modo que permita valores NULL o habilitar la generación de valores predeterminados inteligentes como opción de implementación.

La columna LastName de la tabla [dbo].[Contacts] debe cambiarse de NULL a NOT NULL. Si la tabla contiene datos, puede que no funcione el script ALTER. Para evitar este problema, debe agregar valores en todas las filas de esta columna, marcar la columna de modo que permita valores NULL o habilitar la generación de valores predeterminados inteligentes como opción de implementación.
*/

IF EXISTS (select top 1 1 from [dbo].[Contacts])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
PRINT N'Modificando [dbo].[Companies]...';


GO
ALTER TABLE [dbo].[Companies] ALTER COLUMN [Created] DATETIME2 (7) NULL;

ALTER TABLE [dbo].[Companies] ALTER COLUMN [CreatedBy] UNIQUEIDENTIFIER NULL;

ALTER TABLE [dbo].[Companies] ALTER COLUMN [LastModified] DATETIME2 (7) NULL;

ALTER TABLE [dbo].[Companies] ALTER COLUMN [ModifiedBy] UNIQUEIDENTIFIER NULL;


GO
PRINT N'Modificando [dbo].[Contacts]...';


GO
ALTER TABLE [dbo].[Contacts] ALTER COLUMN [Email] NVARCHAR (100) NOT NULL;

ALTER TABLE [dbo].[Contacts] ALTER COLUMN [FirstName] NVARCHAR (50) NOT NULL;

ALTER TABLE [dbo].[Contacts] ALTER COLUMN [LastName] NVARCHAR (50) NOT NULL;


GO
PRINT N'Creando Restricción DEFAULT en [dbo].[Companies]....';


GO
ALTER TABLE [dbo].[Companies]
    ADD DEFAULT now() FOR [Created];


GO
PRINT N'Creando Restricción DEFAULT en [dbo].[Companies]....';


GO
ALTER TABLE [dbo].[Companies]
    ADD DEFAULT now() FOR [ModifiedBy];


GO
PRINT N'Actualización completada.';


GO
