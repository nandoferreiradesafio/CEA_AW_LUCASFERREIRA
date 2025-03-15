{{ config(schema='sales') }}

with
    store as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'STORE') }}
    )

    , renomear as (
        select
            try_cast(businessentityid as int) as fk_entidade_empresarial
            , try_cast(salespersonid as int) as fk_vendedor
            , try_cast(name as string) as nome_loja
            , try_cast(demographics as string) as dados_demograficos
            , try_cast(rowguid as string) as rowguid
            , try_cast(modifieddate as date) as data_modificacao
        from store
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_entidade_empresarial'
                , 'fk_vendedor'
            ]) }} as sk_loja
            , *
        from renomear
    )

select *
from chave_estrangeira