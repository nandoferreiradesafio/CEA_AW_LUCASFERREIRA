{{ config(schema='production')}}

with
    product_model_illustration as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PRODUCTMODELILLUSTRATION') }}
    )

    , renomear as (
        select
            try_cast(PRODUCTMODELID as int) as fk_modelo_produto
            , try_cast(ILLUSTRATIONID as int) as fk_ilustracao
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from product_model_illustration
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_modelo_produto'
                , 'fk_ilustracao'
            ]) }} as sk_modelo_produto_ilustracao
            , *
        from renomear
    )

select *
from chave_estrangeira