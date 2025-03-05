with
    source as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SPECIALOFFERPRODUCT') }}
    )

    , renamed as (
        select
            SpecialOfferID as pk_special_offer_product
            , ProductID as fk_product
            , rowguid
            , ModifiedDate as modified_date
        from source
    )

    , surrogate as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'pk_special_offer_product'
                , 'fk_product'
            ]) }} as sk_special_offer_product
            , *
        from renamed
    )

select *
from surrogate