with 

source as (

    select * from {{ source('staging', 'all_data') }}

),

renamed as (

    select
        foco_id,
        lat,
        lon,
        data_pas,
        pais,
        estado,
        municipio

    from source

)

select * from renamed
