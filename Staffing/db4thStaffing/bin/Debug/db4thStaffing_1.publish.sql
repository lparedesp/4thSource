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
El tipo de la columna EnglishLevel de la tabla [dbo].[Requests] es actualmente  NCHAR (10) NULL pero se está cambiando a  NCHAR (1) NULL. Puede que se pierdan datos.
*/

IF EXISTS (select top 1 1 from [dbo].[Requests])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
PRINT N'La siguiente operación se generó a partir de un archivo de registro de refactorización f6bf7de3-97f5-4f7c-83b0-941dd1248401';

PRINT N'Cambiar el nombre de [dbo].[RequestCertifications].[IdRequest] a Request';


GO
EXECUTE sp_rename @objname = N'[dbo].[RequestCertifications].[IdRequest]', @newname = N'Request', @objtype = N'COLUMN';


GO
PRINT N'La siguiente operación se generó a partir de un archivo de registro de refactorización 80aa248c-f50b-43c3-87e1-3b01a2e531fb';

PRINT N'Cambiar el nombre de [dbo].[Requests].[EnglisLevel] a EnglishLevel';


GO
EXECUTE sp_rename @objname = N'[dbo].[Requests].[EnglisLevel]', @newname = N'EnglishLevel', @objtype = N'COLUMN';


GO
PRINT N'Modificando [dbo].[Requests]...';


GO
ALTER TABLE [dbo].[Requests] ALTER COLUMN [EnglishLevel] NCHAR (1) NULL;


GO
PRINT N'Creando FK_RequestCertifications_ToRequest...';


GO
ALTER TABLE [dbo].[RequestCertifications] WITH NOCHECK
    ADD CONSTRAINT [FK_RequestCertifications_ToRequest] FOREIGN KEY ([Request]) REFERENCES [dbo].[Requests] ([Id]);


GO
PRINT N'Creando FK_Requests_ToCompanies...';


GO
ALTER TABLE [dbo].[Requests] WITH NOCHECK
    ADD CONSTRAINT [FK_Requests_ToCompanies] FOREIGN KEY ([CompanyNeeded]) REFERENCES [dbo].[Companies] ([Id]);


GO
PRINT N'Creando FK_Requests_ToResourceType...';


GO
ALTER TABLE [dbo].[Requests] WITH NOCHECK
    ADD CONSTRAINT [FK_Requests_ToResourceType] FOREIGN KEY ([ResourceType]) REFERENCES [dbo].[ResourceType] ([Id]);


GO
PRINT N'Creando FK_Requests_ToStatus...';


GO
ALTER TABLE [dbo].[Requests] WITH NOCHECK
    ADD CONSTRAINT [FK_Requests_ToStatus] FOREIGN KEY ([Status]) REFERENCES [dbo].[Status] ([Id]);


GO
-- Paso de refactorización para actualizar el servidor de destino con los registros de transacciones implementadas
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f6bf7de3-97f5-4f7c-83b0-941dd1248401')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f6bf7de3-97f5-4f7c-83b0-941dd1248401')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '80aa248c-f50b-43c3-87e1-3b01a2e531fb')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('80aa248c-f50b-43c3-87e1-3b01a2e531fb')

GO

GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[RequestCertifications] WITH CHECK CHECK CONSTRAINT [FK_RequestCertifications_ToRequest];

ALTER TABLE [dbo].[Requests] WITH CHECK CHECK CONSTRAINT [FK_Requests_ToCompanies];

ALTER TABLE [dbo].[Requests] WITH CHECK CHECK CONSTRAINT [FK_Requests_ToResourceType];

ALTER TABLE [dbo].[Requests] WITH CHECK CHECK CONSTRAINT [FK_Requests_ToStatus];


GO
PRINT N'Actualización completada.';


GO
