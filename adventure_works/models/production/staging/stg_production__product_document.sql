{{ config(schema='production') }}

with
    product_document as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PRODUCTDOCUMENT') }}
    )

    , renomear as (
        select
            try_cast(PRODUCTID as int) as fk_produto
            , try_cast(DOCUMENTNODE as int) as no_documento
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from product_document
    )

    , numeradas as (
        select
            *,
            row_number() over (
                partition by fk_produto, no_documento
                order by data_modificacao desc
            ) as rn
        from renomear
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_produto'
                , 'no_documento'
            ]) }} as sk_produto_documento
            , fk_produto
            , no_documento
            , data_modificacao
        from numeradas
        where rn = 1
    )

select *
from chave_estrangeira