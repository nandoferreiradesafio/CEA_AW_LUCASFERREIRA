{{ config(schema='production') }}

with
    location as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'LOCATION') }}
    )

    , renomear as (
        select
            try_cast("locationid" as int) as pk_localizacao
            , try_cast("name" as string) as nome_localizacao
            , try_cast("costrate" as double) as taxa_custo
            , try_cast("availability" as int) as disponibilidade
            , try_cast('modifieddate' as date) as data_modificacao
        from location
    )

select *
from renomear