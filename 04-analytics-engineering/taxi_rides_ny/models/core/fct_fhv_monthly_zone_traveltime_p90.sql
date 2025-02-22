{{ config(materialized='table') }}

with trips_data as (
    select 
        year,
        month,
        pickup_zone,
        dropoff_zone,
        PERCENTILE_CONT(trip_duration, .9) OVER(PARTITION BY year, month, pulocationid, dolocationid) AS p90
    FROM 
        {{ ref('dim_fhv_trips') }}
)
    select
    year, 
    month, 
    pickup_zone,
    dropoff_zone,
    max(p90) as percentile90
FROM 
    trips_data
GROUP BY
    year, month, pickup_zone, dropoff_zone
ORDER BY
    1,2,3,4