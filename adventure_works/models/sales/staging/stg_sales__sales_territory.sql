with
    source as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESTERRITORY') }}
    )

    , renamed as (
        select
            Territoryid as pk_sales_territory
            , CountryRegionCode as country_region_code
            , name as name_sales_territory
            , "group" as sales_territory_group
            , rowguid
            , SalesYTD as sales_ytd
            , SalesLastYear as sales_last_year
            , CostLastYear as cost_last_year
            , CostYTD as cost_ytd
            , ModifiedDate as modified_date
        from source
    )

select *
from renamed