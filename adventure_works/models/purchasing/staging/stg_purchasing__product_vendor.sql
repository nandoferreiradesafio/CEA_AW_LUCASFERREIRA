{{ config(schema='purchases') }}

with
    product_vendor as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PRODUCTVENDOR') }}
    )

    , renomear as (
        select
            try_cast(productid as int) as fk_produto
            , try_cast(businessentityid as int) as fk_entidade_empresarial
            , try_cast(averageleadtime as int) as tempo_medio_entrega
            , try_cast(standardprice as double) as preco_padrao
            , try_cast(lastreceiptcost as double) as custo_ultima_recebimento
            , try_cast(minorderqty as int) as quantidade_minima_pedido
            , try_cast(maxorderqty as int) as quantidade_maxima_pedido
            , try_cast(onorderqty as int) as quantidade_em_pedido
            , try_cast(unitmeasurecode as string) as codigo_unidade_medida
            , try_cast(lastreceiptdate as date) as data_ultima_recebimento
            , try_cast(modifieddate as date) as data_modificacao
        from product_vendor
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_produto'
                , 'fk_entidade_empresarial'
            ])}} as sk_fornecedor_produto
            , *
        from renomear
    )

select *
from chave_estrangeira