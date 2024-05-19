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
        TRIM(agency) as agency,
        TRIM(_firename) as fire_name,
        _lat as lat,
        _lon as lon,
        -- {{ dbt.safe_cast("_lat", api.Column.translate_type("float")) }} as fire_location_latitude,
        -- {{ dbt.safe_cast("_lon", api.Column.translate_type("float")) }} as fire_location_longitude,

        -- macro
        {{ get_bq_formatted_long_lat('_lon', '_lat') }} as fire_location_formatted,

        TRIM(_startdate) as startdate,
        _hectares as hectares,
        TRIM(_stage_of_control) as stage_of_control,
        TRIM(_timezone) as timezone,
        TRIM(_response_type) as response_type
    from source
)

select * from renamed
