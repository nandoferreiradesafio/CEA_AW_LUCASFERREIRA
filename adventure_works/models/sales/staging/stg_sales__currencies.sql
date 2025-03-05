with
    source as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'CURRENCY') }}
    )

    , renamed as (
        select
            CurrencyCode as pk_currency
            , name as namae_currency
            , ModifiedDate as modified_date
        from source
    )

select *
from renamed