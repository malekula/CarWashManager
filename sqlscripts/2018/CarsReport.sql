USE [CWM]
GO
/****** Object:  UserDefinedFunction [dbo].[EditJob]    Script Date: 03/27/2018 10:55:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter FUNCTION [dbo].[CarsReport] (@date1 datetime, @date2 datetime)
RETURNS @ret table
(
num int,CAR nvarchar(max),PLATE nvarchar(max),
T nvarchar(max),EMP nvarchar(max),Jservices nvarchar(max),COST nvarchar(max)
)
WITH EXECUTE AS CALLER
AS
BEGIN

with FC as(
select 
C.CNAME CAR
,J.NPLATE PLATE
,CONVERT(varchar, J.JOBDATE, 104) +' '+CONVERT(VARCHAR(5), J.JOBDATE, 114) as T
,E.ENAME EMP
,(select PNAME+' ('+cast(B.COST as varchar)+' р.)'+'; ' as 'data()'  
from CWM..PACKAGE A
left join CWM..PRICELIST B on A.IDPRICE = B.ID
where A.IDJOB = P.IDJOB  for xml path('')
) as Jservices
,cast(J.TOTALCOST as varchar) + ' р.' COST
 from CWM..JOB J
left join CWM..EMPLOYEE E  on J.IDEMP = E.ID
left join CWM..PACKAGE P on J.ID = P.IDJOB
left join CWM..CAR C on C.ID = J.IDCAR
where cast(cast(J.JOBDATE as varchar(11)) as DATETIME) between @date1 and @date2
)
,
FD as (
select distinct *
from FC
)
insert into @ret
select row_number() over (order by T) num, *
from FD

return
END;

--select * from CWM..[CarsReport]('20180327','20180327');