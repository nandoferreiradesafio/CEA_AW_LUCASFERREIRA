{{ config(schema='human_resources') }}

with
    employee as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'EMPLOYEE') }}
    )

    , renomear as (
        select
            try_cast(BUSINESSENTITYID as int) as fk_entidade_empresarial
            , try_cast(NATIONALIDNUMBER as int) as numero_identidade_nacional
            , try_cast(LOGINID as string) as id_login
            , try_cast(JOBTITLE as string) as titulo_cargo
            , try_cast(MARITALSTATUS as string) as estado_civil
            , try_cast(GENDER as string) as genero
            , try_cast(SALARIEDFLAG as boolean) as indicador_salario_fixo
            , try_cast(CURRENTFLAG as boolean) as indicador_ativo
            , try_cast(ORGANIZATIONNODE as string) as nodo_organizacional
            , try_cast(VACATIONHOURS as int) as horas_ferias
            , try_cast(SICKLEAVEHOURS as int) as horas_licenca_medica
            , try_cast(ROWGUID as string) as rowguid
            , try_cast(HIREDATE as date) as data_admissao
            , try_cast(BIRTHDATE as date) as data_nascimento
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from employee
    )

    , chave_estrageira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_entidade_empresarial'
                , 'numero_identidade_nacional'
            ]) }} as sk_funcionario
            , *
        from renomear
    )

select *
from chave_estrageira
