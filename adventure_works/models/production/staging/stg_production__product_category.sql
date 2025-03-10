{{ config(schema='production')}}

with
    product_category as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PRODUCTCATEGORY') }}
    )

    , renomear as (
        select
            try_cast(PRODUCTCATEGORYID as int) as pk_categoria_produto
            , try_cast(NAME as string) as nome_categoria
            , try_cast(ROWGUID as string) as rowguid
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from product_category
    )

select *
from renomear