with
    source as(
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESORDERHEADERSALESREASON') }}
    )

    , renamed as (
        select
            SalesOrderID as fk_sales_order_header
            , SalesReasonID as fk_sales_reason
            , ModifiedDate as modified_date
        from source
    )

    , surrogate as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_sales_order_header'
                , 'fk_sales_reason'
            ]) }} as sk_sales_order_header_sales_reason
            , *
        from renamed
    )

select *
from surrogate