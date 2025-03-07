with
    person_credit_card as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PERSONCREDITCARD') }}
    )

    , renomear as (
        select
            try_cast(businessentityid as int) as fk_entidade_empresarial
            , try_cast(creditcardid as int) as fk_cartao_credito
            , try_cast(modifieddate as date) as data_modificacao
        from person_credit_card
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_entidade_empresarial'
                , 'fk_cartao_credito'
            ]) }} as sk_pessoa_cartao_credito
            , *
        from renomear
    )

select *
from chave_estrangeira