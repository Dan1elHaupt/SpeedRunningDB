USE master
GO

IF EXISTS(select * from sys.databases where name='SpeedRunnerDB')
DROP DATABASE SpeedRunnerDB

CREATE DATABASE SpeedRunnerDB;
GO

use SpeedRunnerDB;
go



--------------------------------------------------------------------CREATE TABLES--------------------------------------------------------------------



create table dbo.Regions (
	region_id int identity(1,1) not null,
	region_name varchar(56) not null,
	region_abbreviation varchar(3) not null,
	CONSTRAINT [PK_Regions] PRIMARY KEY CLUSTERED (
		region_id ASC
	)
)
go

create table dbo.Runners (
	runner_id int identity(1,1) not null,
	region_id int foreign key references dbo.Regions(region_id) not null,
	runner_name nvarchar(60) not null,
	date_started date not null,
	is_banned bit not null,
	CONSTRAINT [PK_Actors] PRIMARY KEY CLUSTERED (
		runner_id ASC
	)
)
go

create table dbo.Games (
	game_id int identity(1,1) not null,
	game_name nvarchar(120) not null,
	developer nvarchar(120) not null,
	publisher nvarchar(120) not null,
	CONSTRAINT [PK_Games] PRIMARY KEY CLUSTERED (
		game_id ASC
	),
	CONSTRAINT AK_game_name UNIQUE(game_name)
)
go

create table dbo.Genres (
	genre_id int identity(1,1) not null,
	genre_name varchar(30) not null,
	CONSTRAINT [PK_Genres] PRIMARY KEY CLUSTERED (
		genre_id ASC
	)
)
go

create table dbo.Categories (
	category_id int identity(1,1) not null,
	category_name nvarchar(60) not null,
	date_created date not null,
	CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED (
		category_id ASC
	)
)
go

create table dbo.Platforms (
	platform_id int identity(1,1) not null,
	platform_name varchar(20) not null,
	company varchar(30),
	release_date date,
	CONSTRAINT [PK_Platforms] PRIMARY KEY CLUSTERED (
		platform_id ASC
	)
)
go

create table dbo.Game_Genres (
	game_id int foreign key references dbo.Games(game_id) not null,
	genre_id int foreign key references dbo.Genres(genre_id) not null
)
go

create table dbo.Game_Categories (
	game_id int foreign key references dbo.Games(game_id) not null,
	category_id int foreign key references dbo.Categories(category_id) not null
)
go

create table dbo.Game_Platforms (
	game_id int foreign key references dbo.Games(game_id) not null,
	platform_id int foreign key references dbo.Platforms(platform_id) not null
)
go

create table dbo.Runs (
	run_id int identity(1,1) not null,
	runner_id int foreign key references dbo.Runners(runner_id) not null,
	game_id int foreign key references dbo.Games(game_id) not null,
	category_id int foreign key references dbo.Categories(category_id) not null,
	platform_id int foreign key references dbo.Platforms(platform_id) not null,
	region_id int foreign key references dbo.Regions(region_id) not null,
	run_time int not null,
	in_game_time int,
	game_version varchar(50),
	date_posted datetime not null,
	video_link varchar(100),
	is_valid bit,
	CONSTRAINT [PK_Runs] PRIMARY KEY CLUSTERED (
		run_id ASC
	)
)
go

create table dbo.Skips (
	skip_id int identity(1,1) not null,
	game_id int foreign key references dbo.Games(game_id) not null,
	skip_name nvarchar(120) not null,
	skip_description nvarchar(600),
	date_created date not null,
	CONSTRAINT [PK_Skips] PRIMARY KEY CLUSTERED (
		skip_id ASC
	)
)
go



-------------------------------------------------------------------- INSERT DUMMY DATA --------------------------------------------------------------------



insert into dbo.Categories(category_name, date_created)
values
	('100%','20100101')
go

insert into dbo.Genres(genre_name)
values
	('Sandbox'),
	('Shooter'),
	('Real-time strategy'),
	('MOBA'),
	('RPG'),
	('Sports'),
	('Simulation')
go

insert into dbo.Platforms(platform_name, company, release_date)
values
	('PS5','Sony','20201112'),
	('XboxSeriesX','Microsoft','20201110'),
	('Switch','Nintendo','20170303'),
	('PC',null,null)
go

insert into Regions(region_name, region_abbreviation)
values
	('South Africa', 'RSA')
go

insert into dbo.Runners(region_id, runner_name, date_started, is_banned)
values
	(1,'daned', '20100101',0),
	(1,'daniels', '20110101',0),
	(1,'charon', '20120101',0),
	(1,'danielh', '20130101',0)
go

insert into dbo.Games(game_name, developer, publisher)
values
	('Witcher 3','CD Projekt','CD Projekt'),
	('GTAV','Rockstar North','Rockstar Games')
go

insert into dbo.Game_Categories(game_id, category_id)
values
	(1,1),
	(2,1)
go

insert into dbo.Game_Genres(game_id, genre_id)
values
	(1,5),
	(2,5),
	(2,2)
go

insert into dbo.Game_Platforms(game_id, platform_id)
values
	(1,1),
	(1,2),
	(1,3),
	(1,4),
	(2,1),
	(2,2),
	(2,4)
go
