create table effective_care_final as select provider_id, condition,
measure_id, float(score) as scored, int(sample) as sampled, footnote from effective_care;
