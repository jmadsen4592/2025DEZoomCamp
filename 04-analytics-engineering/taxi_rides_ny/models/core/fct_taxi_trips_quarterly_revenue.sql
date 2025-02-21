{{ config(materialized='table') }}

with trips_data as (
    select * from {{ ref('fact_trips') }}
),
    quart_rev as (
    select
    service_type, 
    sum(total_amount) as quarterly_revenue,
    year_quarter,
    year,
    quarter

    from trips_data

    WHERE year in (2019, 2020)
    
    group by service_type, year_quarter, year, quarter
)

    select 
    y2019.service_type,
    y2019.quarterly_revenue as rev2019,
    y2020.quarterly_revenue as rev2020,
    y2019.quarter,
    (y2020.quarterly_revenue-y2019.quarterly_revenue)/y2019.quarterly_revenue*100 as YoY_rev_growth
    from quart_rev y2019
    join quart_rev y2020 
        on y2020.quarter = y2019.quarter
        AND y2020.service_type = y2019.service_type
        and y2020.year = 2020
        and y2019.year = 2019

    order by y2019.quarter

