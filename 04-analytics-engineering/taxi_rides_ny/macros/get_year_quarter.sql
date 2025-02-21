{#
    This macro returns the year and quarter in a "YYYY/Q" format
#}

{% macro get_year_quarter(pickup_datetime) -%}

    CONCAT(CAST(EXTRACT(YEAR FROM {{ pickup_datetime }}) AS STRING), '/', 'Q', 
           CASE 
               WHEN EXTRACT(MONTH FROM {{ pickup_datetime }}) IN (1, 2, 3) THEN '1'
               WHEN EXTRACT(MONTH FROM {{ pickup_datetime }}) IN (4, 5, 6) THEN '2'
               WHEN EXTRACT(MONTH FROM {{ pickup_datetime }}) IN (7, 8, 9) THEN '3'
               WHEN EXTRACT(MONTH FROM {{ pickup_datetime }}) IN (10, 11, 12) THEN '4'
           END)

{%- endmacro %}