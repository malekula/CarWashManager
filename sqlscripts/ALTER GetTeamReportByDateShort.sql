USE [CWM]
GO
/****** Object:  UserDefinedFunction [dbo].[GetTeamReportByDateShort]    Script Date: 05/25/2012 13:48:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[GetTeamReportByDateShort] (@start datetime,@end datetime)
RETURNS @ret table
(
ide int, nm nvarchar(400),cost int,cnt int
)
WITH EXECUTE AS CALLER
AS
BEGIN
with 
 gen as(
select B.ID ide,(case when B.DELETED = 1 then B.ENAME+' (уволен)' else B.ENAME end) dt,sum(D.COST) cst,count(A.ID) dts
from CWM..PACKAGE D
left join CWM..JOB A on D.IDJOB = A.ID and cast(cast(A.JOBDATE as varchar(11)) as DATETIME) between @start and @end
left join CWM..EMPLOYEE B on A.IDEMP = B.ID
where D.DELETED is null
group by B.ENAME,B.ID,B.DELETED
)
insert into @ret
select ide,dt,sum(cst),sum(dts) cnt from gen
group by dt,ide
return
END;