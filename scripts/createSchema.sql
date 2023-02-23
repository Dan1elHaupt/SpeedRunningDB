USE master
GO

IF EXISTS(SELECT * FROM sys.databases WHERE name='SpeedRunnerDB')
DROP DATABASE SpeedRunnerDB

CREATE DATABASE SpeedRunnerDB;
GO

USE SpeedRunnerDB;
GO



--------------------------------------------------------------------CREATE TABLES--------------------------------------------------------------------



CREATE TABLE dbo.Regions (
	region_id int identity(1,1) NOT NULL,
	region_name varchar(56) NOT NULL,
	region_abbreviation varchar(3) NOT NULL,
	CONSTRAINT [PK_Regions] PRIMARY KEY CLUSTERED (
		region_id ASC
	)
)
GO

CREATE TABLE dbo.Runners (
	runner_id int identity(1,1) NOT NULL,
	region_id int foreign key references dbo.Regions(region_id) NOT NULL,
	runner_name nvarchar(60) NOT NULL,
	date_started date NOT NULL,
	is_banned bit NOT NULL,
	CONSTRAINT [PK_Actors] PRIMARY KEY CLUSTERED (
		runner_id ASC
	)
)
GO

CREATE TABLE dbo.Games (
	game_id int identity(1,1) NOT NULL,
	game_name nvarchar(120) NOT NULL,
	developer nvarchar(120) NOT NULL,
	publisher nvarchar(120) NOT NULL,
	CONSTRAINT [PK_Games] PRIMARY KEY CLUSTERED (
		game_id ASC
	)
)
GO

CREATE TABLE dbo.Genres (
	genre_id int identity(1,1) NOT NULL,
	genre_name varchar(30) NOT NULL,
	CONSTRAINT [PK_Genres] PRIMARY KEY CLUSTERED (
		genre_id ASC
	)
)
GO

CREATE TABLE dbo.Categories (
	category_id int identity(1,1) NOT NULL,
	category_name nvarchar(60) NOT NULL,
	date_CREATEd date NOT NULL,
	CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED (
		category_id ASC
	)
)
GO

CREATE TABLE dbo.Platforms (
	platform_id int identity(1,1) NOT NULL,
	platform_name varchar(20) NOT NULL,
	company varchar(30),
	release_date date,
	CONSTRAINT [PK_Platforms] PRIMARY KEY CLUSTERED (
		platform_id ASC
	)
)
GO

CREATE TABLE dbo.Game_Genres (
	game_id int foreign key references dbo.Games(game_id) NOT NULL,
	genre_id int foreign key references dbo.Genres(genre_id) NOT NULL
)
GO

CREATE TABLE dbo.Game_Categories (
	game_id int foreign key references dbo.Games(game_id) NOT NULL,
	category_id int foreign key references dbo.Categories(category_id) NOT NULL
)
GO

CREATE TABLE dbo.Game_Platforms (
	game_id int foreign key references dbo.Games(game_id) NOT NULL,
	platform_id int foreign key references dbo.Platforms(platform_id) NOT NULL
)
GO

CREATE TABLE dbo.Runs (
	run_id int identity(1,1) NOT NULL,
	runner_id int foreign key references dbo.Runners(runner_id) NOT NULL,
	game_id int foreign key references dbo.Games(game_id) NOT NULL,
	category_id int foreign key references dbo.Categories(category_id) NOT NULL,
	platform_id int foreign key references dbo.Platforms(platform_id) NOT NULL,
	region_id int foreign key references dbo.Regions(region_id) NOT NULL,
	run_time int NOT NULL,
	in_game_time int,
	game_version varchar(50),
	date_posted datetime NOT NULL,
	video_link varchar(100),
	is_valid bit,
	CONSTRAINT [PK_Run] PRIMARY KEY CLUSTERED (
		run_id ASC
	)
)
GO

CREATE TABLE dbo.Skips (
	skip_id int identity(1,1) NOT NULL,
	game_id int foreign key references dbo.Games(game_id) NOT NULL,
	skip_name nvarchar(120) NOT NULL,
	skip_description nvarchar(600),
	date_CREATEd date NOT NULL,
	CONSTRAINT [PK_Skips] PRIMARY KEY CLUSTERED (
		skip_id ASC
	)
)
GO



-------------------------------------------------------------------- INSERT DUMMY DATA --------------------------------------------------------------------



INSERT INTO dbo.Categories(category_name, date_CREATEd)
VALUES
	('100%','20100101')
GO

INSERT INTO dbo.Genres(genre_name)
VALUES
	('Sandbox'),
	('Shooter'),
	('Real-time strategy'),
	('MOBA'),
	('RPG'),
	('Sports'),
	('Simulation')
GO

INSERT INTO dbo.Platforms(platform_name, company, release_date)
VALUES
	('PS3','Sony','20061111'),
	('PS4','Sony','20131115'),
	('PS5','Sony','20201112'),
	('PC',null,null),
	('Xbox360','Microsoft','20051122'),
	('XboxOne','Microsoft','20131122'),
	('XboxSeriesS','Microsoft','20201110'),
	('XboxSeriesX','Microsoft','20201110'),
	('Switch','Nintendo','20170303'),
GO

INSERT INTO Regions(region_name, region_abbreviation)
VALUES
	('South Africa', 'RSA')
GO

INSERT INTO dbo.Runners(region_id, runner_name, date_started, is_banned)
VALUES
	(1,'daned', '20100101',0),
	(1,'daniels', '20110101',0),
	(1,'charon', '20120101',0),
	(1,'danielh', '20130101',0)
GO

INSERT INTO dbo.Games(game_name, developer, publisher)
VALUES
	('Witcher 3','CD Projekt','CD Projekt'),
	('GTAV','Rockstar North','Rockstar Games')
GO

INSERT INTO dbo.Game_Categories(game_id, category_id)
VALUES
	(1,1),
	(2,1)
GO

INSERT INTO dbo.Game_Genres(game_id, genre_id)
VALUES
	(1,5),
	(2,5),
	(2,2)
GO

INSERT INTO dbo.Game_Platforms(game_id, platform_id)
VALUES
	(1,1),
	(1,2),
	(1,3),
	(1,4),
	(2,1),
	(2,2),
	(2,4)
GO
