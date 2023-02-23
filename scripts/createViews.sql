USE SpeedRunnerDB
GO

CREATE OR ALTER VIEW Top_Runner
AS
SELECT DISTINCT game_name = FIRST_VALUE(game_name) OVER (PARTITION BY dbo.Runs.category_id ORDER BY run_time ASC),
runner_name,
category_name,
run_time,
video_link,
case when validity=1 then 'true' 
           else 'false' 
           end as validity
FROM dbo.Runs INNER JOIN dbo.Games ON Runs.game_id = Games.game_id INNER JOIN dbo.Categories ON Runs.category_id = Categories.category_id
	INNER JOIN dbo.Runners on Runs.runner_id = Runners.runner_id
WHERE Runs.deleted = 0

GO