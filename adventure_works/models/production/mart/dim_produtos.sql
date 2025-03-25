{{ config(schema='production') }}

with
    int_produtos as (
        select
            sk_produto
            , fk_produto
            , fk_subcategoria_produto
            , nome_produto
            , nome_categoria
            , nome_subcategoria
        from {{ ref('int_produtos') }}
    )

select *
from int_produtos