{{ config(schema='production') }}

with
    work_order as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'WORKORDER')}}
    )

    , renomear as (
        select
            try_cast(WORKORDERID as int) as pk_registro_trabalho
            , try_cast(PRODUCTID as int) as fk_produto
            , try_cast(SCRAPREASONID as int) as fk_motivo_descarte
            , try_cast(ORDERQTY as int) as quantidade_pedido
            , try_cast(SCRAPPEDQTY as int) as quantidade_descartada
            , try_cast(STARTDATE as date) as data_inicio
            , try_cast(ENDDATE as date) as data_fim
            , try_cast(DUEDATE as date) as data_vencimento
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from work_order
    )

select *
from renomear