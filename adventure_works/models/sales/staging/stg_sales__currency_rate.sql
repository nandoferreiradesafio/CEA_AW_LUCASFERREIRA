{{ config(schema='sales') }}

with
    currencyrate as(
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'CURRENCYRATE') }}
    )

    , renomear as(
        select
            try_cast(currencyrateid as int) as pk_taxa_cambio
            , try_cast(fromcurrencycode as string) as codigo_moeda_inicial
            , try_cast(tocurrencycode as string) as codigo_moeda_final
            , try_cast(averagerate as double) as taxa_media_cambio
            , try_cast(endofdayrate as double) as taxa_fim_dia
            , try_cast(currencyratedate as date) as data_taxa_cambio
            , try_cast(modifieddate as date) as data_modificacao
        from currencyrate
    )

select *
from renomear