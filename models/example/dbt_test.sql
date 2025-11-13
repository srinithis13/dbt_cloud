{{ config(materialized='table') }}

with source_data as (

    select 3000 as id
    union all
    select null as id

)

select *
from source_data