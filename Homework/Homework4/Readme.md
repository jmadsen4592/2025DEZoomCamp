Question 1:  select * from myproject.my_nyc_tripdata.ext_green_taxi

Question 2: Update the WHERE clause to pickup_datetime >= CURRENT_DATE - INTERVAL '{{ var("days_back", env_var("DAYS_BACK", "30")) }}' DAY

Question 3: dbt run --select models/staging/+

Question 4: Setting a value for DBT_BIGQUERY_STAGING_DATASET env var is mandatory, or it'll fail to compile
    This is because target_dataset acts as a backup to staging_dataset, so the staging dataset is not required.

Question 5: green: {best: 2020/Q1, worst: 2020/Q2}, yellow: {best: 2020/Q1, worst: 2020/Q2}
    green:  best Q1 -55.97% worst Q2 -92.69%
    yellow: best Q1 -17.91% worst Q2 -90.96%

Question 6: green: {p97: 55.0, p95: 45.0, p90: 26.5}, yellow: {p97: 31.5, p95: 25.5, p90: 19.0}

Question 7: LaGuardia Airport, Chinatown, Garment District

    SELECT * FROM `kestra-zoomcamp.dbt_madsen.fct_fhv_monthly_zone_traveltime_p90` 
    where year = 2019 and month = 11 and pickup_zone = 'Newark Airport'
        2nd longest p90: LaGuardia Airport

    SELECT * FROM `kestra-zoomcamp.dbt_madsen.fct_fhv_monthly_zone_traveltime_p90` 
    where year = 2019 and month = 11 and pickup_zone = 'SoHo'
        2nd longest p90: Chinatown

    SELECT * FROM `kestra-zoomcamp.dbt_madsen.fct_fhv_monthly_zone_traveltime_p90` 
    where year = 2019 and month = 11 and pickup_zone = 'Yorkville East'
        2nd longest p90: Garment District

