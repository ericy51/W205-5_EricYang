create table survey_crossover_quality as
select sub3.provider_id, sub2.hospital_name from
(select provider_id, hcahps_base_score
from survey_final
order by hcahps_base_score desc limit 500) sub3
inner join
(select provider_id, hospital_name, sum(readmission_rank+time_rank+effective_care_rank)/3 as total_rank
from
(select hospital_final.provider_id, hospital_name, readmission_rank, time_rank, effective_care_rank
from hospital_final
inner join readmission_ranks on hospital_final.provider_id = readmission_ranks.provider_id
inner join time_ranks on hospital_final.provider_id = time_ranks.provider_id
inner join effective_care_ranks on hospital_final.provider_id = effective_care_ranks.provider_id) as sub1
group by provider_id, hospital_name
order by total_rank asc
limit 500) sub2
on sub3.provider_id = sub2.provider_id;



create table readmission_var_ranks as
select provider_id, var_score, cases, death_or_readm,
rank() over (order by var_score desc, cases desc) as readmission_var_rank
from readmission_ranks;



create table time_var_ranks as
select provider_id, var_score, cases, total_time,
rank() over (order by var_score desc, cases desc) as time_var_rank
from time_ranks;




create table effective_care_var_ranks as
select provider_id, var_score, cases, good_cases,
rank() over (order by var_score desc, cases desc) as effective_care_var_rank
from effective_care_ranks;




create table survey_crossover_variability as
select sub3.provider_id, sub2.hospital_name from
(select provider_id, hcahps_consistency_score
from survey_final
order by hcahps_consistency_score desc limit 500) sub3
inner join
(select provider_id, hospital_name, sum(readmission_var_rank+time_var_rank+effective_care_var_rank)/3 as total_var_rank
from
(select hospital_final.provider_id, hospital_name, readmission_var_rank, time_var_rank, effective_care_var_rank
from hospital_final
inner join readmission_var_ranks on hospital_final.provider_id = readmission_var_ranks.provider_id
inner join time_var_ranks on hospital_final.provider_id = time_var_ranks.provider_id
inner join effective_care_var_ranks on hospital_final.provider_id = effective_care_var_ranks.provider_id) as sub1
group by provider_id, hospital_name
order by total_var_rank desc limit 500) sub2
on sub3.provider_id = sub2.provider_id;
