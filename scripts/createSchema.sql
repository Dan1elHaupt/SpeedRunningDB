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

CREATE TABLE dbo.Administrators (
	administrator_id int identity(1,1) NOT NULL,
	admin_name nvarchar(60),
	CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED (
		administrator_id ASC
	)
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
	validity tinyint NOT NULL,
	verified_by int foreign key references dbo.Administrators(administrator_id) NOT NULL,
	CONSTRAINT [PK_Run] PRIMARY KEY CLUSTERED (
		run_id ASC
	)
)
GO
