{{ config(schema='sales') }}

with
    dim_cartoes_credito as (
        select
            sk_cartao_credito
            , fk_cartao_credito
        from {{ ref('dim_cartoes_credito') }}
    )

    , dim_clientes as (
        select
            sk_cliente
            , pk_cliente
        from {{ ref('dim_clientes') }}
    )

    ,  dim_locais as (
        select
            sk_locais
            , fk_endereco_faturamento
        from {{ ref('dim_locais') }}
    )

    , dim_produtos as (
        select
            sk_produto
            , fk_produto
        from {{ ref('dim_produtos') }}
    )

    , dim_motivo_vendas as (
        select
            fk_pedido_venda
            , nome_motivo_agregado
        from {{ ref('dim_motivo_vendas') }}
    )

    , stg_sales__sales_order_detail as (
        select 
            fk_pedido_venda
            , fk_produto
            , quantidade_pedido
            , preco_unitario
            , desconto_preco_unitario
            , quantidade_pedido * (preco_unitario - desconto_preco_unitario) as valor_pago_produto
        from {{ ref('stg_sales__sales_order_detail') }}
    )

    , stg_sales__sales_order_header as (
        select
            pk_pedido_venda
            , fk_cliente
            , fk_vendedor
            , fk_territorio
            , fk_endereco_faturamento
            , fk_cartao_credito
            , status_pedido
            , indicador_pedido_online
            , subtotal
            , valor_imposto
            , frete
            , total_pagar
            , data_pedido
            , data_envio
        from {{ ref('stg_sales__sales_order_header') }}
    )

    , join_stg_sales__sales_order_detail as (
        select
            stg_sales__sales_order_detail.fk_pedido_venda
            , stg_sales__sales_order_detail.fk_produto
            , stg_sales__sales_order_detail.quantidade_pedido
            , stg_sales__sales_order_detail.preco_unitario
            , stg_sales__sales_order_detail.desconto_preco_unitario
            , stg_sales__sales_order_detail.valor_pago_produto
            , ifnull(dim_motivo_vendas.nome_motivo_agregado, 'Sem informacao') as motivo_agregado
        from stg_sales__sales_order_detail
        left join dim_produtos
            on dim_produtos.fk_produto = stg_sales__sales_order_detail.fk_produto
        left join dim_motivo_vendas
            on dim_motivo_vendas.fk_pedido_venda = stg_sales__sales_order_detail.fk_pedido_venda
    )

    , join_stg_sales__sales_order_header as (
        select
            stg_sales__sales_order_header.pk_pedido_venda
            , stg_sales__sales_order_header.fk_cliente
            , stg_sales__sales_order_header.fk_vendedor
            , stg_sales__sales_order_header.fk_territorio
            , stg_sales__sales_order_header.fk_endereco_faturamento
            , stg_sales__sales_order_header.fk_cartao_credito
            , stg_sales__sales_order_header.status_pedido
            , stg_sales__sales_order_header.indicador_pedido_online
            , stg_sales__sales_order_header.subtotal
            , stg_sales__sales_order_header.valor_imposto
            , stg_sales__sales_order_header.frete
            , stg_sales__sales_order_header.total_pagar
            , stg_sales__sales_order_header.data_pedido
            , stg_sales__sales_order_header.data_envio
        from stg_sales__sales_order_header
        left join dim_clientes
            on dim_clientes.pk_cliente = stg_sales__sales_order_header.fk_cliente
        left join dim_cartoes_credito
            on dim_cartoes_credito.fk_cartao_credito = stg_sales__sales_order_header.fk_cartao_credito
        left join dim_locais
            on dim_locais.fk_endereco_faturamento = stg_sales__sales_order_header.fk_endereco_faturamento
    )

    , join_fato_vendas as (
        select
            join_stg_sales__sales_order_detail.fk_pedido_venda
            , join_stg_sales__sales_order_detail.fk_produto
            , join_stg_sales__sales_order_header.fk_cliente
            , join_stg_sales__sales_order_header.fk_vendedor
            , join_stg_sales__sales_order_header.fk_territorio
            , join_stg_sales__sales_order_header.fk_endereco_faturamento
            , join_stg_sales__sales_order_header.fk_cartao_credito
            , join_stg_sales__sales_order_detail.quantidade_pedido
            , join_stg_sales__sales_order_detail.preco_unitario
            , join_stg_sales__sales_order_detail.desconto_preco_unitario
            , join_stg_sales__sales_order_detail.valor_pago_produto
            , join_stg_sales__sales_order_detail.motivo_agregado
            , join_stg_sales__sales_order_header.status_pedido
            , join_stg_sales__sales_order_header.indicador_pedido_online
            , join_stg_sales__sales_order_header.subtotal
            , join_stg_sales__sales_order_header.valor_imposto
            , join_stg_sales__sales_order_header.frete
            , join_stg_sales__sales_order_header.total_pagar
            , join_stg_sales__sales_order_header.data_pedido
            , join_stg_sales__sales_order_header.data_envio
            , {{ dbt_utils.generate_surrogate_key([
                    'join_stg_sales__sales_order_detail.fk_pedido_venda'
                    , 'join_stg_sales__sales_order_detail.fk_produto'
                    , 'join_stg_sales__sales_order_header.fk_cliente'
                    , 'join_stg_sales__sales_order_header.fk_endereco_faturamento'
                    , 'join_stg_sales__sales_order_header.fk_cartao_credito'
                    , 'join_stg_sales__sales_order_header.data_pedido'
                ]) 
            }} as sk_fato_sales
        from join_stg_sales__sales_order_detail
        left join join_stg_sales__sales_order_header
            on join_stg_sales__sales_order_header.pk_pedido_venda = join_stg_sales__sales_order_detail.fk_pedido_venda
    )

select *
from join_fato_vendas