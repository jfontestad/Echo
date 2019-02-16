
----------------------------------------------------------------------------------------------------------------------------------------------------
/*Create Temp Table W Last Active Ins Plan Based Upon MRN Match*/
IF OBJECT_ID('tempdb.dbo.#LastActiveIns','U') IS NOT NULL
DROP TABLE #LastActiveIns;
GO

CREATE TABLE #LastActiveIns

(
[PA-MED-REC-NO] CHAR(20) NOT NULL,
[PA-INS-CD] CHAR(6) NULL,
[PA-LAST-INS-PAY-DATE] DATETIME NULL,
[PA-BAL-INS-PAY-AMT] MONEY NULL,
[INSURED-ENCOUNTER] CHAR(20),
[INS-RANK] CHAR(15) NULL
);

INSERT INTO #LastActiveIns([pa-med-rec-no],[pa-ins-cd],[pa-last-ins-pay-date],[pa-bal-ins-pay-amt],[insured-encounter],[ins-rank])




SELECT [pa-med-rec-no],
[PA-INS-CD],
[pa-last-ins-pay-date],
[pa-bal-ins-pay-amt],
[INSURED-ENCOUNTER],
RANK() OVER (PARTITION BY [pa-med-rec-no] order by [pa-last-ins-pay-date] desc,[INSURED-ENCOUNTER] asc) as 'INS-RANK' 
FROM
(
SELECT a.[pa-med-rec-no],
b.[pa-ins-co-cd] + CAST(b.[pa-ins-plan-no] as varchar) as 'PA-INS-CD',
b.[pa-last-ins-pay-date],
b.[pa-bal-ins-pay-amt],
CAST(b.[pa-pt-no-woscd] as varchar) + CAST(b.[pa-pt-no-scd-1] as varchar) as 'INSURED-ENCOUNTER'
FROM [Echo_Active].dbo.[PatientDemographics] a left outer join [Echo_Active].dbo.[insuranceinformation]b
ON a.[pa-pt-no-woscd]=b.[pa-pt-no-woscd]
where B.[PA-BAL-INS-PAY-AMT] < '0'

UNION 

SELECT a.[pa-med-rec-no],
b.[pa-ins-co-cd] + CAST(b.[pa-ins-plan-no] as varchar) as 'PA-INS-CD',
b.[pa-last-ins-pay-date],
b.[pa-bal-ins-pay-amt],
CAST(b.[pa-pt-no-woscd] as varchar) + CAST(b.[pa-pt-no-scd-1] as varchar) as 'INSURED-ENCOUNTER'
FROM [Echo_Archive].dbo.[PatientDemographics] a left outer join [Echo_Archive].dbo.[insuranceinformation]b
ON a.[pa-pt-no-woscd]=b.[pa-pt-no-woscd]
where B.[PA-BAL-INS-PAY-AMT] < '0'
) AS TABLEA 
;


select b.[pa-med-rec-no],
CAST(b.[pa-pt-no-woscd] as varchar) + CAST(b.[pa-pt-no-scd-1] as varchar) as 'PA-PT-NO',
b.[pa-pt-name],
b.[pa-bal-tot-chg-amt],
b.[pa-hosp-svc],
b.[pa-pt-type],
b.[pa-unit-sts],
b.[pa-bal-acct-bal],
b.[pa-bal-pt-bal],
b.[pa-bal-tot-pt-pay-amt],
b.[pa-op-first-ins-bl-date],
a.*,
c.*


