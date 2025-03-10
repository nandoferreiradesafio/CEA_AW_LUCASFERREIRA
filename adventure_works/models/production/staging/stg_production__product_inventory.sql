{{ config(schema='production') }}

with
    product_inventory as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PRODUCTINVENTORY') }}
    )

    , renomear as (
        select
            try_cast(PRODUCTID as int) as fk_produto
            , try_cast(LOCATIONID as int) as fk_local
            , try_cast(SHELF as string) as prateleira
            , try_cast(BIN as int) as bin
            , try_cast(QUANTITY as int) as quantidade
            , try_cast(ROWGUID as string) as rowguid
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from product_inventory
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_produto'
                , 'fk_local'
                , 'prateleira'
                , 'bin'
            ]) }} as sk_produto_estoque
            , *
        from renomear
    )

select *
from chave_estrangeira