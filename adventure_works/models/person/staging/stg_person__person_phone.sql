{{ config(schema='person') }}

with
    person_phone as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PERSONPHONE') }}
    )

    , renomear as (
        select
            try_cast(BUSINESSENTITYID as int) as fk_entidade_empresarial
            , try_cast(PHONENUMBER as string) as numero_telefone
            , try_cast(PHONENUMBERTYPEID as int) as tipo_telefone
            , try_cast(MODIFIEDDATE as date) as data_modificaca
        from person_phone
    )

    , chave_estrageira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_entidade_empresarial'
                , 'numero_telefone'
                , 'tipo_telefone'
            ]) }} as sk_telefone_pessoa
            , *
        from renomear
    )

select *
from chave_estrageira
