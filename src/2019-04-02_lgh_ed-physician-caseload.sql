
/*-------------------------------------------------------------------------

LGH ED PHYSICIAN CASELOAD BY YEAR 
2019-04-02
JIRA si-2367

*/-------------------------------------------------------------------------


if object_id('tempdb.dbo.#t1_dr_codes') is not null drop table #t1_dr_codes; 



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
	, count(*)

from ADRMart.[dbo].[vwAbstractFact] adr
	inner join ADRMart.[dbo].vwDoctor dr
		on adr.PAtientID = dr.PatientID
			and adr.RegisterNumber = dr.RegisterNumber

	inner join #t1_dr_codes t1
		on adr.MostRespProviderCode = t1.code 

where adr.[FacilityShortName] = 'lgh' 
	
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
