{{ config(schema='production') }}

with
    product_model_product_description_culture as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PRODUCTMODELPRODUCTDESCRIPTIONCULTURE') }}
    )

    , renomear as (
        select
            try_cast(PRODUCTMODELID as int) as fk_modelo_produto
            , try_cast(PRODUCTDESCRIPTIONID as int) as fk_descricao_produto
            , try_cast(CULTUREID as string) as cultura
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from product_model_product_description_culture
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_modelo_produto'
                , 'fk_descricao_produto'
                , 'cultura'
            ]) }} as sk_modelo_produto_descricao_produto_cultura
            , *
        from renomear
    )

select *
from chave_estrangeira