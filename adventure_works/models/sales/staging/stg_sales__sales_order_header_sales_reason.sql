{{ config(schema='sales') }}

with
    sales_order_header_sales_reason as(
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESORDERHEADERSALESREASON') }}
    )

    , renomear as (
        select
            try_cast(salesorderid as int) as fk_pedido_venda
            , try_cast(salesreasonid as int) as fk_razao_venda
            , try_cast(modifieddate as date) as data_modificacao
        from sales_order_header_sales_reason
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_pedido_venda'
                , 'fk_razao_venda'
            ]) }} as sk_pedido_venda_razao_venda
            , *
        from renomear
    )

select *
from chave_estrangeira