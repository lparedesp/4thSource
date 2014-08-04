CREATE TABLE [dbo].[RequestCertifications]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Request] INT NOT NULL, 
    [Certification] NVARCHAR(50) NOT NULL, 
    [IssuedBy] NVARCHAR(50) NULL, 
    [Technology] NVARCHAR(50) NULL, 
    CONSTRAINT [FK_RequestCertifications_ToRequest] FOREIGN KEY ([Request]) REFERENCES [Requests]([Id])
)
