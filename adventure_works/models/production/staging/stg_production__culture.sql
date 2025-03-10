{{ config(schema='production') }}

with
    culture as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'CULTURE') }}
    )

    , renomear as (
        select
            coalesce(
                try_cast(CULTUREID as string)
                , case
                    when "NAME" = 'Invariant Language (Invariant Country)' then 'iv'
                    when "NAME" = 'Arabic' then 'ar'
                    when "NAME" = 'English' then 'en'
                    when "NAME" = 'Spanish' then 'es'
                    when "NAME" = 'French' then 'fr'
                    when "NAME" = 'Hebrew' then 'he'
                    when "NAME" = 'Thai' then 'th'
                    when "NAME" = 'Chinese' then 'zh-cht'
                    else 'nd'
                end
            ) as pk_cultura
            , try_cast("NAME" as string) as nome_cultura
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from culture
    )

select *
from renomear