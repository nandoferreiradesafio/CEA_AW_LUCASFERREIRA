{{ config(schema='person')}}

with
    business_entity_contact as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'BUSINESSENTITYCONTACT')}}
    )

    , renomear as (
        select
            try_cast(BUSINESSENTITYID as int) as fk_entidade_empresarial
            , try_cast(PERSONID as int) as fk_pessoa
            , try_cast(CONTACTTYPEID as int) as fk_tipo_contato
            , try_cast(ROWGUID as string) as rowguid
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from business_entity_contact
    )

    , chave_estrageira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_entidade_empresarial'
                , 'fk_pessoa'
                , 'fk_tipo_contato'
            ]) }} as sk_contato_entidade_empresarial
            , *
        from renomear 
    )

select *
from chave_estrageira    