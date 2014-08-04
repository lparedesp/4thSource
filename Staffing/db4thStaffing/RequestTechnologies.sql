CREATE TABLE [dbo].[RequestTechnologies]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Technology] NVARCHAR(50) NULL, 
    [Requiered] BIT NULL, 
    [Type] NVARCHAR(50) NULL, 
    [Months] INT NULL, 
    [Request] INT NOT NULL, 
    CONSTRAINT [FK_RequestTechnologies_ToRequest] FOREIGN KEY ([Request]) REFERENCES [Requests]([Id])
)
