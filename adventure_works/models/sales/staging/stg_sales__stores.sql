with
    source as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'STORE') }}
    )

    , renamed as (
        select
            BusinessEntityID as pk_store
            , salespersonid as fk_salesperson
            , demographics
            , Name as name_store
            , rowguid
            , ModifiedDate as modified_date
        from source
    )

select *
from renamed