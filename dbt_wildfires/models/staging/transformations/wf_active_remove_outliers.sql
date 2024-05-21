with active as (
    select *
    from {{ ref('stg_staging__active') }}
)

select * from active
WHERE CAST(LEFT(startdate,10) AS DATE) <= current_date()
ORDER BY startdate DESC