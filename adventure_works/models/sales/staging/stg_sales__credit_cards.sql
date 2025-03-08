{{ config(schema='sales') }}

with
    creditcard as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'CREDITCARD') }}
    )
    
    , renomear as (
        select
            try_cast(creditcardid as int) as pk_cartao_credito
            , try_cast(cardtype as string) as tipo_cartao
            , try_cast(cardnumber as int) as numero_cartao
            , try_cast(expmonth as int) as mes_expiracao
            , try_cast(expyear as int) as ano_expiracao
            , try_cast(modifieddate as date) as data_modificacao
        from creditcard
    )
select *
from renomear