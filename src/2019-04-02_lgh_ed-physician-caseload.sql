
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
select adr.PAtientID
	, adr.fiscalyear
	, adr.FacilityShortName
	, adr.AdmitNursingUnitCode
	, adr.AdmitNursingUnit
	, adr.CMGPlusCode
	, adr.CMGPlusDesc
	, adr.AdmitDate
	, adr.DischargeDate
	, adr.Px1Code
	, adr.Px1Desc

	, dr.DR1DoctorCode
	, dr.DR1DoctorName

	, dr.DR2DoctorCode
	, dr.DR2DoctorName

	, dr.DR3DoctorCode
	, dr.DR3DoctorName

	, dr.DR4DoctorCode
	, dr.DR4DoctorName

	, dr.DR5DoctorCode
	, dr.DR5DoctorName

	, dr.DR6DoctorCode
	, dr.DR6DoctorName

	, dr.DR7DoctorCode
	, dr.DR7DoctorName

	, dr.DR8DoctorCode
	, dr.DR8DoctorName

	, [MostRespProviderCode]
    , [MostRespProviderName]

	

into #t2_records_with_all_docs 

from ADRMart.[dbo].[vwAbstractFact] adr
	inner join ADRMart.[dbo].vwDoctor dr
		on adr.PAtientID = dr.PatientID
			and adr.RegisterNumber = dr.RegisterNumber

