{{
    config(
        materialized='view'
    )
}}

with 

source as (

    select * from {{ source('staging_active', 'active') }}

),

renamed as (
    select
        agency,
        _firename as fire_name,
        _lat as lat,
        _lon as lon,
        _startdate as startdate,
        _hectares as hectares,
        _stage_of_control as stage_of_control,
        _timezone as timezone,
        _response_type as response_type
    from source
)

select * from renamed
