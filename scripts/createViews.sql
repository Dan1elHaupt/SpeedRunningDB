USE SpeedRunnerDB
GO

CREATE OR ALTER VIEW Top_Runner AS

WITH CTE AS(
SELECT runner_id,region_id,category_id,game_id,run_time, ROW_NUMBER() OVER (PARTITION BY category_id,game_id ORDER BY run_time ASC) AS rn
FROM dbo.Runs WHERE validity = 1 group by category_id,game_id ,run_time,runner_id,region_id),

CTE2 as(
SELECT r.runner_name,n.region_name,t.category_name,g.game_name,(run_time/360) as run_time_hours , run_time as run_time_seconds ,rn FROM CTE
inner join Categories as t on t.category_id = CTE.category_id
inner join Games as g on g.game_id = CTE.game_id
inner join Runners as r on r.runner_id = CTE.runner_id
inner join Regions as n on n.region_id = CTE.region_id
)

SELECT runner_name,region_name,category_name,game_name,run_time_hours,run_time_seconds FROM CTE2 WHERE rn = 1

GO