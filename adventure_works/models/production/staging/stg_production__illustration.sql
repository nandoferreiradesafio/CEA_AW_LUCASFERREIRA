{{ config(schema='production') }}

with
    illustration as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'ILLUSTRATION') }}
    )

    , renomear as (
        select
            try_cast(ILLUSTRATIONID as int) as pk_ilustracao
            , try_cast(DIAGRAM as string) as diagrama
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from illustration
    )

select *
from renomear