{{ config(schema='production')}}

with
    product_subcategory as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PRODUCTSUBCATEGORY') }}
    )

    , renomear as (
        select
            try_cast(PRODUCTSUBCATEGORYID as int) as pk_subcategoria_produto
            , try_cast(PRODUCTCATEGORYID as int) as fk_categoria_produto
            , try_cast(NAME as string) as nome_subcategoria
            , try_cast(ROWGUID as string) as rowguid
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from product_subcategory
    )

select *
from renomear