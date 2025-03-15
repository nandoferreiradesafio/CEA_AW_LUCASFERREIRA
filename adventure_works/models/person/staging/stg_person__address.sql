{{ config(schema='person')}}

with
    address as (
        select *
        from {{source('RAW_ADVENTURE_WORKS', 'ADDRESS')}}
    )

    , renomear as (
        select
            try_cast(ADDRESSID as int) as pk_endereco
            , try_cast(STATEPROVINCEID as int) as fk_provincia_estado
            , try_cast(ADDRESSLINE1 as string) as endereco_primario
            , try_cast(ADDRESSLINE2 as string) as endereco_secundario
            , try_cast(CITY as string) as cidade
            , try_cast(POSTALCODE as string) as codigo_postal
            , try_cast(ROWGUID as string) as rowguid
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from address
    )

select *
from renomear