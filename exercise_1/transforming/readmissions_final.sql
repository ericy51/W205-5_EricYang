create table readmissions_final as select
provider_id, measure_id, compare_to_national,
int(case when denominator = 'Not Available' then Null else denominator end) as sample,
float(case when score = 'Not Available' then Null else score end) as scored,
float(case when lower_estimate = 'Not Available' then Null else lower_estimate end) as lower_est,
float(case when higher_estimate = 'Not Available' then Null else higher_estimate end) as higher_est
from readmissions;
