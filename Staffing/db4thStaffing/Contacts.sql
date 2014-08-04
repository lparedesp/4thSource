CREATE TABLE [dbo].[Contacts]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [FirstName] NVARCHAR(50) NOT NULL, 
    [LastName] NVARCHAR(50) NOT NULL, 
    [Email] NVARCHAR(100) NOT NULL, 
    [Mobile] NVARCHAR(50) NULL, 
    [WorkPhone] NVARCHAR(50) NULL, 
    [Other] NVARCHAR(50) NULL, 
    [Company] INT NULL, 
    [Created] DATETIME2 NULL DEFAULT getdate(), 
    [CreatedBy] UNIQUEIDENTIFIER NULL, 
    [LastModified] DATETIME2 NULL DEFAULT getdate(), 
    [ModifiedBy] UNIQUEIDENTIFIER NULL, 
    [Version] ROWVERSION NULL, 
    CONSTRAINT [FK_Contacts_Companies] FOREIGN KEY ([Company]) REFERENCES [Companies]([Id])
)
