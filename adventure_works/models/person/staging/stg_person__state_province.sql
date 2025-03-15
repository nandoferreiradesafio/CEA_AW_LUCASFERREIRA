{{ config(schema='person') }}

with
    state_province as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'STATEPROVINCE') }}
    )

    , renomear as (
        select
            try_cast(STATEPROVINCEID as int) as pk_estado_provincia
            , try_cast(TERRITORYID as int) as fk_territorio
            , try_cast(STATEPROVINCECODE as string) as codigo_estado_provincia
            , try_cast(COUNTRYREGIONCODE as string) as codigo_regiao_pais
            , try_cast(NAME as string) as nome_estado_provincia
            , try_cast(ISONLYSTATEPROVINCEFLAG as boolean) as indicador_estado_provincia_unico
            , try_cast(ROWGUID as string) as rowguid
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from state_province
    )

select *
from renomear
