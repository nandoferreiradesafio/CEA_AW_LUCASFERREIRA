with
    sales_order_detail as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESORDERDETAIL') }}
    )

    , renomear as (
        select
            try_cast(salesorderdetailid as int) as pk_detalhe_pedido_venda
            , try_cast(salesorderid as int) as fk_pedido_venda
            , try_cast(productid as int) as fk_produto
            , try_cast(specialofferid as int) as fk_oferta_especial
            , try_cast(carriertrackingnumber as string) as numero_rastreio_transportadora
            , try_cast(orderqty as int) as quantidade_pedido
            , try_cast(unitprice as double) as preco_unitario
            , try_cast(unitpricediscount as double) as desconto_preco_unitario
            , try_cast(rowguid as string) as rowguid
            , try_cast(modifieddate as date) as data_modificacao
        from sales_order_detail
    )

select *
from renomear
