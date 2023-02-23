SELECT platform_name, Number_Of_Runs FROM (
SELECT platform_id,COUNT(*) AS Number_Of_Runs FROM dbo.Runs
WHERE validity=1 AND game_id=1
GROUP BY platform_id) AS countTbl INNER JOIN dbo.Platforms ON countTbl.platform_id = dbo.Platforms.platform_id;