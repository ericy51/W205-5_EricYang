create table effective_care_state_final as select state, condition,
measure_id,
float(case when score = 'Not Available' then Null else score end) as state_score,
footnote from effective_care_state;
