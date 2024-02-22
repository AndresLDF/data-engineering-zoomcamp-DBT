{{
    config(
        materialized='table'
    )
}}

with fhv_tripdata as (
    select *, 
        'FHV' as service_type
    from `glossy-grin-413315`.`dbt_fluna`.`stg_fhv`
    where pickup_datetime < '2020-01-01'
), 
dim_zones as (
    select * from `glossy-grin-413315`.`dbt_fluna`.`dim_zones`
    where borough != 'Unknown'
)
select 
    fhv_tripdata.*,
    pickup_zone.locationid as pickup_locationid_zone,  -- Unique alias for pickup_locationid from pickup_zone table
    dropoff_zone.locationid as dropoff_locationid_zone  -- Unique alias for dropoff_locationid from dropoff_zone table
from fhv_tripdata
inner join dim_zones as pickup_zone
    on fhv_tripdata.pickup_locationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
    on fhv_tripdata.dropoff_locationid = dropoff_zone.locationid