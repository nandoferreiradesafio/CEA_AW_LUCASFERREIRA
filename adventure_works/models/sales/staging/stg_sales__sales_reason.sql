{{ config(schema='sales') }}

with
    sales_reason as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESREASON') }}
    )

    , renomear as (
        select
            try_cast(salesreasonid as int) as pk_razao_vendas
            , try_cast(name as string) as nome_razao_vendas
            , try_cast(reasontype as string) as tipo_razao
            , try_cast(modifieddate as date) as data_modificacao
        from sales_reason
    )

select *
from renomear