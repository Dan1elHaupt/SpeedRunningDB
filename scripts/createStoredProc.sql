USE SpeedRunnerDB
GO

CREATE or ALTER procedure dbo.uspInsertNewGame (
@game_name nvarchar(120),
@developer nvarchar(120),
@publisher nvarchar(120),
@genre_name varchar(30),
@category_name nvarchar(60),
@category_date_created varchar(8),
@platform_name varchar(20),
@platform_company varchar(30),
@platform_release_date varchar(8)
)
AS
BEGIN TRANSACTION InsertGame
	BEGIN TRY
		DECLARE @game_id int
		DECLARE @genre_id int
		DECLARE @category_id int
		DECLARE @platform_id int


		-- Insert new genre
		begin
		IF NOT EXISTS (SELECT * FROM dbo.Genres WHERE genre_name = @genre_name)
		INSERT INTO dbo.Genres(genre_name)
		VALUES	(@genre_name)
		end


		begin
		-- Insert new category
		IF NOT EXISTS (SELECT * FROM dbo.Categories WHERE category_name = @category_name)
		INSERT INTO dbo.Categories(category_name, date_CREATEd)
		VALUES	(@category_name,@category_date_created)
		end


		begin
		-- Insert new platform
		IF NOT EXISTS (SELECT * FROM dbo.Platforms WHERE platform_name = @platform_name)
		INSERT INTO dbo.Platforms(platform_name, company, release_date)
		VALUES (@platform_name, @platform_company, @platform_release_date)
		end


		-- Get ids of existing entries
		SELECT @genre_id = genre_id FROM dbo.Genres WHERE genre_name = @genre_name
		SELECT @category_id = category_id FROM dbo.Categories WHERE category_name = @category_name
		SELECT @platform_id = platform_id FROM dbo.Platforms WHERE platform_name = @platform_name


		-- Insert new game
		IF NOT EXISTS (SELECT * FROM dbo.Games WHERE game_name = @game_name)
		INSERT INTO dbo.Games(game_name, developer, publisher)
		VALUES	(@game_name, @developer, @publisher)

		SELECT @game_id = game_id FROM dbo.Games WHERE game_name = @game_name
		

		-- Insert new platform-game link
		INSERT INTO dbo.Game_Platforms(game_id, platform_id)
		VALUES	(@game_id, @platform_id)


		-- Insert new genre-game link
		INSERT INTO dbo.Game_Genres(game_id, genre_id)
		VALUES	(@game_id, @genre_id)


		-- Insert new category-game link
		INSERT INTO dbo.Game_Categories(game_id, category_id)
		VALUES	(@game_id, @category_id)

		COMMIT

	END TRY
	BEGIN CATCH
		ROLLBACK;
	END CATCH

GO

CREATE or ALTER procedure dbo.uspDeleteRunner (
@runner_name nvarchar(60)
)
AS
BEGIN TRANSACTION DeleteRunner
	BEGIN TRY
		DECLARE @runner_id int

		SELECT @runner_id = runner_id FROM dbo.Runners WHERE runner_name = @runner_name

		UPDATE dbo.Runners SET deleted = 1 WHERE runner_id = @runner_id

		COMMIT

	END TRY
	BEGIN CATCH
		ROLLBACK;
	END CATCH

GO

CREATE or ALTER procedure dbo.uspDeleteRun (
@run_id int
)
AS
BEGIN TRANSACTION DeleteRun
	BEGIN TRY
		
		UPDATE dbo.Runs SET deleted = 1 WHERE run_id = @run_id

		COMMIT

	END TRY
	BEGIN CATCH
		ROLLBACK;
	END CATCH

GO
