﻿CREATE TABLE [dbo].[Status]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Status] NVARCHAR(50) NOT NULL, 
    [Description] NVARCHAR(200) NULL
)