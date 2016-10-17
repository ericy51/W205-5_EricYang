
create table readmission_ranks as
select provider_id, avg_score, var_score, cases, death_or_readm,
rank() over (order by avg_score asc, cases desc) as readmission_rank
from
(select provider_id, avg(scored) as avg_score, variance(scored) as var_score,
sum(sample) as cases, sum(scored/100*sample) as death_or_readm
from readmissions_final group by provider_id) as sub1
where avg_score is not null;



create table time_ranks as
select provider_id, avg_score, var_score, cases, total_time,
rank() over (order by avg_score asc, cases desc) as time_rank
from
(select provider_id, avg(scored) as avg_score, variance(scored) as var_score,
sum(sampled) as cases, sum(scored*sampled) as total_time
from effective_care_final
inner join measures_final on effective_care_final.measure_id = measures_final.measure_id
where measure_type = 'time'
group by provider_id) as sub1
where avg_score is not null;



create table effective_care_ranks as
select provider_id, avg_score, var_score, cases, good_cases,
rank() over (order by avg_score desc, cases desc) as effective_care_rank
from
(select provider_id, avg(scored) as avg_score, variance(scored) as var_score,
sum(sampled) as cases, sum(scored*sampled) as good_cases
from effective_care_final
inner join measures_final on effective_care_final.measure_id = measures_final.measure_id
where (measures_final.measure_id like 'OP%' or measures_final.measure_id like 'SCIP%'
or measures_final.measure_id like 'STK%' or measures_final.measure_id like 'VTE%'
 or measures_final.measure_id like 'AMI%')
and measure_type = 'rate'
group by provider_id) as sub1
where avg_score is not null;



create table hospital_top_10 as
select provider_id, hospital_name, sum(readmission_rank+time_rank+effective_care_rank)/3 as total_rank
from
(select hospital_final.provider_id, hospital_name, readmission_rank, time_rank, effective_care_rank
from hospital_final
inner join readmission_ranks on hospital_final.provider_id = readmission_ranks.provider_id
inner join time_ranks on hospital_final.provider_id = time_ranks.provider_id
inner join effective_care_ranks on hospital_final.provider_id = effective_care_ranks.provider_id) as sub1
group by provider_id, hospital_name
order by total_rank asc
limit 10;
