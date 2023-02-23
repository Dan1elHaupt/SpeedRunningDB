use SpeedRunnerDB
go

create or alter function dbo.udfGetFastestRunForGame (
	@game_name varchar(50)
)
returns @ReturnTable table(
			runner_name varchar(50),
			run_time int,
			video_link varchar(100)
		)
as
	begin
		insert into @ReturnTable
		select top 1 
			runner_name,
			run_time,
			video_link
			from Runs INNER JOIN Runners on Runs.runner_id = Runners.runner_id INNER JOIN Games on Runs.game_id = Games.game_id
			where Games.game_name = @game_name AND Runs.is_valid = 1 AND Runs.deleted = 0
			order by run_time
		
		return
	end
go