{{ config(schema='sales') }}

with
    customer as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'CUSTOMER') }}
    )

    , renomear as (
        select
            try_cast(customerid as int) as pk_cliente
            , try_cast(personid as int) as fk_pessoa
            , try_cast(storeid as int) as fk_loja
            , try_cast(territoryid as int) as fk_territorio
            , try_cast(rowguid as string) as rowguid
            , try_cast(modifieddate as date) as data_modificacao
        from customer
    )

select *
from renomear