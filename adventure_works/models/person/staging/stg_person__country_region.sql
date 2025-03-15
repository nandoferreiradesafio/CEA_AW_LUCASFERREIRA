{{ config(schema='person')}}

with
    country_region as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'COUNTRYREGION')}}
    )

    , renomear as (
        select
            try_cast(COUNTRYREGIONCODE as string) as codigo_regiao_pais
            , try_cast(NAME as string) as nome_pais
            , try_cast(MODIFIEDDATE as date) as data_modificacao 
        from country_region
    )

select *
from renomear