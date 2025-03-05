with
    source as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESTERRITORYHISTORY') }}
    )

    , renamed as (
        select
            TerritoryID as fk_sales_territory
            , BusinessEntityID as fk_business_entity
            , rowguid
            , StartDate as start_date
            , EndDate as end_date
            , ModifiedDate as modified_date
        from source
    )

    , surrogate as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_sales_territory'
                , 'fk_business_entity'
            ]) }} as sk_sales_territory_history
            , *
        from renamed
    )

select *
from surrogate