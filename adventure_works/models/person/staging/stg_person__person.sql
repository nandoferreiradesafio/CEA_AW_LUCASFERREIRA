{{ config(schema='person') }}

with
    person as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PERSON') }}
    )

    , renomear as (
        select 
            cast(businessentityid as int) as fk_entidade_empresarial
            , case
                when persontype  = 'SC' then 'Contato da loja' 
                when persontype  = 'IN' then 'Cliente individual' 
                when persontype  = 'SP' then 'Vendedor'
                when persontype  = 'EM' then 'Funcionário' 
                when persontype  = 'VC' then 'Contato do fornecedor'
                when persontype  = 'GC' then 'Contato geral'
                else persontype
            end as tipo_pessoa
            , cast(firstname as string) as nome_primeiro
            , cast(middlename as string) as nome_do_meio
            , cast(lastname as string) as nome_ultimo
            , coalesce(trim(concat_ws(' ', firstname, middlename, lastname)),'') as nome_completo
            , cast(namestyle as boolean) as nome_estilo
            , cast(title as string) as titulo
            , cast(suffix as string) as sufixo
            , cast(emailpromotion as int) as promocao_email
            , cast(additionalcontactinfo as string) as informacao_contato_adicional
            , cast(demographics as string) as dados_demograficos
            , cast(modifieddate as date) as data_modificacao
        from person
    )

    , chave_estrageira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_entidade_empresarial'
                , 'nome_completo'
                , 'tipo_pessoa'
            ]) }} as sk_pessoa
        , *
        from renomear
    )

select *
from chave_estrageira
