with 

source as (

    select * from {{ source('staging', 'all_data') }}

),

renamed as (

    select
        foco_id,
        lat,
        lon,
        pais,
        year

    from source

)

select * from renamed
