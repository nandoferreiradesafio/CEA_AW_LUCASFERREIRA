{{ config(schema='sales') }}

with
    currency as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'CURRENCY') }}
    )

    , renomear as (
        select
            try_cast(currencycode as string) as pk_moeda
            , try_cast(name as string) as nome_moeda
            , try_cast(modifieddate as date) as data_modificacao
        from currency
    )

select *
from renomear