use SpeedRunnerDB
GO

create or alter procedure dbo.uspInsertNewGame (
@game_name nvarchar(120),
@developer nvarchar(120),
@publisher nvarchar(120),
@genre_name varchar(30),
@category_name nvarchar(60),
@category_date_created varchar(8),
@platform_name varchar(20),
@platform_company varchar(30),
@platform_release_date date
)
AS
BEGIN TRANSACTION InsertGame
	BEGIN TRY
		declare @game_id int
		declare @genre_id int
		declare @category_id int
		declare @platform_id int


		-- Insert new genre
		begin
		IF NOT EXISTS (SELECT * FROM dbo.Genres WHERE genre_name = @genre_name)
		INSERT INTO dbo.Genres(genre_name)
		VALUES	(@genre_name)
		end


		begin
		-- Insert new category
		IF NOT EXISTS (SELECT * FROM dbo.Categories WHERE category_name = @category_name)
		INSERT INTO dbo.Categories(category_name, date_created)
		VALUES	(@category_name,@category_date_created)
		end


		begin
		-- Insert new platform
		IF NOT EXISTS (SELECT * FROM dbo.Platforms WHERE platform_name = @platform_name)
		INSERT INTO dbo.Platforms(platform_name, company, release_date)
		VALUES (@platform_name, @platform_company, @platform_release_date)
		end


		-- Get ids of existing entries
		select @genre_id = genre_id from dbo.Genres where genre_name = @genre_name
		select @category_id = category_id from dbo.Categories where category_name = @category_name
		select @platform_id = platform_id from dbo.Platforms where platform_name = @platform_name


		-- Insert new game
		insert into dbo.Games(game_name, developer, publisher)
		values	(@game_name, @developer, @publisher)

		select @game_id = game_id from dbo.Games where game_name = @game_name
		

		-- Insert new platform-game link
		insert into dbo.Game_Platforms(game_id, platform_id)
		values	(@game_id, @platform_id)


		-- Insert new genre-game link
		insert into dbo.Game_Genres(game_id, genre_id)
		values	(@game_id, @genre_id)


		-- Insert new category-game link
		insert into dbo.Game_Categories(game_id, category_id)
		values	(@game_id, @category_id)

		COMMIT

	END TRY
	BEGIN CATCH
		ROLLBACK;
	END CATCH

GO