{{ config(schema='production') }}

with
    stg_sales__sales_order_header as (
        select
            *
        from {{ ref('stg_sales__sales_order_header') }}
    )

    , stg_sales__sales_order_detail as (
        select
            *
        from {{ ref('stg_sales__sales_order_detail') }}
    )

    , stg_production__product as (
        select
            *
        from {{ ref('stg_production__product') }}
    )

    , stg_production__product_category as (
        select
            *
        from {{ ref('stg_production__product_category') }}
    )

    , stg_production__product_subcategory as (
        select
            *
        from {{ ref('stg_production__product_subcategory') }}
    )

    , transformacao_produtos as (
        select 
            distinct(stg_sales__sales_order_detail.fk_produto)
            , stg_production__product.fk_subcategoria_produto
            , stg_production__product.nome_produto
            , stg_production__product_category.nome_categoria
            , stg_production__product_subcategory.nome_subcategoria
        from stg_sales__sales_order_detail
        left join stg_production__product
            on stg_sales__sales_order_detail.fk_produto = stg_production__product.pk_produto
        left join stg_production__product_subcategory
            on stg_production__product_subcategory.pk_subcategoria_produto = stg_production__product.fk_subcategoria_produto
        left join stg_production__product_category
            on stg_production__product_category.pk_categoria_produto = stg_production__product_subcategory.fk_categoria_produto
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_produto',
                'nome_produto'
            ]) }} as sk_produto
            , *
        from transformacao_produtos
    )

select *
from chave_estrangeira