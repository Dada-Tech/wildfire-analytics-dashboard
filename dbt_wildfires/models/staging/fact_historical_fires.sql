{{
    config(
        materialized='table'
    )
}}

with historical as (
    select * from {{ ref('stg_staging__historic') }}
),
wildfire_number as (
    select * from {{ ref('dim_wildfire_historical_number') }}
)

select *
from historical
inner join wildfire_number
on historical.forest_area_code = wildfire_number.wildfire_number