{{ config(schema='production') }}

with
    product_productphoto as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PRODUCTPRODUCTPHOTO') }}
    )

    , renomear as (
        select
            try_cast(PRODUCTPHOTOID as int) as fk_foto_produto
            , try_cast(PRODUCTID as int) as fk_produto
            , try_cast(PRIMARY as boolean) as principal
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from product_productphoto
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_foto_produto'
                , 'fk_produto'
            ]) }} as sk_produto_produto_foto
            , *
        from renomear
    )

select *
from chave_estrangeira