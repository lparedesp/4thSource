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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creando $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creando [dbo].[Companies]...';


GO
CREATE TABLE [dbo].[Companies] (
    [Id]           INT              IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (50)    NOT NULL,
    [Description]  NVARCHAR (500)   NULL,
    [ClientSince]  DATE             NULL,
    [Logo]         IMAGE            NULL,
    [Created]      DATETIME2 (7)    NOT NULL,
    [CreatedBy]    UNIQUEIDENTIFIER NOT NULL,
    [LastModified] DATETIME2 (7)    NOT NULL,
    [ModifiedBy]   UNIQUEIDENTIFIER NOT NULL,
    [Version]      ROWVERSION       NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creando [dbo].[Companies].[IX_Companies_Name]...';


GO
CREATE NONCLUSTERED INDEX [IX_Companies_Name]
    ON [dbo].[Companies]([Name] ASC);


GO
PRINT N'Creando [dbo].[Contacts]...';


GO
CREATE TABLE [dbo].[Contacts] (
    [Id]           INT              IDENTITY (1, 1) NOT NULL,
    [FirstName]    NVARCHAR (50)    NULL,
    [LastName]     NVARCHAR (50)    NULL,
    [Email]        NVARCHAR (100)   NULL,
    [Mobile]       NVARCHAR (50)    NULL,
    [WorkPhone]    NVARCHAR (50)    NULL,
    [Other]        NVARCHAR (50)    NULL,
    [Company]      INT              NULL,
    [Created]      DATETIME2 (7)    NULL,
    [CreatedBy]    UNIQUEIDENTIFIER NULL,
    [LastModified] DATETIME2 (7)    NULL,
    [ModifiedBy]   UNIQUEIDENTIFIER NULL,
    [Version]      ROWVERSION       NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creando [dbo].[RequestCertifications]...';


GO
CREATE TABLE [dbo].[RequestCertifications] (
    [Id]            INT           NOT NULL,
    [IdRequest]     INT           NOT NULL,
    [Certification] NVARCHAR (50) NOT NULL,
    [IssuedBy]      NVARCHAR (50) NULL,
    [Technology]    NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creando [dbo].[Requests]...';


GO
CREATE TABLE [dbo].[Requests] (
    [Id]               INT            NOT NULL,
    [RequestNumber]    NVARCHAR (50)  NULL,
    [Date]             DATE           NULL,
    [RequestType]      INT            NULL,
    [DateNeeded]       DATE           NULL,
    [CompanyNeeded]    INT            NULL,
    [ContactName]      INT            NULL,
    [PositionType]     INT            NULL,
    [Lenght]           INT            NULL,
    [ResourceType]     INT            NULL,
    [Position]         NVARCHAR (100) NULL,
    [YearsExp]         SMALLINT       NULL,
    [Travel]           INT            NULL,
    [AddtionalDetails] NVARCHAR (500) NULL,
    [InternalComments] NVARCHAR (500) NULL,
    [EnglisLevel]      NCHAR (10)     NULL,
    [Status]           INT            NULL,
    [Created]          NCHAR (10)     NULL,
    [CreatedBy]        NCHAR (10)     NULL,
    [LastModified]     NCHAR (10)     NULL,
    [ModifiedBy]       NCHAR (10)     NULL,
    [Version]          ROWVERSION     NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creando [dbo].[RequestTechnologies]...';


GO
CREATE TABLE [dbo].[RequestTechnologies] (
    [Id]         INT           NOT NULL,
    [Technology] NVARCHAR (50) NULL,
    [Requiered]  BIT           NULL,
    [Type]       NVARCHAR (50) NULL,
    [Months]     INT           NULL,
    [Request]    INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creando [dbo].[ResourceType]...';


GO
CREATE TABLE [dbo].[ResourceType] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Type]        NVARCHAR (50)  NULL,
    [Description] NVARCHAR (150) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creando [dbo].[Status]...';


GO
CREATE TABLE [dbo].[Status] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Status]      NVARCHAR (50)  NOT NULL,
    [Description] NVARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creando FK_Contacts_Companies...';


GO
ALTER TABLE [dbo].[Contacts]
    ADD CONSTRAINT [FK_Contacts_Companies] FOREIGN KEY ([Company]) REFERENCES [dbo].[Companies] ([Id]);


GO
PRINT N'Creando FK_RequestTechnologies_ToRequest...';


GO
ALTER TABLE [dbo].[RequestTechnologies]
    ADD CONSTRAINT [FK_RequestTechnologies_ToRequest] FOREIGN KEY ([Request]) REFERENCES [dbo].[Requests] ([Id]);


GO
-- Paso de refactorización para actualizar el servidor de destino con los registros de transacciones implementadas

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '7c173240-cdab-4c22-a8dc-423fd8c1ce32')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('7c173240-cdab-4c22-a8dc-423fd8c1ce32')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '2940c0dc-9de9-4fcb-bfaa-bb0e09ca5e6f')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('2940c0dc-9de9-4fcb-bfaa-bb0e09ca5e6f')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '91846ba2-ce86-4306-95bf-08084b8f6dda')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('91846ba2-ce86-4306-95bf-08084b8f6dda')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '037fe040-a568-437d-81c5-6366b84eb2ce')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('037fe040-a568-437d-81c5-6366b84eb2ce')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '19b04d57-8afd-4668-9ad4-1ac175690bd2')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('19b04d57-8afd-4668-9ad4-1ac175690bd2')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Actualización completada.';


GO
