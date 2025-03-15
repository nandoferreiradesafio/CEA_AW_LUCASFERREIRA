{{ config(schema='person')}}

with
    business_entity_address as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'BUSINESSENTITYADDRESS')}}
    )

    , renomear as (
        select
            try_cast(BUSINESSENTITYID as int) as fk_entidade_empresarial
            , try_cast(ADDRESSID as int) as fk_endereco
            , try_cast(ADDRESSTYPEID as int) as fk_tipo_endereco
            , try_cast(ROWGUID as string) as rowguid
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from business_entity_address
    )

    , chave_estrageira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_entidade_empresarial'
                , 'fk_endereco'
                , 'fk_tipo_endereco'
            ]) }} as sk_endereco_entidade_empresarial
            , *
        from renomear
    )

select *
from chave_estrageira