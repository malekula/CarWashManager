USE [CWM]
GO
/****** Object:  UserDefinedFunction [dbo].[GetGeneralReportAllTime]    Script Date: 06/17/2012 20:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[GetGeneralReportAllTime] ()
RETURNS @ret table
(
dt datetime,cost int
)
WITH EXECUTE AS CALLER
AS
BEGIN
with 
 gen as(
select A.JOBDATE dt,D.COST cost
from CWM..PACKAGE D
left join CWM..JOB A on D.IDJOB = A.ID
where D.DELETED is null
)
insert into @ret
select * from gen
return
END;