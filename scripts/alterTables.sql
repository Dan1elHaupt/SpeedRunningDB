USE SpeedRunnerDB
GO

ALTER TABLE dbo.Runs
    ADD deleted BIT NOT NULL 
    CONSTRAINT default_value DEFAULT 0
GO

ALTER TABLE dbo.Runners
    ADD deleted BIT NOT NULL 
    CONSTRAINT default_value DEFAULT 0
GO