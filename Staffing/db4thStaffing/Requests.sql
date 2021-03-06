﻿CREATE TABLE [dbo].[Requests]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [RequestNumber] NVARCHAR(50) NULL, 
    [Date] DATE NULL, 
    [RequestType] INT NULL, 
    [DateNeeded] DATE NULL, 
    [CompanyNeeded] INT NULL, 
    [ContactName] INT NULL, 
    [PositionType] INT NULL, 
    [Lenght] INT NULL, 
    [ResourceType] INT NULL, 
    [Position] NVARCHAR(100) NULL, 
    [YearsExp] SMALLINT NULL, 
    [Travel] INT NULL, 
    [AddtionalDetails] NVARCHAR(500) NULL, 
    [InternalComments] NVARCHAR(500) NULL, 
    [EnglishLevel] NCHAR(1) NULL, 
    [Status] INT NULL, 
    [Created] DATETIME2 NULL, 
    [CreatedBy] UNIQUEIDENTIFIER NULL, 
    [LastModified] DATETIME2 NULL, 
    [ModifiedBy] UNIQUEIDENTIFIER NULL, 
    [Version] ROWVERSION NULL, 
    CONSTRAINT [FK_Requests_ToCompanies] FOREIGN KEY ([CompanyNeeded]) REFERENCES [Companies]([Id]), 
    CONSTRAINT [FK_Requests_ToResourceType] FOREIGN KEY ([ResourceType]) REFERENCES [ResourceType]([Id]), 
    CONSTRAINT [FK_Requests_ToStatus] FOREIGN KEY ([Status]) REFERENCES [Status]([Id]), 
    CONSTRAINT [FK_Requests_ToRequestType] FOREIGN KEY ([RequestType]) REFERENCES [RequestTypes]([Id]), 
    CONSTRAINT [FK_Requests_ToPositionTypes] FOREIGN KEY ([PositionType]) REFERENCES [PositionTypes]([Id])
)
