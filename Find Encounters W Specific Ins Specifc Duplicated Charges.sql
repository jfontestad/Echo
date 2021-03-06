/****** Script for SelectTopNRows command from SSMS  ******/

SELECT CAST(A.[PA-PT-NO-WOSCD] as varchar) + CAST(A.[pa-pt-no-scd-1] as varchar) as 'Patient_Control_Account#',
[pa-dtl-gl-no] as 'Department_Code',
--b.[pa-ins-co-cd],
--b.[pa-ins-plan-no],
--[pa-dtl-type-ind],
CAST([pa-dtl-svc-cd-woscd] as varchar) + CAST([pa-dtl-svc-cd-scd] as varchar) as 'Service_Code',
[pa-dtl-technical-desc] as 'Serivce_Code_Description',
[pa-dtl-date] as 'Date_Of_Service',
--[pa-dtl-post-date] as 'Posting_Date',
SUM([pa-dtl-chg-qty]) as 'Charge_Quantity',
SUM([pa-dtl-chg-amt]) as 'Charge_Amount'
 
 FROM [Echo_Active].[dbo].[DetailInformation] a left outer join [Echo_Active].[dbo].[InsuranceInformation] b
 ON a.[pa-pt-no-woscd]=b.[pa-pt-no-woscd] AND b.[pa-ins-prty]='1'


WHERE --[pa-dtl-type-ind]='8'
[pa-dtl-chg-amt] <> '0'
AND [pa-dtl-date] > '2014-12-31 23:59:59.000'
--AND b.[pa-ins-co-cd]='M'
--AND a.[pa-dtl-rev-cd] IN ('810','811','812','813')
--AND a.[pa-dtl-hosp-svc]='RTR'
--AND a.[pa-dtl-gl-no]='741'
--AND b.[pa-hosp-cd]='RTR'
AND a.[pa-dtl-gl-no] IN ('382','788')
 --AND a.[pa-dtl-svc-cd-woscd] = '4910422'

 GROUP BY CAST(A.[PA-PT-NO-WOSCD] as varchar) + CAST(A.[pa-pt-no-scd-1] as varchar) ,
[pa-dtl-gl-no] ,
--b.[pa-ins-co-cd],
--b.[pa-ins-plan-no],
--[pa-dtl-type-ind],
CAST([pa-dtl-svc-cd-woscd] as varchar) + CAST([pa-dtl-svc-cd-scd] as varchar) ,
[pa-dtl-technical-desc] ,
[pa-dtl-date] 
 --AND a.[pa-pt-no-woscd] IN
  HAVING SUM([pa-dtl-chg-qty]) > '1'
 --(
 --SELECT DISTINCT([pa-pt-no-woscd])
 --FROM [Echo_Active].dbo.DetailInformation
 --WHERE [pa-dtl-svc-cd-woscd] IN ('4730002')
 --AND [pa-dtl-date] BETWEEN '2015-01-01 00:00:00.000' AND '2017-06-01 23:59:59.000'
 --)

 UNION

 SELECT CAST(A.[PA-PT-NO-WOSCD] as varchar) + CAST(A.[pa-pt-no-scd-1] as varchar) as 'Patient_Control_Account#',
[pa-dtl-gl-no] as 'Department_Code',
--b.[pa-ins-co-cd],
--b.[pa-ins-plan-no],
--[pa-dtl-type-ind],
CAST([pa-dtl-svc-cd-woscd] as varchar) + CAST([pa-dtl-svc-cd-scd] as varchar) as 'Service_Code',
[pa-dtl-technical-desc] as 'Serivce_Code_Description',
[pa-dtl-date] as 'Date_Of_Service',
--[pa-dtl-post-date] as 'Posting_Date',
SUM([pa-dtl-chg-qty]) as 'Charge_Quantity',
SUM([pa-dtl-chg-amt]) as 'Charge_Amount'
 
 FROM [Echo_Archive].[dbo].[DetailInformation] a left outer join [Echo_Archive].[dbo].[InsuranceInformation] b
 ON a.[pa-pt-no-woscd]=b.[pa-pt-no-woscd] AND b.[pa-ins-prty]='1'


 WHERE --[pa-dtl-type-ind]='8'
[pa-dtl-chg-amt] <> '0'
 AND [pa-dtl-date] > '2014-12-31 23:59:59.000'
 --AND b.[pa-ins-co-cd]='M'
-- AND a.[pa-dtl-rev-cd] IN ('810','811','812','813')
 --AND a.[pa-dtl-hosp-svc]='RTR'
 --AND a.[pa-dtl-gl-no]='741'
 --AND b.[pa-hosp-cd]='RTR'
 AND a.[pa-dtl-gl-no] IN ('382','788')
 --AND a.[pa-dtl-svc-cd-woscd] = '4910422'
 --AND a.[pa-pt-no-woscd] IN
 GROUP BY CAST(A.[PA-PT-NO-WOSCD] as varchar) + CAST(A.[pa-pt-no-scd-1] as varchar) ,
[pa-dtl-gl-no] ,
--b.[pa-ins-co-cd],
--b.[pa-ins-plan-no],
--[pa-dtl-type-ind],
CAST([pa-dtl-svc-cd-woscd] as varchar) + CAST([pa-dtl-svc-cd-scd] as varchar) ,
[pa-dtl-technical-desc] ,
[pa-dtl-date] 
 --(
 --SELECT DISTINCT([pa-pt-no-woscd])
 --FROM [Echo_Archive].dbo.DetailInformation
 --WHERE [pa-dtl-svc-cd-woscd] IN ('4730001')
 --AND [pa-dtl-date] BETWEEN '2015-01-01 00:00:00.000' AND '2017-06-01 23:59:59.000'
 --)

 HAVING SUM([pa-dtl-chg-qty]) > '1'


 --ORDER BY CAST(A.[PA-PT-NO-WOSCD] as varchar) + CAST(A.[pa-pt-no-scd-1] as varchar), [pa-dtl-date],[pa-dtl-svc-cd-woscd]