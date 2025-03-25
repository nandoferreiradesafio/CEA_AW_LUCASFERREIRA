{{ config(schema='sales') }}

with
    stg_sales__sales_order_header as (
        select *
        from {{ ref('stg_sales__sales_order_header') }}
    )

    , stg_sales__credit_cards as (
        select *
        from {{ ref('stg_sales__credit_cards') }}
    )

    , transformacao_cartao_credito as (
        select
            distinct(stg_sales__sales_order_header.fk_cartao_credito)
            , stg_sales__credit_cards.tipo_cartao
            , stg_sales__credit_cards.numero_cartao
            , stg_sales__credit_cards.mes_expiracao
            , stg_sales__credit_cards.ano_expiracao
        from stg_sales__sales_order_header
        left join stg_sales__credit_cards
            on stg_sales__credit_cards.pk_cartao_credito = stg_sales__sales_order_header.fk_cartao_credito
        where fk_cartao_credito is not null
    )

    , chave_estrageira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_cartao_credito'
                , 'numero_cartao'
            ]) }} as sk_cartao_credito
            , *
        from transformacao_cartao_credito
    )

select *
from chave_estrageira