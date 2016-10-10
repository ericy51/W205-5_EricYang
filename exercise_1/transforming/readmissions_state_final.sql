create table readmissions_state_final as select state, measure_id,
num_hospitals_worse, num_hospitals_same, num_hospitals_better,
num_hospitals_few,
num_hospitals_better/(num_hospitals_worse + num_hospitals_same + num_hospitals_better) as percent_better
from readmissions_state;
