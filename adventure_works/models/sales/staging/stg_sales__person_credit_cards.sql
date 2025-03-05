with
    source as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PERSONCREDITCARD') }}
    )

    , renamed as (
        select
            BusinessEntityID as fk_person
            , CreditCardID as fk_credit_card
            , ModifiedDate as modified_date
        from source
    )

    , surrogate as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_person'
                , 'fk_credit_card'
            ]) }} as sk_person_credit_card
            , *
        from renamed
    )

select *
from surrogate