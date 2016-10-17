create table survey_final as select
provider_id,
hcahps_base_score, hcahps_consistency_score,
(hcahps_base_score + hcahps_consistency_score) as total_hcahps_score
from survey_responses;
