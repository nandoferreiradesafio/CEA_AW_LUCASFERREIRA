{{ config(schema='production')}}

with
    product_model as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PRODUCTMODEL') }}
    )

    , renomear as (
        select
            try_cast(PRODUCTMODELID as int) as pk_modelo_produto
            , try_cast("NAME" as string) as nome_produto
            , try_cast(CATALOGDESCRIPTION as string) as descricao_catalogo
            , try_cast(INSTRUCTIONS as string) as instrucoes
            , try_cast(ROWGUID as string) as rowguid
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from product_model
    )

select *
from renomear