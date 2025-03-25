{{ config(schema='sales') }}

with
    int_cartoes_credito as (
        select
            sk_cartao_credito
            , fk_cartao_credito
            , tipo_cartao
            , numero_cartao
            , mes_expiracao
            , ano_expiracao
        from {{ ref('int_cartoes_credito')}}
    )

select *
from int_cartoes_credito