USE [CWM]
GO
/****** Object:  UserDefinedFunction [dbo].[GetAddServReportAllTime]    Script Date: 11/16/2014 16:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER FUNCTION [dbo].[GetAddServReportAllTime] ()
RETURNS @ret table
(
nm nvarchar(300),cnt int,cost int
)
WITH EXECUTE AS CALLER
AS
BEGIN
with 
 gen as(
select C.ASNAME nm,count(C.ASNAME) cnt,
sum(case when A.PLUS_50 = 1 then C.COST else C.COST+C.COST/2 end) cost
from CWM..PACKAGEADDSERV D
left join CWM..JOB A on D.IDJOB = A.ID --and cast(cast(A.JOBDATE as varchar(11)) as DATETIME) between @start and @end
left join CWM..ADDITIONALSERVICE C on C.ID = D.IDADDSERV
where D.DELETED is null
group by C.ASNAME
)

insert into @ret
select * from gen
order by nm

return
END;

