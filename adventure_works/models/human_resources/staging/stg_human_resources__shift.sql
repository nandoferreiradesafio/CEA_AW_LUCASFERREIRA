{{ config(schema='human_resources') }}

with
    shift as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SHIFT') }}
    )

    , renomear as (
        select
            try_cast(SHIFTID as int) as pk_turno
            , case
                when name = 'Day' then 'Dia'
                when name = 'Evening' then 'Tarde'
                when name = 'Night' then 'Noite'
                else name
            end as nome_turno
            , try_cast(STARTTIME as string) as hora_inicio
            , try_cast(ENDTIME as string) as hora_fim
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from shift
    )

select *
from renomear
