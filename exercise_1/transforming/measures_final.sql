create table measures_final as select measure_name, measure_id,
measure_start_quarter, measure_start_date,
measure_end_quarter, measure_end_date,
String(case when measure_name like '%Median%' then 'time'
when measure_id in ('ED_2b', 'ED_1b','OP_18b','OP_20') then 'time'
else 'rate' end) as measure_type
from measures;
