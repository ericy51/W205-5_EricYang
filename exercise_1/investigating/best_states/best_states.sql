
create table readmission_state_ranks as
select state, avg_better, var_better, cases, better_hospitals,
rank() over (order by avg_better desc, cases desc) as readmission_state_rank
from
(select state, avg(percent_better) as avg_better,
variance(percent_better) as var_better,
sum(num_hospitals_worse + num_hospitals_same + num_hospitals_better) as cases,
sum(num_hospitals_better) as better_hospitals
from readmissions_state_final group by state) as sub1
where avg_better is not null;



create table time_state_ranks as
select state, avg_score, var_score,
rank() over (order by avg_score asc) as time_rank
from
(select state, avg(state_score) as avg_score, variance(state_score) as var_score
from effective_care_state_final
inner join measures_final on effective_care_state_final.measure_id = measures_final.measure_id
where measure_type = 'time'
group by state) as sub1
where avg_score is not null;



create table effective_care_state_ranks as
select state, avg_score, var_score,
rank() over (order by avg_score desc) as effective_care_state_rank
from
(select state, avg(state_score) as avg_score, variance(state_score) as var_score
from effective_care_state_final
inner join measures_final on effective_care_state_final.measure_id = measures_final.measure_id
where (measures_final.measure_id like 'OP%' or measures_final.measure_id like 'SCIP%'
or measures_final.measure_id like 'STK%' or measures_final.measure_id like 'VTE%'
 or measures_final.measure_id like 'AMI%')
and measure_type = 'rate'
group by state) as sub1
where avg_score is not null;




create table states_top_10 as
select state, sum(readmission_state_rank+time_rank+effective_care_state_rank)/3 as total_state_rank
from
(select readmission_state_ranks.state, readmission_state_rank, time_rank, effective_care_state_rank
from readmission_state_ranks
inner join effective_care_state_ranks on readmission_state_ranks.state = effective_care_state_ranks.state
inner join time_state_ranks on readmission_state_ranks.state = time_state_ranks.state) as sub1
group by state
order by total_state_rank asc
limit 10;
