SELECT game_name, Number_Of_Runs FROM (
SELECT game_id,COUNT(*) AS Number_Of_Runs FROM dbo.Runs
WHERE validity=1
GROUP BY game_id) AS countTbl INNER JOIN dbo.Games ON countTbl.game_id = dbo.Games.game_id;