
/*-------------------------------------------------------------------------

LGH ED PHYSICIAN CASELOAD BY YEAR 
2019-04-02
JIRA si-2367

*/-------------------------------------------------------------------------


if object_id('tempdb.dbo.#t1_dr_codes') is not null drop table #t1_dr_codes; 
if object_id('tempdb.dbo.#t2_records_with_all_docs') is not null drop table #t2_records_with_all_docs; 

-- pull the codes of the doctors we're interested in: 
select distinct MostRespProviderName as [name] 
	, MostRespProviderCode as [code] 
	--, MostRespProviderService 

into #t1_dr_codes 

from ADRMart.[dbo].[vwAbstractFact]

where MostRespProviderName in ('ANDOLFATTO, GARY'
	 , 'ANGUS, ERIC E.'
	 , 'CHESTNUT, SHANNON'
	 , 'EBERDT, CAROLINE'
	 , 'HECHT, KRISTIAN KLAUS'
	 , 'HORAK, STUART Z.'
	 , 'IVSINS, AVERIL ELIZABETH'
	 , 'JAEGER, ERIK'
	 , 'KING, DAVID SEBASTIAN'
	 , 'KUNG, JAMES'
	 , 'LAI, JATINA'
	 , 'MCGROGAN, JONATHAN'
	 , 'MCLEAN, NEIL'
	 , 'MILLER, PHILIP YOJI'
	 , 'PARK, HAZEL S.'
	 , 'PULFREY, SIMON MICHAEL'
	 , 'READ, BRANDI LOUISE'
	 , 'STAGER, ANDREW'
	 , 'STANIFORTH, SEAN'
	 , 'VEGSUND, BJORN COOPER'
	 , 'WILSON, BENJAMIN ROGER'
	 , 'WONG, WAI-BEN')

order by MostRespProviderName; 

--select * from #t1_dr_codes order by name


-- pull all records where the doctors listed above are involved in care (MRP or not): 
select adr.fiscalyear
	, dr.DR1DoctorCode
	, dr.DR2DoctorCode
	, dr.DR3DoctorCode
	, dr.DR4DoctorCode
	, dr.DR5DoctorCode
	, dr.DR6DoctorCode
	, dr.DR7DoctorCode
	, dr.DR8DoctorCode
	, count(*) as num

into #t2_records_with_all_docs 

from ADRMart.[dbo].[vwAbstractFact] adr
	inner join ADRMart.[dbo].vwDoctor dr
		on adr.PAtientID = dr.PatientID
			and adr.RegisterNumber = dr.RegisterNumber

where adr.[FacilityShortName] = 'lgh' 
	and dr.dr1DoctorCode in ('04751'
							 , '09654'
							 , '63012'
							 , '64216'
							 , '66587'
							 , '26650'
							 , '65834'
							 , '68459'
							 , '65437'
							 , '27508'
							 , '63961'
							 , '27079'
							 , '28516'
							 , '64478'
							 , '24950'
							 , '27866'
							 , '64754'
							 , '24077'
							 , '27957'
							 , '64789'
							 , '64265'
							 , '64418')



group by adr.FiscalYear
	, dr.DR1DoctorCode
	, dr.DR2DoctorCode
	, dr.DR3DoctorCode
	, dr.DR4DoctorCode
	, dr.DR5DoctorCode
	, dr.DR6DoctorCode
	, dr.DR7DoctorCode
	, dr.DR8DoctorCode

order by adr.FiscalYear

select * from #t2_records_with_all_docs order by FiscalYear