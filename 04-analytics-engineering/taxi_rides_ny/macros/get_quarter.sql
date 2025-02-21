{#
    This macro returns the quarter of each year
#}

{% macro get_quarter(pickup_datetime) -%}

    case 
        when EXTRACT(MONTH FROM {{ pickup_datetime }}) in (1, 2, 3) then 1
        when EXTRACT(MONTH FROM {{ pickup_datetime }}) in (4, 5, 6) then 2
        when EXTRACT(MONTH FROM {{ pickup_datetime }}) in (7, 8, 9) then 3
        when EXTRACT(MONTH FROM {{ pickup_datetime }}) in (10, 11, 12) then 4
    end

{%- endmacro %}