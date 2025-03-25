{{ config(schema='person') }}

with
    stg_person__country_region as (
        select 
            *
        from {{ ref('stg_person__country_region') }}
    )

    , stg_person__address as (
        select
            *
        from {{ ref('stg_person__address') }}
    )

    , stg_person__state_province as (
        select
            *
        from {{ ref('stg_person__state_province') }}
    )

    , stg_sales__sales_order_header as (
        select
            *
        from {{ ref('stg_sales__sales_order_header') }}
    )

    ,  transformacao_locais as (
        select
            distinct(stg_sales__sales_order_header.fk_endereco_faturamento)
            , stg_person__country_region.nome_pais
            , stg_person__address.nome_cidade
            , stg_person__state_province.nome_estado_provincia
        from stg_sales__sales_order_header
        left join stg_person__address
            on stg_sales__sales_order_header.fk_endereco_envio = stg_person__address.pk_endereco
        left join stg_person__state_province
            on stg_person__state_province.pk_estado_provincia = stg_person__address.fk_provincia_estado
        left join stg_person__country_region
            on stg_person__country_region.codigo_regiao_pais = stg_person__state_province.codigo_regiao_pais
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_endereco_faturamento'
                , 'nome_pais'
            ]) }} as sk_locais
            , *
        from transformacao_locais
    )

select *
from chave_estrangeira