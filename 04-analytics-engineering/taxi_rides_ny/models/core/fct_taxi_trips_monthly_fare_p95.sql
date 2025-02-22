{{ config(materialized='table') }}

with trips_data as (
    select 
    service_type,
    year,
    month,
    PERCENTILE_CONT(fare_amount, .97) OVER(PARTITION BY service_type, year, month) as p97,
    PERCENTILE_CONT(fare_amount, .95) OVER(PARTITION BY service_type, year, month) as p95,
    PERCENTILE_CONT(fare_amount, .90) OVER(PARTITION BY service_type, year, month) as p90
    from 
        {{ ref('fact_trips') }}
    WHERE 
        fare_amount > 0
        and trip_distance > 0
        and payment_type_description in ('Cash', 'Credit card')
        and year in (2019, 2020)
)
select
    service_type,
    year,
    month,
    max(p97) as percentile97,
    max(p95) as percentile95,
    max(p90) as percentile90
FROM 
    trips_data
GROUP BY
    service_type, year, month
ORDER BY
    1,2,3