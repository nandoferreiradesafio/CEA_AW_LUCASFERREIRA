{{ config(schema='sales') }}

with
    stg_sales__sales_reason as (
        select
            *
        from {{ ref('stg_sales__sales_reason') }}
    )

    , stg_sales__sales_order_header_sales_reason as (
        select
            *
        from {{ ref('stg_sales__sales_order_header_sales_reason') }}
    )

    , transformacao_motivo_vendas as (
        select
            stg_sales__sales_order_header_sales_reason.fk_pedido_venda
            , coalesce(listagg(stg_sales__sales_reason.nome_razao_vendas, ', '), 'Sem Motivo') as nome_motivo_agregado 
        from stg_sales__sales_order_header_sales_reason
        left join stg_sales__sales_reason
            on stg_sales__sales_reason.pk_razao_vendas = stg_sales__sales_order_header_sales_reason.fk_razao_venda
        group by fk_pedido_venda
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_pedido_venda'
                , 'nome_motivo_agregado'
            ]) }} as sk_motivo_vendas
            , *
        from transformacao_motivo_vendas
    )

select
    *
from chave_estrangeira