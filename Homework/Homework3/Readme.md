SETUP:
  CREATE OR REPLACE EXTERNAL TABLE `kestra-zoomcamp.de_zoomcamp.hw3_external_yellow_tripdata_2024`
  OPTIONS (
    format = 'PARQUET',
    uris = ['gs://kestra-de-zoomcamp-bucket-jmads/yellow_tripdata_2024-*.parquet']
  );

  CREATE OR REPLACE TABLE `kestra-zoomcamp.de_zoomcamp.hw3_yellow_tripdata_2024`
  AS SELECT * FROM `kestra-zoomcamp.de_zoomcamp.hw3_external_yellow_tripdata_2024`;

QUESTION 1: 20,332,093

  select count(1) from `de_zoomcamp.hw3_yellow_tripdata_2024`

QUESTION 2: external: 0 MB
        Materialized: 155.12 MB

  select count(distinct(PULocationID)) from `de_zoomcamp.hw3_external_yellow_tripdata_2024`
  select count(distinct(PULocationID)) from `de_zoomcamp.hw3_yellow_tripdata_2024`

Question 3: BigQuery is a columnar database, and it only scans the specific columns requested in the query. Querying two columns (PULocationID, DOLocationID) requires reading more data than querying one column (PULocationID), leading to a higher estimated number of bytes processed.

  select count(distinct(PULocationID)) from `de_zoomcamp.hw3_external_yellow_tripdata_2024`
    155.12 MB
  select PULocationID, DOLocationID from `de_zoomcamp.hw3_yellow_tripdata_2024`
    310.24 MB
  
Question 4: 8,333

  select count(*) from `de_zoomcamp.hw3_yellow_tripdata_2024`
  where fare_amount = 0

Question 5: Partition by tpep_dropoff_datetime and Cluster on VendorID

  partitioning improves filter or aggregate on a single column(tpep_dropoff_datetime)
  cluster when order of column is important(vendorID)

  CREATE OR REPLACE TABLE `de_zoomcamp.hw3_partition_cluster_yellow_tripdata_2024`
  PARTITION BY DATE(tpep_dropoff_datetime)
  CLUSTER BY VendorID AS (
    SELECT * FROM `de_zoomcamp.hw3_yellow_tripdata_2024`
  );
  
Question 6: 310.24 MB for non-partitioned table and 26.84 MB for the partitioned table

  Non-Partitioned Query: 310.24 MB
    select VendorID from `de_zoomcamp.hw3_yellow_tripdata_2024`
    where tpep_dropoff_datetime between "2024-03-01" and "2024-03-15"

  Partitioned and Clustered Query: 26.84 MB
    select VendorID from `de_zoomcamp.hw3_partition_cluster_yellow_tripdata_2024`
    where tpep_dropoff_datetime between "2024-03-01" and "2024-03-15"

Question 7: GCP Bucket

  I can tell by looking at the table details for my external table: 
    Source URI(s) gs://kestra-de-zoomcamp-bucket-jmads/yellow_tripdata_2024-*.parquet


Question 8: False
  if your data size is less than 1gb than clustering does not improve performance and might actually worsen it.

Question 9: 0 MB  
  I believe this would be because the number of rows in the table is already cached, therefore it doesnt need to count all the rows with a query and can instead return that number.