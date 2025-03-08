{{ config(schema='sales') }}

with
    sales_person_quota_history as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESPERSONQUOTAHISTORY') }}
    )

    , renomear as (
        select
            try_cast(businessentityid as int) as fk_entidade_empresarial
            , try_cast(salesquota as int) as quota_vendas
            , try_cast(rowguid as string) as rowguid
            , try_cast(quotadate as date) as data_quota
            , try_cast(modifieddate as date) as data_modificacao
        from sales_person_quota_history
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_entidade_empresarial'
                , 'data_quota'
            ]) }} as sk_historico_quota_vendedor
            , *
        from renomear
    )

select *
from chave_estrangeira