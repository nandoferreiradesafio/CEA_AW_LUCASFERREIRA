{{ config(schema='sales') }}

with
    shopping_cart_itens as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SHOPPINGCARTITEM') }}
    )

    , renomear as (
        select
            try_cast(shoppingcartitemid as int) as pk_item_carrinho_compras
            , try_cast(shoppingcartid as int) as fk_carrinho_compras
            , try_cast(productid as int) as fk_produto
            , try_cast(quantity as int) as quantidade
            , try_cast(datecreated as date) as data_criacao
            , try_cast(modifieddate as date) as data_modificacao
        from shopping_cart_itens
    )

select *
from renomear