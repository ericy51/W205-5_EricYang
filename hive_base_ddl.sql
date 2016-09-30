CREATE EXTERNAL TABLE hospitals (provider_id int, hospital_name String,
address String, city String, state String, zip_code int, county_name String,
phone_number int, hospital_type String, hospital_ownership String,
emergency_services String)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
  LOCATION "/user/w205/hospital_compare/hospital";



CREATE EXTERNAL TABLE readmissions (provider_id int, hospital_name String,
address String, city String, state String, zip_code int, county_name String,
phone_number int, measure_name String, measure_id String,
compare_to_national String, denominator String, lower_estimate String,
higher_estimate String, footnote String, measure_start_date date,
measure_end_date date)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
  LOCATION "/user/w205/hospital_compare/readmissions";


CREATE EXTERNAL TABLE measures (measure_name String, measure_id String,
measure_start_quarter String, measure_start_date date,
measure_end_quarter String, measure_end_date date)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
  LOCATION "/user/w205/hospital_compare/Measures";


CREATE EXTERNAL TABLE effective_care (provider_id int, hospital_name String,
address String, city String, state String, zip_code int, county_name String,
phone_number int, condition String, measure_id String, measure_name String,
score String, sample String, footnote String, measure_start_date date,
measure_end_date date)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
  LOCATION "/user/w205/hospital_compare/effective_care";



CREATE EXTERNAL TABLE survey_responses (provider_id int, hospital_name String,
address String, city String, state String, zip_code int, county_name String,
com_nurse_achievement_pts String, com_nurse_improvement_pts String,
com_nurse_dimension_score String, com_doctor_achievement_pts String,
com_doctor_improvement_pts String, com_doctor_dimension_score String,
resp_staff_achievement_pts String, resp_staff_improvement_pts String,
resp_staff_dimension_score String, pain_manage_achievement_pts String,
pain_manage_improvement_pts String, pain_manage_dimension_score String,
com_medicines_achievement_pts String, com_medicines_improvement_pts String,
com_medicines_dimension_score String, clean_quiet_hosp_achievement_pts String,
clean_quiet_hosp_improvement_pts String, clean_quiet_hosp_dimension_score String,
discharge_achievement_pts String, discharge_improvement_pts String,
discharge_dimension_score String, overall_achievement_pts String,
overall_improvement_pts String, overall_dimension_score String,
hcahps_base_score int, hcahps_consistency_score int)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
  LOCATION "/user/w205/hospital_compare/survey_responses";
