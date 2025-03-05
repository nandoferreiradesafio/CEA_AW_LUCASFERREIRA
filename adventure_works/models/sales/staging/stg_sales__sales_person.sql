with
    source as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESPERSON') }}
    )

    , renamed as (
        select
            BusinessEntityID as pk_sales_person
            , TerritoryID as fk_territory
            , SalesQuota as sales_quota
            , Bonus as bonus
            , CommissionPct as commission_pct
            , SalesYTD as sales_ytd
            , SalesLastYear as sales_last_year
            , rowguid
            , ModifiedDate as modified_date
        from source
    )

select *
from renamed