{{ config(schema='human_resources') }}

with
    employee_department_history as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'EMPLOYEEDEPARTMENTHISTORY') }}
    )

    , renomear as (
        select
            try_cast(BUSINESSENTITYID as int) as fk_entidade_empresarial
            , try_cast(DEPARTMENTID as int) as fk_departamento
            , try_cast(SHIFTID as int) as fk_turno
            , try_cast(STARTDATE as date) as data_inicio
            , try_cast(ENDDATE as date) as data_fim
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from employee_department_history
    )

    , chave_estrageira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_entidade_empresarial'
                , 'fk_departamento'
                , 'fk_turno'
            ])}} as sk_historico_departamento_funcionario
            , *
        from renomear
    )

select *
from chave_estrageira
