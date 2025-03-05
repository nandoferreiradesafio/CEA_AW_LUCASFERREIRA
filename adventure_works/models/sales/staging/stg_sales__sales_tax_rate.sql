with
    source as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESTAXRATE') }}
    )

    , renamed as (
        select
            SalesTaxRateID as pk_sales_tax_rate
            , stateprovinceid as fk_state_province
            , TaxType as tax_type
            , TaxRate as tax_rate
            , name
            , rowguid
            , ModifiedDate as modified_date
        from source
    )

select *
from renamed