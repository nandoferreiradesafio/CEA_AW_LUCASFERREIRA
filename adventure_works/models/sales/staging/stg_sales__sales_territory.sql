with
    sales_territory as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESTERRITORY') }}
    )

    , renomear as (
        select
            cast(territoryid as int) as pk_territorio_venda 
            , case
                when name = 'Australia' then 'Austrália'
                when name = 'Canada' then 'Canadá'
                when name = 'Germany' then 'Alemanha'
                when name = 'France' then 'França'
                when name = 'United Kingdom' then 'Reino Unido'
                when name = 'Southeast' then 'Sudeste'
                when name = 'Northwest' then 'Noroeste'
                when name = 'Southwest' then 'Sudoeste'
                when name = 'Central' then 'Central'
                when name = 'Northeast' then 'Nordeste'
            end as nome_territorio
            , cast(countryregioncode as string) as codigo_regiao_pais
            , cast("group" as string) as grupo
            , cast(salesytd as double) as vendas_ano_atual
            , cast(saleslastyear as double) as vendas_ano_anterior
            , cast(costytd as int) as custo_ano_atual
            , cast(costlastyear as int) as custo_ano_anterior
            , cast(rowguid as string) as rowguid
            , cast(modifieddate as date) as data_modificacao
        from sales_territory
    )

select *
from renomear