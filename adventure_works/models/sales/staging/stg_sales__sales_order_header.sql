{{ config(schema='sales') }}

with
    sales_order_header as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESORDERHEADER') }}
    )

    , renomear as (
        select
            cast(salesorderid as int) as pk_pedido_venda
            , cast(customerid as int) as fk_cliente
            , cast(salespersonid as int) as fk_vendedor
            , cast(territoryid as int) as fk_territorio
            , cast(billtoaddressid as int) as fk_endereco_faturamento
            , cast(shiptoaddressid as int) as fk_endereco_envio
            , cast(shipmethodid as int) as fk_metodo_envio
            , cast(creditcardid as int) as fk_cartao_credito
            , cast(currencyrateid as int) as fk_taxa_cambio
            , case
                when status = 1 then 'Em processo'
                when status = 2 then 'Aprovado'
                when status = 3 then 'Pedido em espera'
                when status = 4 then 'Rejeitado'
                when status = 5 then 'Enviado'
                when status = 6 then 'Cancelado'
            end as status_pedido
            , cast(revisionnumber as int) as numero_revisao
            , cast(onlineorderflag as boolean) as indicador_pedido_online
            , cast(purchaseordernumber as string) as numero_ordem_compra
            , cast(accountnumber as string) as numero_conta
            , cast(creditcardapprovalcode as string) as codigo_aprovacao_cartao
            , cast(totaldue as float) as total_pagar
            , cast(subtotal as float) as subtotal
            , cast(taxamt as float) as valor_imposto
            , cast(freight as float) as frete
            , cast(comment as string) as comentario
            , cast(orderdate as date) as data_pedido
            , cast(duedate as date) as data_vencimento
            , cast(shipdate as date) as data_envio
            , cast(modifieddate as date) as data_modificacao
        from sales_order_header
    )

select *
from renomear