where adr.[FacilityShortName] = 'lgh' 
	and (dr.dr1DoctorCode in ('04751'
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

		OR

		dr.DR2DoctorCode in ('04751'
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

		OR  

		dr.dr3DoctorCode in ('04751'
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

		OR  

		dr.DR4DoctorCode in ('04751'
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

		OR  

		dr.DR5DoctorCode in ('04751'
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

		OR  

		dr.DR6DoctorCode in ('04751'
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


		OR  

		dr.DR7DoctorCode in ('04751'
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


		OR  

		dr.DR8DoctorCode in ('04751'
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

	) -- closes the "and" that groups together Doctor1 to Doctor 2 

order by adr.FiscalYear

/*
select * 
from #t2_records_with_all_docs 
order by FiscalYear
	, AdmitDate
	, MostRespProviderName

*/



-- finally, let's count them all up: 

select fiscalyear
	, sum(case when dr1doctorcode = '04751'
				  or DR2DoctorCode = '04751'
				  or DR3DoctorCode = '04751'
				  or DR4DoctorCode = '04751'
				  or DR5DoctorCode = '04751'
				  or DR6DoctorCode = '04751'
				  or DR7DoctorCode = '04751'
				  or DR8DoctorCode = '04751' then 1 else 0 end) as 'ANDOLFATTO, GARY'

	, sum(case when dr1doctorcode = '09654'
				  or DR2DoctorCode = '09654'
				  or DR3DoctorCode = '09654'
				  or DR4DoctorCode = '09654'
				  or DR5DoctorCode = '09654'
				  or DR6DoctorCode = '09654'
				  or DR7DoctorCode = '09654'
				  or DR8DoctorCode = '09654' then 1 else 0 end) as 'ANGUS, ERIC E.'

	, sum(case when dr1doctorcode = '63012'
				  or DR2DoctorCode = '63012'
				  or DR3DoctorCode = '63012'
				  or DR4DoctorCode = '63012'
				  or DR5DoctorCode = '63012'
				  or DR6DoctorCode = '63012'
				  or DR7DoctorCode = '63012'
				  or DR8DoctorCode = '63012' then 1 else 0 end) as 'CHESTNUT, SHANNON'

	, sum(case when dr1doctorcode = '64216'
				  or DR2DoctorCode = '64216'
				  or DR3DoctorCode = '64216'
				  or DR4DoctorCode = '64216'
				  or DR5DoctorCode = '64216'
				  or DR6DoctorCode = '64216'
				  or DR7DoctorCode = '64216'
				  or DR8DoctorCode = '64216' then 1 else 0 end) as 'EBERDT, CAROLINE'

	, sum(case when dr1doctorcode = '66587'
				  or DR2DoctorCode = '66587'
				  or DR3DoctorCode = '66587'
				  or DR4DoctorCode = '66587'
				  or DR5DoctorCode = '66587'
				  or DR6DoctorCode = '66587'
				  or DR7DoctorCode = '66587'
				  or DR8DoctorCode = '66587' then 1 else 0 end) as 'HECHT, KRISTIAN KLAUS'

	, sum(case when dr1doctorcode = '26650'
				  or DR2DoctorCode = '26650'
				  or DR3DoctorCode = '26650'
				  or DR4DoctorCode = '26650'
				  or DR5DoctorCode = '26650'
				  or DR6DoctorCode = '26650'
				  or DR7DoctorCode = '26650'
				  or DR8DoctorCode = '26650' then 1 else 0 end) as 'HORAK, STUART Z.'

	, sum(case when dr1doctorcode = '65834'
				  or DR2DoctorCode = '65834'
				  or DR3DoctorCode = '65834'
				  or DR4DoctorCode = '65834'
				  or DR5DoctorCode = '65834'
				  or DR6DoctorCode = '65834'
				  or DR7DoctorCode = '65834'
				  or DR8DoctorCode = '65834' then 1 else 0 end) as 'IVSINS, AVERIL ELIZABETH'

	, sum(case when dr1doctorcode = '68459'
				  or DR2DoctorCode = '68459'
				  or DR3DoctorCode = '68459'
				  or DR4DoctorCode = '68459'
				  or DR5DoctorCode = '68459'
				  or DR6DoctorCode = '68459'
				  or DR7DoctorCode = '68459'
				  or DR8DoctorCode = '68459' then 1 else 0 end) as 'JAEGER, ERIK'

	, sum(case when dr1doctorcode = '65437'
				  or DR2DoctorCode = '65437'
				  or DR3DoctorCode = '65437'
				  or DR4DoctorCode = '65437'
				  or DR5DoctorCode = '65437'
				  or DR6DoctorCode = '65437'
				  or DR7DoctorCode = '65437'
				  or DR8DoctorCode = '65437' then 1 else 0 end) as 'KING, DAVID SEBASTIAN'

	, sum(case when dr1doctorcode = '27508'
				  or DR2DoctorCode = '27508'
				  or DR3DoctorCode = '27508'
				  or DR4DoctorCode = '27508'
				  or DR5DoctorCode = '27508'
				  or DR6DoctorCode = '27508'
				  or DR7DoctorCode = '27508'
				  or DR8DoctorCode = '27508' then 1 else 0 end) as 'KUNG, JAMES'

	, sum(case when dr1doctorcode = '63961'
				  or DR2DoctorCode = '63961'
				  or DR3DoctorCode = '63961'
				  or DR4DoctorCode = '63961'
				  or DR5DoctorCode = '63961'
				  or DR6DoctorCode = '63961'
				  or DR7DoctorCode = '63961'
				  or DR8DoctorCode = '63961' then 1 else 0 end) as 'LAI, JATINA'

	, sum(case when dr1doctorcode = '27079'
				  or DR2DoctorCode = '27079'
				  or DR3DoctorCode = '27079'
				  or DR4DoctorCode = '27079'
				  or DR5DoctorCode = '27079'
				  or DR6DoctorCode = '27079'
				  or DR7DoctorCode = '27079'
				  or DR8DoctorCode = '27079' then 1 else 0 end) as 'MCGROGAN, JONATHAN'

	, sum(case when dr1doctorcode = '28516'
				  or DR2DoctorCode = '28516'
				  or DR3DoctorCode = '28516'
				  or DR4DoctorCode = '28516'
				  or DR5DoctorCode = '28516'
				  or DR6DoctorCode = '28516'
				  or DR7DoctorCode = '28516'
				  or DR8DoctorCode = '28516' then 1 else 0 end) as 'MCLEAN, NEIL'

	, sum(case when dr1doctorcode = '64478'
				  or DR2DoctorCode = '64478'
				  or DR3DoctorCode = '64478'
				  or DR4DoctorCode = '64478'
				  or DR5DoctorCode = '64478'
				  or DR6DoctorCode = '64478'
				  or DR7DoctorCode = '64478'
				  or DR8DoctorCode = '64478' then 1 else 0 end) as 'MILLER, PHILIP YOJI'

	, sum(case when dr1doctorcode = '24950'
				  or DR2DoctorCode = '24950'
				  or DR3DoctorCode = '24950'
				  or DR4DoctorCode = '24950'
				  or DR5DoctorCode = '24950'
				  or DR6DoctorCode = '24950'
				  or DR7DoctorCode = '24950'
				  or DR8DoctorCode = '24950' then 1 else 0 end) as 'PARK, HAZEL S.'

	, sum(case when dr1doctorcode = '27866'
				  or DR2DoctorCode = '27866'
				  or DR3DoctorCode = '27866'
				  or DR4DoctorCode = '27866'
				  or DR5DoctorCode = '27866'
				  or DR6DoctorCode = '27866'
				  or DR7DoctorCode = '27866'
				  or DR8DoctorCode = '27866' then 1 else 0 end) as 'PULFREY, SIMON MICHAEL'

	, sum(case when dr1doctorcode = '64754'
				  or DR2DoctorCode = '64754'
				  or DR3DoctorCode = '64754'
				  or DR4DoctorCode = '64754'
				  or DR5DoctorCode = '64754'
				  or DR6DoctorCode = '64754'
				  or DR7DoctorCode = '64754'
				  or DR8DoctorCode = '64754' then 1 else 0 end) as 'READ, BRANDI LOUISE'

	, sum(case when dr1doctorcode = '24077'
				  or DR2DoctorCode = '24077'
				  or DR3DoctorCode = '24077'
				  or DR4DoctorCode = '24077'
				  or DR5DoctorCode = '24077'
				  or DR6DoctorCode = '24077'
				  or DR7DoctorCode = '24077'
				  or DR8DoctorCode = '24077' then 1 else 0 end) as 'STAGER, ANDREW'

	, sum(case when dr1doctorcode = '27957'
				  or DR2DoctorCode = '27957'
				  or DR3DoctorCode = '27957'
				  or DR4DoctorCode = '27957'
				  or DR5DoctorCode = '27957'
				  or DR6DoctorCode = '27957'
				  or DR7DoctorCode = '27957'
				  or DR8DoctorCode = '27957' then 1 else 0 end) as 'STANIFORTH, SEAN'

	, sum(case when dr1doctorcode = '64789'
				  or DR2DoctorCode = '64789'
				  or DR3DoctorCode = '64789'
				  or DR4DoctorCode = '64789'
				  or DR5DoctorCode = '64789'
				  or DR6DoctorCode = '64789'
				  or DR7DoctorCode = '64789'
				  or DR8DoctorCode = '64789' then 1 else 0 end) as 'VEGSUND, BJORN COOPER'

	, sum(case when dr1doctorcode = '64265'
				  or DR2DoctorCode = '64265'
				  or DR3DoctorCode = '64265'
				  or DR4DoctorCode = '64265'
				  or DR5DoctorCode = '64265'
				  or DR6DoctorCode = '64265'
				  or DR7DoctorCode = '64265'
				  or DR8DoctorCode = '64265' then 1 else 0 end) as 'WILSON, BENJAMIN ROGER'

	, sum(case when dr1doctorcode = '64418'
				  or DR2DoctorCode = '64418'
				  or DR3DoctorCode = '64418'
				  or DR4DoctorCode = '64418'
				  or DR5DoctorCode = '64418'
				  or DR6DoctorCode = '64418'
				  or DR7DoctorCode = '64418'
				  or DR8DoctorCode = '64418' then 1 else 0 end) as 'WONG, WAI-BEN'





from #t2_records_with_all_docs

group by fiscalyear
