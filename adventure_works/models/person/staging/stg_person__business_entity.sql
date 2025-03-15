{{ config(schema='person')}}

with
    business_entity as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'BUSINESSENTITY')}}
    )

    , renomear as (
        select
            try_cast(BUSINESSENTITYID as int) as pk_entidade_empresarial
            , try_cast(ROWGUID as string) as rowguid
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from business_entity
    )

select *
from renomear