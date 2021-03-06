/****** Script for SelectTopNRows command from SSMS  ******/

SELECT CAST(A.[PA-PT-NO-WOSCD] as varchar) + CAST(A.[pa-pt-no-scd-1] as varchar) as 'Patient_Control_Account#',
[pa-dtl-gl-no] as 'Department_Code',
b.[pa-ins-co-cd],
b.[pa-ins-plan-no],
[pa-dtl-type-ind],
CAST([pa-dtl-svc-cd-woscd] as varchar) + CAST([pa-dtl-svc-cd-scd] as varchar) as 'Service_Code',
[pa-dtl-technical-desc] as 'Serivce_Code_Description',
[pa-dtl-date] as 'Date_Of_Service',
[pa-dtl-post-date] as 'Posting_Date',
[pa-dtl-chg-qty] as 'Charge_Quantity',
[pa-dtl-chg-amt] as 'Charge_Amount',
(CAST(ISNULL(b.[pa-bal-ins-pay-amt],0) as money) + CAST(ISNULL(c.[pa-bal-ins-pay-amt],0) as money) + CAST(ISNULL(d.[pa-bal-ins-pay-amt],0) as money) + CAST(ISNULL(e.[pa-bal-ins-pay-amt],0) as money))+ CAST(ISNULL(f.[pa-bal-tot-pt-pay-amt],0) as money) as 'Tot_Pay_Amt'

 
 FROM [Echo_Active].[dbo].[DetailInformation] a left outer join [Echo_Active].[dbo].[InsuranceInformation] b
 ON a.[pa-pt-no-woscd]=b.[pa-pt-no-woscd] AND b.[pa-ins-prty]='1'
 left outer join [Echo_Active].[dbo].[InsuranceInformation] c
 ON a.[pa-pt-no-woscd]=c.[pa-pt-no-woscd] and c.[pa-ins-prty]='2'
 left outer join [Echo_Active].[dbo].[InsuranceInformation] d
 ON a.[pa-pt-no-woscd]=d.[pa-pt-no-woscd] and d.[pa-ins-prty]='3'
 left outer join [Echo_Active].[dbo].[InsuranceInformation] e
 ON a.[pa-pt-no-woscd]=e.[pa-pt-no-woscd] and e.[pa-ins-prty]='4'
 left outer join [Echo_Active].[dbo].[PatientDemographics] f
 ON a.[pa-pt-no-woscd]=f.[pa-pt-no-woscd] 

WHERE [pa-dtl-type-ind] IN ('8','A','7','B')
AND [pa-dtl-chg-amt] <> '0'
and a.[pa-acct-type]='0'
--AND b.[pa-ins-co-cd]='M'
--AND a.[pa-dtl-rev-cd] IN ('810','811','812','813')
AND a.[pa-dtl-date] BETWEEN '2017-01-01 00:00:00.000' AND '2017-06-30 23:59:59.000'
--AND a.[pa-dtl-hosp-svc]='RTR'
--AND a.[pa-dtl-gl-no]='741'
--AND b.[pa-hosp-cd]='RTR'

 AND a.[pa-dtl-svc-cd-woscd] = '3711784'
 --AND a.[pa-pt-no-woscd] IN

 --(
 --SELECT DISTINCT([pa-pt-no-woscd])
 --FROM [Echo_Active].dbo.DetailInformation
 --WHERE [pa-dtl-svc-cd-woscd] IN ('4730002')
 --AND [pa-dtl-date] BETWEEN '2015-01-01 00:00:00.000' AND '2017-06-01 23:59:59.000'
 --)




 UNION

 SELECT CAST(A.[PA-PT-NO-WOSCD] as varchar) + CAST(A.[pa-pt-no-scd-1] as varchar) as 'Patient_Control_Account#',
[pa-dtl-gl-no] as 'Department_Code',
b.[pa-ins-co-cd],
b.[pa-ins-plan-no],
[pa-dtl-type-ind],
CAST([pa-dtl-svc-cd-woscd] as varchar) + CAST([pa-dtl-svc-cd-scd] as varchar) as 'Service_Code',
[pa-dtl-technical-desc] as 'Serivce_Code_Description',
[pa-dtl-date] as 'Date_Of_Service',
[pa-dtl-post-date] as 'Posting_Date',
[pa-dtl-chg-qty] as 'Charge_Quantity',
[pa-dtl-chg-amt] as 'Charge_Amount',
(CAST(ISNULL(b.[pa-bal-ins-pay-amt],0) as money) + CAST(ISNULL(c.[pa-bal-ins-pay-amt],0) as money) + CAST(ISNULL(d.[pa-bal-ins-pay-amt],0) as money) + CAST(ISNULL(e.[pa-bal-ins-pay-amt],0) as money))+ CAST(ISNULL(f.[pa-bal-tot-pt-pay-amt],0) as money) as 'Tot_Pay_Amt'

 
 FROM [Echo_Archive].[dbo].[DetailInformation] a left outer join [Echo_Archive].[dbo].[InsuranceInformation] b
 ON a.[pa-pt-no-woscd]=b.[pa-pt-no-woscd] AND b.[pa-ins-prty]='1'
 left outer join [Echo_Archive].[dbo].[InsuranceInformation] c
 ON a.[pa-pt-no-woscd]=c.[pa-pt-no-woscd] and c.[pa-ins-prty]='2'
 left outer join [Echo_Archive].[dbo].[InsuranceInformation] d
 ON a.[pa-pt-no-woscd]=d.[pa-pt-no-woscd] and d.[pa-ins-prty]='3'
 left outer join [Echo_Archive].[dbo].[InsuranceInformation] e
 ON a.[pa-pt-no-woscd]=e.[pa-pt-no-woscd] and e.[pa-ins-prty]='4'
 left outer join [Echo_Archive].[dbo].[PatientDemographics] f
 ON a.[pa-pt-no-woscd]=f.[pa-pt-no-woscd] 


 WHERE [pa-dtl-type-ind] IN ('8','A','7','B')
 AND [pa-dtl-chg-amt] <> '0'
 and a.[pa-acct-type]='0'
 --AND b.[pa-ins-co-cd]='M'
 --AND a.[pa-dtl-rev-cd] IN ('810','811','812','813')
 AND a.[pa-dtl-date] BETWEEN '2017-01-01 00:00:00.000' AND '2017-06-30 23:59:59.000'
 --AND a.[pa-dtl-hosp-svc]='RTR'
 --AND a.[pa-dtl-gl-no]='741'
 --AND b.[pa-hosp-cd]='RTR'
 AND a.[pa-dtl-svc-cd-woscd] = '3711784'
 --AND a.[pa-pt-no-woscd] IN

 --(
 --SELECT DISTINCT([pa-pt-no-woscd])
 --FROM [Echo_Archive].dbo.DetailInformation
 --WHERE [pa-dtl-svc-cd-woscd] IN ('4730001')
 --AND [pa-dtl-date] BETWEEN '2015-01-01 00:00:00.000' AND '2017-06-01 23:59:59.000'
 --)




 --ORDER BY CAST(A.[PA-PT-NO-WOSCD] as varchar) + CAST(A.[pa-pt-no-scd-1] as varchar), [pa-dtl-date],[pa-dtl-svc-cd-woscd]