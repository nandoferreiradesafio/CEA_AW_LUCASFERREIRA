{{ config(schema='purchases') }}

with
    purchase_order_header as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PURCHASEORDERHEADER')}}
    )

    , renomear as (
        select
            try_cast(purchaseorderid as int) as pk_pedido_cabecalho
            , try_cast(employeeid as int) as fk_funcionario
            , try_cast(vendorid as int) as fk_fornecedor
            , try_cast(shipmethodid as int) as fk_metodo_envio
            , try_cast(status as int) as status_pedido
            , try_cast(revisionnumber as int) as numero_revisao
            , try_cast(subtotal as double) as subtotal
            , try_cast(taxamt as double) as imposto
            , try_cast(freight as double) as frete
            , try_cast(orderdate as date) as data_pedido
            , try_cast(shipdate as date) as data_envio
            , try_cast(modifieddate as date) as data_modificacao
        from purchase_order_header
    )

select *
from renomear