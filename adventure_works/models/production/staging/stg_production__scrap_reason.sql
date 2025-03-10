{{ config(schema='production')}}

with
    scrap_reason as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SCRAPREASON') }}
    )

    , renomear as (
        select
            try_cast(SCRAPREASONID as int) as pk_motivo_descarte
            , try_cast(NAME as string) as nome_motivo
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from scrap_reason
    )

select *
from renomear