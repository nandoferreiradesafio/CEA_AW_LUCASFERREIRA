{{ config(schema='person') }}

with
    phone_number_type as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PHONENUMBERTYPE') }}
    )

    , renomear as (
        select
            try_cast(PHONENUMBERTYPEID as int) as pk_tipo_telefone
            , case
                when name = 'Cell' then 'Celular'
                when name = 'Home' then 'Casa'
                when name = 'Work' then 'Trabalho'
                else 'Nulo'
            end as nome_tipo_telefone
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from phone_number_type
    )

select *
from renomear
