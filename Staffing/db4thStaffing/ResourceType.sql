CREATE TABLE [dbo].[ResourceType]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Type] NVARCHAR(50) NULL, 
    [Description] NVARCHAR(150) NULL 
)
