with
    source as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SPECIALOFFER') }}
    )

    , renamed as (
        select
            SpecialOfferID as pk_special_offer
            , description as description_special_offer
            , DiscountPct as discount_pct
            , type as type_special_offer
            , category as category_special_offer
            , MinQty as min_qty
            , MaxQty as max_qty
            , rowguid
            , StartDate as start_date
            , EndDate as end_date
            , ModifiedDate as modified_date
        from source
    )

select *
from renamed