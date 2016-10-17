#download files
wget -O /data/localdata/exercise1/hospital_data.zip https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip

#unzip hospital data
unzip /data/localdata/exercise1/hospital_data.zip

#Remove Top Line
tail -n +2 "Hospital General Information.csv" > /data/localdata/exercise1/hospital.csv

tail -n +2 "Timely and Effective Care - Hospital.csv" > /data/localdata/exercise1/effective_care.csv

tail -n +2 "Readmissions and Deaths - Hospital.csv" > /data/localdata/exercise1/readmissions.csv

tail -n +2 "Measure Dates.csv" > /data/localdata/exercise1/Measures.csv

tail -n +2 "hvbp_hcahps_05_28_2015.csv" > /data/localdata/exercise1/survey_responses.csv

tail -n +2 "Readmissions and Deaths - State.csv" > /data/localdata/exercise1/readmissions_state.csv

tail -n +2 "Timely and Effective Care - State.csv" > /data/localdata/exercise1/effective_care_state.csv

#switch user
su - w205

#make directories
hdfs dfs -mkdir /user/w205/hospital_compare/hospital
hdfs dfs -mkdir /user/w205/hospital_compare/effective_care
hdfs dfs -mkdir /user/w205/hospital_compare/readmissions
hdfs dfs -mkdir /user/w205/hospital_compare/Measures
hdfs dfs -mkdir /user/w205/hospital_compare/survey_responses
hdfs dfs -mkdir /user/w205/hospital_compare/readmissions_state
hdfs dfs -mkdir /user/w205/hospital_compare/effective_care_state

#copy csv to hdfs
hdfs dfs -put /data/localdata/exercise1/hospital.csv /user/w205/hospital_compare/hospital

hdfs dfs -put /data/localdata/exercise1/effective_care.csv /user/w205/hospital_compare/effective_care

hdfs dfs -put /data/localdata/exercise1/readmissions.csv /user/w205/hospital_compare/readmissions

hdfs dfs -put /data/localdata/exercise1/Measures.csv /user/w205/hospital_compare/Measures

hdfs dfs -put /data/localdata/exercise1/survey_responses.csv /user/w205/hospital_compare/survey_responses

hdfs dfs -put /data/localdata/exercise1/readmissions_state.csv /user/w205/hospital_compare/readmissions_state

hdfs dfs -put /data/localdata/exercise1/effective_care_state.csv /user/w205/hospital_compare/effective_care_state
