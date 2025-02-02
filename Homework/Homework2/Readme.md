Assignment:
    In order to complete the assignment I created a Subflow task and used it to loop through each month and taxi type for 2021.  Flow file is contained in the "fill_2021_data_subflow.yaml" file in this folder.

Questions:

1. 128.3 MB 

    - I found this number by disabling the purge file task in the '06_gcp_taxi' kestra flow.  Then i looked at the output files after execution of yellow 2020-12.

2. green_tripdata_2020-04.csv

    - In the videos this week we learned rendered means the variables within the string are inserted. This means that this is the correct format for the files found on github.

3. 24,648,499
    
    SELECT COUNT(1) 
    FROM `kestra-zoomcamp.de_zoomcamp.yellow_tripdata` 
    WHERE filename LIKE '%2020%'

4. 1,734,051

    SELECT COUNT(1) 
    FROM `kestra-zoomcamp.de_zoomcamp.green_tripdata` 
    WHERE filename LIKE '%2020%'

5. 1,925,152

    SELECT COUNT(1) 
    FROM `kestra-zoomcamp.de_zoomcamp.yellow_tripdata` 
    WHERE filename LIKE '%2021-03%'

6. Add a timezone property set to America/New_York in the Schedule trigger configuration

    This is correct because we use the second column (TZ identifier) on the wiki tz database for the correct input. Which is America/New_York for new york.
