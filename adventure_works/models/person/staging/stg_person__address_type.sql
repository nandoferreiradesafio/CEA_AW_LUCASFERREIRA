{{config(schema='person')}}

with
    address_type as (
        select *
        from {{source('RAW_ADVENTURE_WORKS', 'ADDRESSTYPE')}}
    )

    , renomear as (
        select
            try_cast(ADDRESSTYPEID as int) as pk_tipo_endereco
            , try_cast(NAME as string) as nome_tipo_endereco
            , try_cast(ROWGUID as string) as rowguid
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from address_type
    )

select *
from renomear