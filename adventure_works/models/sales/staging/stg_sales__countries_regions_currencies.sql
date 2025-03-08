{{ config(schema='sales') }}

with
    country_region_code as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'COUNTRYREGIONCURRENCY') }}
    )

    , renomear as (
        select
            try_cast(countryregioncode as string) as codigo_regiao_pais
            , try_cast(currencycode as string) as codigo_moeda
            , try_cast(modifieddate as date) as data_modificacao
        from country_region_code
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'codigo_regiao_pais'
                , 'codigo_moeda'
            ]) }} as sk_regiao_pais_moeda
            , *
        from renomear
    )

select *
from chave_estrangeira