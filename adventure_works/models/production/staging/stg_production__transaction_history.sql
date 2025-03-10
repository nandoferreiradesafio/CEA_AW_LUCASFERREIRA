{{ config(schema='production')}}

with
    transaction_history as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'TRANSACTIONHISTORY') }}
    )

    , renomear as (
        select
            try_cast(TRANSACTIONID as int) as pk_transacao_historico
            , try_cast(PRODUCTID as int) as fk_produto
            , try_cast(REFERENCEORDERID as int) as pedido_referencia
            , try_cast(REFERENCEORDERLINEID as int) as linha_pedido_referencia
            , try_cast(TRANSACTIONTYPE as string) as tipo_transacao
            , try_cast(QUANTITY as int) as quantidade
            , try_cast(ACTUALCOST as double) as custo_real
            , try_cast(TRANSACTIONDATE as date) as data_transacao
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from transaction_history
    )

select *
from renomear