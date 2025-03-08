{{ config(schema='sales') }}

with
    sales_person as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESPERSON') }}
    )

    , renomear as (
        select
            try_cast(businessentityid as int) as fk_entidade_empresarial
            , try_cast(territoryid as int) as fk_territorio
            , try_cast(salesquota as int) as vendas_quota
            , try_cast(bonus as int) as bonus
            , try_cast(commissionpct as double) as porcentagem_comissao
            , try_cast(salesytd as double) as vendas_total_ano_ate_momento
            , try_cast(saleslastyear as double) as vendas_total_ano_passado
            , try_cast(rowguid as string) as rowguid
            , try_cast(modifieddate as date) as data_modificacao
        from sales_person
    )

    , chave_estrangeira as (
        select 
            {{ dbt_utils.generate_surrogate_key([
                'fk_entidade_empresarial'
                , 'fk_territorio'
            ])}} as sk_vendedor
        from renomear
    )

select *
from chave_estrangeira