{{ config(schema='purchases') }}

with
    ship_method as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SHIPMETHOD') }}
    )

    , renomear as (
        select
            try_cast(shipmethodid as int) as pk_metodo_envio
            , try_cast(name as string) as nome_empresa_envio
            , try_cast(shipbase as double) as base_envio
            , try_cast(shiprate as double) as taxa_envio
            , try_cast(rowguid as string) as rowguid
            , try_cast(modifieddate as date) as data_modificacao
        from ship_method
    )

select *
from renomear