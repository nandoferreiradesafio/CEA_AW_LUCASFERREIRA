with
    store as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'STORE') }}
    )

    , renomear as (
        select
            try_cast(businessentityid as int) as pk_entidade_negocio 
            , try_cast(salespersonid as int) as fk_vendedor
            , try_cast(name as string) as nome_loja
            , try_cast(demographics as string) as dados_demograficos
            , try_cast(rowguid as string) as rowguid
            , try_cast(modifieddate as date) as data_modificacao
        from store
    )

select *
from renomear