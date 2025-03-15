{{ config(schema='person') }}

with
    email_address as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'EMAILADDRESS') }}
    )

    , renomear as (
        select
            try_cast(EMAILADDRESSID as int) as pk_email
            , try_cast(BUSINESSENTITYID as int) as fk_entidade_empresarial
            , try_cast(EMAILADDRESS as string) as endereco_email
            , try_cast(ROWGUID as string) as rowguid
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from email_address
    )

select *
from renomear
