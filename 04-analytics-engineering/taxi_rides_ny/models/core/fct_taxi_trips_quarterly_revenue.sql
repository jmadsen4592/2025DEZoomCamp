{{ config(materialized='table') }}

with trips_data as (
    select * from {{ ref('fact_trips') }}
)

    select 
    sum(total_amount) as quarterly_revenue,
    year_quarter 

    from trips_data
    
    group by year_quarter