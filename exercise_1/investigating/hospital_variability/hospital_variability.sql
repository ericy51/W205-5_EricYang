create table procedure_var_ranks as
select measure_id, measure_name, var_score, cases, good_cases,
rank() over (order by var_score desc, cases desc) as procedure_var_rank
from
(select measures_final.measure_id, measures_final.measure_name, variance(scored) as var_score,
sum(sampled) as cases, sum(scored*sampled) as good_cases
from effective_care_final
inner join measures_final on effective_care_final.measure_id = measures_final.measure_id
where (measures_final.measure_id like 'OP%' or measures_final.measure_id like 'SCIP%'
or measures_final.measure_id like 'STK%' or measures_final.measure_id like 'VTE%'
 or measures_final.measure_id like 'AMI%')
and measure_type = 'rate'
group by measures_final.measure_id, measures_final.measure_name) as sub1
where var_score is not null;


create table high_var_procedure_top_10 as
select measure_id, measure_name, var_score from procedure_var_ranks
order by var_score desc limit 10;
