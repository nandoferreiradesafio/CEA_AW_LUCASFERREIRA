with
    source as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'COUNTRYREGIONCURRENCY') }}
    )

    , renamed as (
        select
            CountryRegionCode as country_region_code
            , CurrencyCode as currency_code
            , ModifiedDate as modified_date
        from source
    )

    , surrogate as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'country_region_code'
                , 'currency_code'
            ]) }} as sk_country_region_currency
            , *
        from renamed
    )

select *
from surrogate