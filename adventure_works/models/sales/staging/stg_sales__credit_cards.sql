with
    source as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'CREDITCARD') }}
    )

    , renamed as (
        select
            CreditCardID as pk_credit_card
            , CardType as card_type
            , CardNumber as card_number
            , ExpMonth as experation_month
            , ExpYear as experation_yaer
            , ModifiedDate as modified_date
        from source
    )

select *
from renamed