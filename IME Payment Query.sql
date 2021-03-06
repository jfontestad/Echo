/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [PA-PT-NO-WOSCD]
      ,[PA-PT-NO-SCD-1]
      ,[PA-ACCT-TYPE]
      ,[PA-ACCT-SUB-TYPE]
      ,[PA-REC-CREATE-DATE]
	  ,[PA-DTL-DATE]
      ,[PA-DTL-INS-CD]
      ,[PA-DTL-SVC-CD-WOSCD]
	  ,[pa-dtl-svc-cd-scd]
      ,[PA-DTL-POST-DATE]
      ,[PA-DTL-SVC-CD-SCD]
      ,[PA-DTL-CHG-AMT]
      ,[PA-DTL-CHG-QTY]
      ,[PA-DTL-INS-CO-CD]
      ,[PA-DTL-INS-PLAN-NO]
      ,[PA-DTL-DESCRIPTION]
      ,[PA-DTL-TECHNICAL-DESC]
      ,[PA-DTL-GL-NO]
      ,[PA-DTL-SEG-CREATE-DATE]
      ,[PA-DTL-FC]
      ,[PA-DTL-CDM-DESCRIPTION]
     
     
  FROM [Echo_Active].[dbo].[DetailInformation]

  WHERE [pa-dtl-date] > '2014-12-31 00:00:00.000'

  and [pa-pt-no-woscd]='99999000006'
  and [PA-DTL-SVC-CD-WOSCD]='13446'


  ORDER BY [pa-dtl-date]