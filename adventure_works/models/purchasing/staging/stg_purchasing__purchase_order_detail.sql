{{ config(schema='purchases') }}

with
    purchase_order_detail as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PURCHASEORDERDETAIL') }}
    )

    , renomear as (
        select
            try_cast("purchaseorderdetailid" as int) as pk_pedido_detalhe
            , try_cast("purchaseorderid" as int) as fk_pedido_compra
            , try_cast("productid" as int) as fk_produto
            , try_cast("orderqty" as int) as quantidade_pedido
            , try_cast("unitprice" as double) as preco_unitario
            , try_cast("receivedqty" as int) as quantidade_recebida
            , try_cast("rejectedqty" as int) as quantidade_rejeitada
            , try_cast("duedate" as date) as data_vencimento
            , try_cast("modifieddate" as date) as data_modificacao
        from purchase_order_detail
    )

select *
from renomear