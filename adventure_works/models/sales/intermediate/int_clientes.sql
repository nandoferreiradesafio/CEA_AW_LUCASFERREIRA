{{ config(schema='sales') }}

with
    stg_sales__sales_order_header as (
        select *
        from {{ ref('stg_sales__sales_order_header') }}
    )

    , stg_sales__customers as (
        select *
        from {{ ref('stg_sales__customers') }}
    )
    
    , stg_sales__stores as (
        select *
        from {{ ref('stg_sales__stores') }}
    )

    , stg_sales__sales_territory as (
        select *
        from {{ ref('stg_sales__sales_territory') }}
    )

    , stg_person__person as (
        select *
        from {{ ref('stg_person__person') }}
    )


    , transformacao_clientes as (
        select
            stg_sales__customers.pk_cliente
            , stg_sales__customers.fk_pessoa
            , stg_sales__stores.fk_entidade_empresarial
            , stg_person__person.nome_completo
            , stg_sales__stores.nome_loja
        from stg_sales__customers
        left join stg_sales__stores
            on stg_sales__customers.fk_loja = stg_sales__stores.fk_entidade_empresarial
        left join stg_person__person
            on stg_person__person.fk_entidade_empresarial = stg_sales__customers.fk_pessoa
        left join stg_sales__sales_territory
            on stg_sales__sales_territory.pk_territorio_venda = stg_sales__customers.fk_territorio
    )

    , chave_estrageira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'pk_cliente'
                , 'fk_pessoa'
                , 'fk_entidade_empresarial'
            ]) }} as sk_cliente
            , *
        from transformacao_clientes
    )

select *
from chave_estrageira