{{ config(schema='production')}}

with
    product_description as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PRODUCTDESCRIPTION') }}
    )

    , renomear as (
        select
            try_cast(PRODUCTDESCRIPTIONID as int) as pk_descricao_produto
            , try_cast("DESCRIPTION" as string) as descricao
            , try_cast(ROWGUID as string) as guid_linha
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from product_description
    )

select *
from renomear