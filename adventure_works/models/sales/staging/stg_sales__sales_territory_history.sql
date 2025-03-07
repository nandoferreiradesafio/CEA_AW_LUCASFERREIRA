with
    sales_territory_history as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESTERRITORYHISTORY') }}
    )

    , renomear as (
        select
            try_cast(territoryid as int) as fk_territorio_vendas
            , try_cast(businessentityid as int) as fk_entidade_empresarial
            , try_cast(rowguid as string) as rowguid
            , try_cast(startdate as date) as data_inicio
            , try_cast(enddate as date) as data_final
            , try_cast(modifieddate as date) as data_modificacao
        from sales_territory_history
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_territorio_vendas'
                , 'fk_entidade_empresarial'
            ]) }} as sk_historico_territorio_vendas
            , *
        from renomear
    )

select *
from chave_estrangeira