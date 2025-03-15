{{ config(schema='person')}}

with
    contact_type as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'CONTACTTYPE')}}
    )

    , renomear as (
        select
            try_cast(CONTACTTYPEID as int) as pk_tipo_contato
            , try_cast(NAME as string) as nome_tipo_contato
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from contact_type
    )

select *
from renomear