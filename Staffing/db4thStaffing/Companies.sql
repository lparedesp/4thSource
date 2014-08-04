CREATE TABLE [dbo].[Companies]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Name] NVARCHAR(50) NOT NULL, 
    [Description] NVARCHAR(500) NULL, 
    [ClientSince] DATE NULL, 
    [Logo] IMAGE NULL, 
    [Created] DATETIME2 NULL DEFAULT getdate(), 
    [CreatedBy] UNIQUEIDENTIFIER NULL, 
    [LastModified] DATETIME2 NULL DEFAULT getdate(), 
    [ModifiedBy] UNIQUEIDENTIFIER NULL , 
    [Version] ROWVERSION NULL
)

GO

CREATE INDEX [IX_Companies_Name] ON [dbo].[Companies] ([Name])
