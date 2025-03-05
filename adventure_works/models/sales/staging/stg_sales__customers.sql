with
    source as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'CUSTOMER') }}
    )

    , renamed as (
        select
            CustomerID as pk_customer
            , PersonID as fk_person
            , StoreID as fk_store
            , TerritoryID as fk_territory
            , rowguid as rowguid
            , ModifiedDate as modified_date
        from source
    )

select *
from renamed