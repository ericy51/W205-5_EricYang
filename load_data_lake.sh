#I downloaded the files to my local computer to explore and removed headers and copy to my google drive folder.  I did not show download commands since the exercise asked to only show renaming and loading to HDFS in this file.

tail -n +2 Downloads/Hospital_Revised_Flatfiles/"Hospital General Information.csv" > "Google Drive"/MIDS-205/hospital_data/hospital.csv

tail -n +2 Downloads/Hospital_Revised_Flatfiles/"Timely and Effective Care - Hospital.csv" > "Google Drive"/MIDS-205/hospital_data/effective_care.csv

tail -n +2 Downloads/Hospital_Revised_Flatfiles/"Readmissions and Deaths - Hospital.csv" > "Google Drive"/MIDS-205/hospital_data/readmissions.csv

tail -n +2 Downloads/Hospital_Revised_Flatfiles/"Measure Dates.csv" > "Google Drive"/MIDS-205/hospital_data/Measures.csv

tail -n +2 Downloads/Hospital_Revised_Flatfiles/"hvbp_hcahps_05_28_2015.csv" > "Google Drive"/MIDS-205/hospital_data/survey_responses.csv

#Earlier I created directory in my EBS /data/localdata.  Connect to Instance and copy files I just created.
scp -i UCB_205.pem ~/"google drive"/MIDS-205/hospital_data/hospital.csv root@ec2-54-88-143-203.compute-1.amazonaws.com:/data/localdata

scp -i UCB_205.pem ~/"google drive"/MIDS-205/hospital_data/effective_care.csv root@ec2-54-88-143-203.compute-1.amazonaws.com:/data/localdata

scp -i UCB_205.pem ~/"google drive"/MIDS-205/hospital_data/readmissions.csv root@ec2-54-88-143-203.compute-1.amazonaws.com:/data/localdata

scp -i UCB_205.pem ~/"google drive"/MIDS-205/hospital_data/Measures.csv root@ec2-54-88-143-203.compute-1.amazonaws.com:/data/localdata

scp -i UCB_205.pem ~/"google drive"/MIDS-205/hospital_data/survey_responses.csv root@ec2-54-88-143-203.compute-1.amazonaws.com:/data/localdata

#SSH to AWS Instance
ssh -i "UCB_205.pem" root@ec2-54-88-143-203.compute-1.amazonaws.com
su - w205

#Copy from local to hdfs
hdfs dfs -put /data/localdata/hospital.csv /user/w205/hospital_compare

hdfs dfs -put /data/localdata/effective_care.csv /user/w205/hospital_compare

hdfs dfs -put /data/localdata/readmissions.csv /user/w205/hospital_compare

hdfs dfs -put /data/localdata/Measures.csv /user/w205/hospital_compare

hdfs dfs -put /data/localdata/survey_responses.csv /user/w205/hospital_compare
