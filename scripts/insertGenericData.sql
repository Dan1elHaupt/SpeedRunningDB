USE SpeedRunnerDB;
GO

-------------------------------------------------------------------- INSERT DUMMY DATA --------------------------------------------------------------------



INSERT INTO dbo.Categories(category_name, date_created)
VALUES
	('Any%','20100101'),
	('Segments', '20141112'),
	('Hearts of Stone', '20170706')
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
	('Switch','Nintendo','20170303')
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
	(1,2),
	(2,1),
	(2,3)
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

INSERT INTO dbo.Administrators(admin_name)
VALUES
	('not verified'),
	('Bob@admin.com'),
	('John@admin.com')
GO