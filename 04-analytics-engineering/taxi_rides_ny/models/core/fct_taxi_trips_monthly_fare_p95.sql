{{ config(materialized='table') }}

with trips_data as (
    select * from {{ ref('fact_trips') }}
)
select
    service_type,
    year,
    month,
    PERCENTILE_CONT(fare_amount, .97) OVER(PARTITION BY service_type, year, month) as p97,
    PERCENTILE_CONT(fare_amount, .95) OVER(PARTITION BY service_type, year, month) as p95,
    PERCENTILE_CONT(fare_amount, .90) OVER(PARTITION BY service_type, year, month) as p90
FROM 
    trips_data
WHERE 
    fare_amount > 0
    and trip_distance > 0
    and payment_type_description in ('Cash', 'Credit Card')
    and year in (2019, 2020)
ORDER BY
    1,2,3