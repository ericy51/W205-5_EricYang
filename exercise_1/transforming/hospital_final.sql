#Completed
create table hospital_final as select provider_id, hospital_name,
address, city, state, zip_code, county_name, hospital_type, hospital_ownership,
emergency_services from hospitals;
