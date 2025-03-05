with
    source as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESREASON') }}
    )

    , renamed as (
        select
            SalesReasonID as pk_sales_reason
            , name as name_sales_reason
            , ReasonType as reason_type
            , ModifiedDate as modified_date
        from source
    )

select *
from renamed