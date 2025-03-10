{{ config(schema='production') }}

with
    product_cost_history as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PRODUCTCOSTHISTORY') }}
    )

    , renomear as (
        select
            try_cast(PRODUCTID as int) as fk_produto
            , try_cast(STARTDATE as date) as data_inicio
            , try_cast(ENDDATE as date) as data_fim
            , try_cast(STANDARDCOST as float) as custo_padrao
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from product_cost_history
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_produto'
                , 'data_inicio'
                , 'data_fim'
            ]) }} as sk_produto_custo_historico
            , *
        from renomear
    )

select *
from chave_estrangeira