/****** Script for SelectTopNRows command from SSMS  ******/

SELECT CAST(A.[PA-PT-NO-WOSCD] as varchar) + CAST(A.[pa-pt-no-scd-1] as varchar) as 'Patient_Control_Account#',
[pa-dtl-gl-no] as 'Department_Code',
--[pa-dtl-type-ind],
CAST([pa-dtl-svc-cd-woscd] as varchar) + CAST([pa-dtl-svc-cd-scd] as varchar) as 'Service_Code',
[pa-dtl-technical-desc] as 'Serivce_Code_Description',
[pa-dtl-date] as 'Date_Of_Service',
[pa-dtl-post-date] as 'Posting_Date',
[pa-dtl-chg-qty] as 'Charge_Quantity',
[pa-dtl-chg-amt] as 'Charge_Amount',
b.[pa-bfw-chg-tot]
 
 FROM [Echo_Active].[dbo].[DetailInformation] a left join [Echo_Active].[dbo].[PatientDemographics] b
 ON a.[pa-pt-no-woscd]=b.[pa-pt-no-woscd] 


 WHERE [pa-dtl-type-ind] in ('8','A','7','B')
 AND [pa-dtl-chg-amt] <> '0'
 and a.[pa-pt-no-woscd] = '1009727330'
 --AND a.[pa-pt-no-woscd] IN

 --(
 --SELECT DISTINCT([pa-pt-no-woscd])
 --FROM [Echo_Active].dbo.DetailInformation
 --WHERE [pa-dtl-gl-no] IN ('386','431','771','481')
 --AND [pa-dtl-date] BETWEEN '2016-11-01 00:00:00.000' AND '2017-04-30 23:59:59.000'
 --)

 UNION

 SELECT CAST(A.[PA-PT-NO-WOSCD] as varchar) + CAST(A.[pa-pt-no-scd-1] as varchar) as 'Patient_Control_Account#',
[pa-dtl-gl-no] as 'Department_Code',
--[pa-dtl-type-ind],
CAST([pa-dtl-svc-cd-woscd] as varchar) + CAST([pa-dtl-svc-cd-scd] as varchar) as 'Service_Code',
[pa-dtl-technical-desc] as 'Serivce_Code_Description',
[pa-dtl-date] as 'Date_Of_Service',
[pa-dtl-post-date] as 'Posting_Date',
[pa-dtl-chg-qty] as 'Charge_Quantity',
[pa-dtl-chg-amt] as 'Charge_Amount',
b.[pa-bfw-chg-tot]
 
 FROM [Echo_Active].[dbo].[DetailInformation] a left join [Echo_Active].[dbo].[PatientDemographics] b
 ON a.[pa-pt-no-woscd]=b.[pa-pt-no-woscd] 


 WHERE [pa-dtl-type-ind] IN ('8','A','7','B')
 AND [pa-dtl-chg-amt] <> '0'
 and a.[pa-pt-no-woscd] = '1009727330'
 --AND a.[pa-pt-no-woscd] IN

 --(
 --SELECT DISTINCT([pa-pt-no-woscd])
 --FROM [Echo_Archive].dbo.DetailInformation
 --WHERE [pa-dtl-gl-no] IN ('386','431','771','481')
 --AND [pa-dtl-date] BETWEEN '2016-11-01 00:00:00.000' AND '2017-04-30 23:59:59.000'
 --)




 --ORDER BY CAST(A.[PA-PT-NO-WOSCD] as varchar) + CAST(A.[pa-pt-no-scd-1] as varchar), [pa-dtl-date],[pa-dtl-svc-cd-woscd]