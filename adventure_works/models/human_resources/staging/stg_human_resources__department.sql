{{ config(schema='human_resources') }}

with
    department as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'DEPARTMENT') }}
    )

    , renomear as (
        select
            try_cast(DEPARTMENTID as int) as pk_departamento
            , case 
                when NAME = 'Engineering' then 'Engenharia'
                when NAME = 'Tool Design' then 'Design de Ferramentas'
                when NAME = 'Sales' then 'Vendas'
                when NAME = 'Marketing' then 'Marketing'
                when NAME = 'Purchasing' then 'Compras'
                when NAME = 'Research and Development' then 'Pesquisa e Desenvolvimento'
                when NAME = 'Production' then 'Produção'
                when NAME = 'Production Control' then 'Controle de Produção'
                when NAME = 'Human Resources' then 'Recursos Humanos'
                when NAME = 'Finance' then 'Finanças'
                when NAME = 'Information Services' then 'Serviços de Informação'
                when NAME = 'Document Control' then 'Controle de Documentos'
                when NAME = 'Quality Assurance' then 'Garantia da Qualidade'
                when NAME = 'Facilities and Maintenance' then 'Instalações e Manutenção'
                when NAME = 'Shipping and Receiving' then 'Expedição e Recebimento'
                when NAME = 'Executive' then 'Executivo'
                else NAME
            end as nome_departamento
            , try_cast(GROUPNAME as string) as nome_grupo
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from department
    )

select *
from renomear
