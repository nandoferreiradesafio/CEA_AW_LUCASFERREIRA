{{ config(schema='human_resources') }}

with
    job_candidate as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'JOBCANDIDATE') }}
    )

    , renomear as (
        select
            try_cast(JOBCANDIDATEID as int) as pk_candidato_vaga
            , try_cast(BUSINESSENTITYID as int) as fk_entidade_empresarial
            , try_cast(RESUME as string) as curriculum
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from job_candidate
    )

select *
from renomear
