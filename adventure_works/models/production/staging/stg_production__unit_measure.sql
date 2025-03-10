{{ config(schema='production')}}

with
    unit_measure as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'UNITMEASURE')}}
    )

    , renomear as (
        select
            try_cast(unitmeasurecode as string) as pk_unidade_medida
            , try_cast(name as string) as nome_unidade_medida
            , try_cast(modifieddate as date) as data_modificacao
        from unit_measure
    )

select *
from renomear