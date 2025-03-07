with
    dados_brutos as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SPECIALOFFERPRODUCT') }}
    )

    , renomear as (
        select
            try_cast(specialofferid as int) as pk_produto_especial_oferta
            , try_cast(productid as int) as fk_produto
            , try_cast(rowguid as string) as rowguid
            , try_cast(modifieddate as date) as data_modificacao
        from dados_brutos
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'pk_produto_especial_oferta'
                , 'fk_produto'
            ]) }} as sk_produto_especial_oferta
            , *
        from renomear
    )

select *
from chave_estrangeira