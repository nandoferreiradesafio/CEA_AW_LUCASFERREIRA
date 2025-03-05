with
    source as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SHOPPINGCARTITEM') }}
    )

    , renamed as (
        select
            ShoppingCartItemID as pk_shopping_cart_item
            , ShoppingCartID as fk_shopping_cart
            , ProductID as fk_product
            , Quantity as quantity
            , DateCreated as date_created
        from source
    )

select *
from renamed