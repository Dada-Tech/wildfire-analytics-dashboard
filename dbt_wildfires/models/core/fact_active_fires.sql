{{
    config(
        materialized='table'
    )
}}

with active as (
    select *
    from {{ ref('stg_staging__active') }}
),
stage_dim as (
    select * from {{ ref('dim_wildfire_active_stage_of_control') }}
)

select *
from active
inner join stage_dim
on active.stage_of_control = stage_dim.stage