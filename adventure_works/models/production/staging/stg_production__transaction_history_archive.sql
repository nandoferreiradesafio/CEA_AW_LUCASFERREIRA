{{ config(schema='production')}}

with
    transaction_history_archive as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'TRANSACTIONHISTORYARCHIVE')}}
    )

    , renomear as (
        select
            try_cast(transactionid as int) as pk_transacao_historico_arquivo
            , try_cast(productid as int) as fk_produto
            , try_cast(referenceorderid as int) as fk_referencia_pedido
            , try_cast(referenceorderlineid as int) as fk_referencia_linha_pedido
            , try_cast(quantity as int) as quantidade
            , try_cast(actualcost as double) as custo_atual
            , try_cast(transactiontype as string) as tipo_transacao
            , try_cast(transactiondate as date) as data_transacao
            , try_cast(modifieddate as date) as data_modificacao
        from transaction_history_archive
    )

select *
from renomear