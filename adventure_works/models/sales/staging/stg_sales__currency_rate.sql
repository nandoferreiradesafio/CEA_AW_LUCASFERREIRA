with
    source as(
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'CURRENCYRATE') }}
    )

    , renamed as(
        select
            CurrencyRateID as pk_currency_rate
            , CurrencyRateDate as fk_currency_rate_date
            , FromCurrencyCode as fk_from_currency
            , ToCurrencyCode as fk_to_currency
            , AverageRate as average_rate
            , EndOfDayRate as end_of_day_rate
            , ModifiedDate as modified_date
        from source
    )

select *
from renamed