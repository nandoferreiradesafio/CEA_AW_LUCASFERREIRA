with
    source as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESORDERDETAIL') }}
    )

    , renamed as (
        select
            SalesOrderDetailID as pk_sales_order_detail
            , SalesOrderID as fk_sales_order
            , ProductID as fk_product
            , SpecialOfferID as fk_special_offer
            , CarrierTrackingNumber as carrier_tracking_number
            , OrderQty as order_qty
            , UnitPrice as unit_price
            , UnitPriceDiscount as unit_price_discount
            , rowguid
            , ModifiedDate as modified_date
        from source
    )

select *
from renamed
