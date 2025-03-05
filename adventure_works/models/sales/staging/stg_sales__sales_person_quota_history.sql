with
    source as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESPERSONQUOTAHISTORY') }}
    )

    , renamed as (
        select
            BusinessEntityID as fk_sales_person
            , QuotaDate as quota_date
            , SalesQuota as sales_quota
            , rowguid
            , ModifiedDate as modified_date
        from source
    )

    , surrogate as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_sales_person'
                , 'quota_date'
            ]) }} as sk_sales_person_quota_history
            , *
        from renamed
    )

select *
from surrogate