from dbo.insuranceinformation a left outer join dbo.patientdemographics b
ON a.[pa-pt-no-woscd]=b.[pa-pt-no-woscd] and a.[pa-ins-prty]='1'
left outer join dbo.[#LastActiveIns] c
ON b.[pa-med-rec-no]=c.[pa-med-rec-no] and a.[pa-ins-co-cd] + CAST(a.[pa-ins-plan-no] as varchar) = c.[pa-ins-cd] and c.[ins-rank]='1'


where b.[pa-med-rec-no] IN ('30811390', '30725825', '30808736', '30621157', '30398027', '30771485', '30753764', '30753764', '30278346', '30687624', '30420536', '30121910', '30691957', '30481380', '30522219', '30719606', '30813157', '30786367', '30770746', '30809422', '30667216', '00096613', '30808936', '30741820', '30201068', '30257039', '30662593', '30806174', '30616592', '30794510', '30804710', '30763199', '00129076', '30663828', '30663828', '30663828', '30216860', '30405079', '30790917', '30790917', '30450499', '30747720', '30417935', '30763600', '30123321', '30457081', '30069235', '30668769', '30668769', '30246210', '30197505', '00585310', '30528764', '30206320', '30748046', '30748046', '30622959', '00441479', '30680868', '30591168', '30347120', '30710230', '30467036', '30654377', '30811585', '30619272', '30602156', '30430574', '30430574', '30430574', '30430574', '00057133', '30730599', '30730599', '30730599', '30477929', '30787230', '30807809', '30289802', '30335222', '30685920', '30783452', '30512448', '30639671', '30360161', '30720326', '30615422', '30804778', '30583063', '30449091', '30548478', '30523806', '30735219', '30807179', '00681781', '00274272', '30777725', '30777725', '30641712', '30790818', '30790818', '30796704', '30587315', '30389184', '00080458', '30146324', '30796318', '00198592', '00198592', '00198592', '00077445', '00665886', '30749506', '30795223', '30350675', '30690069', '30013408', '30182116', '30181664', '00223063', '30770733', '00716377', '00251064', '30393712', '30525062', '30384772', '30383459', '00416161', '00577447', '30132147', '30216917', '00452339', '00282847', '30811820', '30639416', '30804096', '30815529', '00016339', '30755398', '30598664', '30567429', '30161003', '30573802', '30573802', '30573802', '30573802', '30105261', '00618665', '00712006', '00075426', '30709444', '30774697', '30056716', '30589982', '30589982', '30651631', '30809218', '30380008', '30766555', '30769052', '30425101', '30803752', '30298316', '30772006', '30228761', '30295285', '00727738', '00674016', '30768215', '00094784', '00094784', '00094784', '00094784', '30559750', '30335113', '30335113', '30335113', '30366654', '00404088', '30598743', '30407373', '30593669', '30723945', '30795774', '00645362', '30620965', '30688940', '30444401', '30732075', '00562947', '30785167', '30544592', '30780882', '30779159', '30770018', '30770018', '30012119', '30451613', '30717179', '30717179', '30501079', '30786788', '30402325', '30396716', '30187201', '30627682', '30627682', '30795678', '30816818', '30734105', '30370839', '00216390', '30396242', '30396242', '30573227', '30573227', '30302874', '30016615', '30781402', '30581987', '30782605', '30812933', '30810624', '30795483', '30804669', '00215408', '30109193', '30732465', '30529720', '30297346', '00550723', '30785419', '30705492', '30656827', '00213022', '30571719', '00332859', '30075687', '30494815', '00330459', '30579399', '30579399', '30673279', '30673279', '30687811',
'30687811', '30755770', '00393666', '30546534', '30805023', '30069375', '30325880', '30815420', '30484835', '30127972', '00676722', '00359745', '30030628', '00688129', '30057246', '30391814', '30663457', '30804090', '30224762', '30349448', '30629022', '30491107', '30491107', '30491107', '00413785', '30814558', '30312247', '30171374', '30521515', '30521515', '30708145', '30708145', '30003461', '30815101', '30618239', '30618239', '30323273', '30323273', '30736580', '30588224', '30793305', '30793306', '30706519', '30705412', '00054498', '30780268', '30742344', '30632041', '00641787', '30560737', '00528748', '30068752', '00686089', '30116940', '30307838', '30812095', '30207675', '30764392', '00357185', '00357185', '30559513', '30559513', '30590033', '30590033', '30782994', '30785254', '00271026', '30309849', '30798605', '30025909', '30170419', '30598621', '00635391', '30778046', '30784230', '30048210', '00618995', '30457741', '30457741', '30457741', '30491167', '30814240', '30786520', '30570224', '30288944', '30760775', '30364859', '30777846', '30635234', '30068236', '30456783', '00642385', '00642385', '00642385', '30505900', '30794077', '30552424', '00128292', '30528885', '30734757', '30740557', '30706315', '30798315', '00652961', '30789368', '30568817', '30568817', '30651461', '30445212', '30599339', '30599339', '30720429', '30184984', '30222521', '00272374', '30440031', '30783650', '30091950', '30794431', '30067204', '00117130', '00505643', '30778880', '30551722', '30808691', '30700168', '30586207', '30586207', '30586207', '30015991', '30661415', '30548864', '30548861', '00508954', '30765510', '00532214', '30398486', '30767598', '30706953', '30706953', '30706953', '30774379', '30774379', '30482827', '30050167', '30585702', '30810043', '00716804', '00716804', '00724884', '30748002', '30748002', '30211120', '00097479', '00050161', '30758467', '30006617', '30755189', '30538421', '30665850', '30812888', '30783883', '30076324', '30543327', '30664912', '00531159', '00363848', '30529806', '30584156', '30778200', '00696371', '30209368', '00054033', '30769651', '30506838', '30544988', '30544988', '30077321', '00488869', '30757945', '30261753', '30693229', '30693229', '00471721', '30285103', '30795356', '30804100', '30470624', '00513848', '00513848', '30507160', '30507160', '30785504', '30598055', '00527162', '00210113', '00210113', '30814949', '00632140', '30716523', '00321012', '30716341', '00731842', '00509628', '00509628', '30782560', '00441105', '30700453', '00648121', '30786203', '30135032', '30798063', '00393073', '30778765', '30752231', '30509090', '00299423', '00299423', '00045602', '30250528', '30658602', '30225531', '30167730', '30297871', '30558120', '30404176', '30136912', '30539661', '30787493', '30643456', '30333717', '00067452', '00240157', '30632135', '30776899', '30632135', '30632135', '30311510', '30813076', '30678908', '30415016', '30147422', '30147422', '30810036', '30801481', '30779965', '00115641',
 '30700736', '30775250', '30658525', '30123990', '30370044', '30370044', '00284391', '30808117', '30101742', '00704046', '30437435', '00684887', '00383223', '30224588', '30794544', '00731496', '30659484', '00526181', '30783890', '30082309', '30720086', '30781986', '30355767', '30367862', '30622145', '30695956', '30695956', '30755809', '30797292', '30170152', '30434841', '30434841', '30434841', '30545519', '30764270', '30652067', '30780767', '30389060', '30097913', '30795693', '30063482', '30555528', '30653062', '30653062', '30344440', '30447212', '30447212', '00559006', '30015944', '30416364', '00087646', '30214458', '30791858', '30744893', '30744893', '30434474', '30434474', '30434474', '30434474', '30802982', '30802982', '30769412', '30058021', '30546663', '00137177', '30746158', '30386857', '30121701', '30693162', '30801895', '30103809', '30303789', '30593023', '30672842', '30404173', '00390226', '30598097', '30653418', '30624818', '30779075', '30811021', '00262557', '30541539', '00304833', '30732908', '00157135', '30748516', '30475562', '30475562', '30475562', '30496972', '30672236', '30740025', '30643708', '30298685', '30710441', '30244537', '30244537', '30744701', '30791832', '30222381', '00552185', '00410192', '00475681', '00563423', '30728395', '30735300', '30657547', '30561674', '00208919', '30642989', '00652793', '30762770', '00061080', '30796682', '30617595', '30617595', '00466418', '30460498', '30460498', '30262373', '30645648', '00681779', '00681779', '30222145', '00601571', '30671329', '00349734', '30812329', '30810462', '00182730', '30576201', '30434544', '30124400', '30124400', '30810023', '30733310', '30486621', '30346792', '30341523', '00539476', '30656601', '00723089', '30797404', '30393367', '30137174', '30789921', '30741800', '30158807', '30720688', '30695512', '00638884', '30727667', '30805794', '30163514', '30476781', '30612112', '30463392', '00576011', '30231323', '30709981', '30307965', '30791051', '30796713', '30454855', '30734019', '30733571', '30793156', '30496188', '30626030', '30626030', '30626030', '30626030', '30626030', '30066846', '30744627', '30579896', '30178604', '00312825', '00289540', '00430903', '30422431', '30459583', '00027515', '30266129', '30700065', '30386719', '30168429', '30026449', '30078396', '30670592', '30790155', '30790155', '30751481', '00405038', '00702769', '30631822', '30744817', '30804861', '30281638', '30361292', '30361292', '30744285', '30804588', '30805879', '30414929', '30040028', '00241033', '30650080', '30510537', '30737933', '30737933', '30142093', '30445352', '30795367', '30795366', '30814349', '30776612', '30637289', '30205606', '30284395', '30807399', '30728129', '30795864', '00717042', '00717040', '00407449', '30727170', '30445447', '00247214', '30440386', '30627055', '30791705', '00475587', '30809867', '30431063', '30577983', '30803640', '30607054', '30607054', '30423621', '30687836', '30687836', '30687836', '30687836', '30687836', '30472000',
 '30607170', '30607170', '30462929', '30815054', '30681122', '30762179', '30762179', '30757855', '30366391', '30363150', '00152751', '30786001', '30240199', '30782562', '30344093', '30813777', '30781425', '30706737', '30548264', '30599796', '30771631', '30527384', '30644966', '30644966', '00501965', '30289163', '30289163', '00651223', '30384169', '00322624', '30417098', '30563974', '30806854', '30801851', '30404568', '30664193', '30801257', '30557082', '30713247', '00427915', '30465137', '30804252', '30564622', '30772483', '00623224', '30390245', '30760530', '00662689', '30786288', '00379941', '30801493', '30775086', '30552173', '00206706', '30534213', '30542528', '30794437', '30777312', '30474012', '30445477', '30544479', '30583673', '30335390', '30766844', '30589805', '30689961', '30518532', '30800747', '30289242', '30661894', '30112667', '30719762', '30198587', '30489759', '30302030', '30302030', '10000705', '30377766', '30602371', '30032548', '30809528', '00047300', '30655457', '30537786', '30613977', '30798531', '30665406', '30435007', '30382524', '30382524', '30770753', '00392672', '30381355', '30492873', '30599006', '30599006', '30045610', '30710180', '30810715', '30699401', '30639702', '30639702', '30804229', '00703721', '00703721', '30552225', '30552225', '00434377', '30210404', '00157692', '30765506', '30703039', '30703039', '30474566', '30637113', '30800630', '00004723', '30194819', '30115525', '00386145', '00329328', '00648199', '30810490', '30796216', '30049581', '30094205', '30522201', '30676839', '30598522', '30329582', '30557689', '30756945', '30756945', '30759518', '30716399', '30336084', '30729974', '30729974', '30786266', '30561966', '30561966', '30788516', '30706829', '30538441', '30475026', '30475026', '30475026', '00562495', '30213772', '00685637', '30393153', '30278121', '30755003', '30812204', '30808285', '30152957', '30152957', '00432288', '30647284', '30696703', '30696703', '30242582', '30670802', '30798037', '30466198', '00208063', '30736453', '00447481', '30792849', '30409061', '30000786', '30295304', '30612889', '30685534', '30059239', '30670254', '00693281', '30482348', '30528988', '00076197', '30805783', '00710642', '30500126', '00700011', '30047969', '30103551', '30741107', '30628452', '30221510', '00402993', '00402993', '30808775', '00691665', '30743772', '30783907', '30782375', '00447183', '30160892', '30215495', '30470894', '00564624', '30277510', '30494208', '30812105', '30264237', '30372110', '30733461', '30784025', '30447278', '30634672', '30758005', '30718712', '30406634', '30744727', '30815963', '30597141', '30812229', '30771013', '30537708', '30671232', '30523306', '00484783', '30630448', '30705078', '30579447', '30510357', '30750455', '30109323', '30540090', '30232947', '30770754', '30661048', '30467654', '30422354', '30778309', '30275723', '30275723', '30275723', '30275723', '00682335', '30173952', '30736372', '00426444', '30815453', '30511394', '30511394', '30456125',
 '30639540', '00616610', '00731589', '30148243', '30736285', '30736285', '30495003', '30495003', '30564774', '00601809', '30252135', '30411497', '30758404', '30387957', '30054287', '30474043', '30338668', '30430966', '30185844', '30185844', '30455867', '30455867', '30590451', '30735298', '00688417', '00430409', '30778233', '00486647', '00486647', '30262023', '00275522', '30554912', '30650440', '30591125', '30619928', '30746513', '00192272', '30137157', '30186551', '30186551', '00717705', '00363808', '30798657', '00328402', '30814344', '30814344', '30271981', '30793048', '30793048', '30776047', '30710065', '30001425', '00677838', '00601617', '30599408', '30804452', '00384779', '30807514', '00251090', '30699814', '00446031', '30809342', '30794935', '30763431', '30447673', '30585896', '30102634', '00250095', '00569273', '30618137', '30775302', '30792704', '30228842', '00578612', '30275756', '30277525', '30355153', '30210528', '00260344', '30439597', '30724140', '30738909', '30567706', '30009073', '00703134', '00560162', '00564181', '30353990', '30578280', '30788134', '00693658', '30793331', '30459032', '30474839', '30474839', '30641950', '30089310', '30094472', '30162660', '30403060', '30403060', '30403060', '30403060', '00238172', '30451768', '30437401', '30288721', '00184429', '00553519', '00158962', '30806034', '30806065', '30599817', '30812604', '30595505', '30398187', '00582169', '00058742', '30642636', '30376961', '30812093', '30741611', '30811628', '30789619', '30802259', '30601474', '00155792', '30657577', '00591886', '30431424', '30790410', '30381420', '30537124', '00392572', '30111392', '30701789', '30728298', '30040432', '30647880', '30617147', '00589516', '30279761', '30544806', '30544806', '30544806', '30798455', '30732227', '30113948', '30202769', '30042817', '00706563', '00516499', '30814504', '30118971', '30468360', '30647061', '30719593', '30805055', '00057488', '30261237', '00586688', '30805765', '30765438', '00487002', '30495481', '30334959', '30302374', '30699976', '30699976', '30699976', '30699976', '30572071', '30755201', '30619341', '00084323', '30247851', '30705688', '30761489', '30770757', '30787217', '30447913', '30447913', '30447913', '30465736', '00377989', '30464284', '30704045', '30153705', '30153705', '30351682', '30351682', '30123176', '30682811', '00452017', '30813673', '30010079', '30591156', '00240925', '30808446', '30321272', '30271947', '30785400', '30321312', '30802077', '30682810', '30477410', '30737270', '30506253', '00271321', '00104154', '30808078', '30762794', '00648374', '30815369', '30711789', '30758794', '30812334', '30730258', '30730258', '30172040', '30793777', '30772732', '00244853', '00244853', '30468461', '30670495', '30649210', '30813773', '30809201', '00704783', '30555777', '00606240', '00141739', '30578707', '30021742', '30294219', '00601665', '00408730', '30387506', '30806105', '30806105', '30806105', '30354832', '00713900', '00449255', '30781909', '30721276',
 '30721276', '30333681')
 