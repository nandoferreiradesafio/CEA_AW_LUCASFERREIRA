with
    special_offer as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SPECIALOFFER') }}
    )

    , renomear as (
        select
            try_cast(specialofferid as int) as pk_oferta_especial
            , try_cast(description as string) as descricao_oferta_especial
            , try_cast(discountpct as double) as desconto_pct
            , try_cast(type as string) as tipo_oferta_especial
            , try_cast(category as string) as categoria_oferta_especial
            , try_cast(minqty as int) as qtd_minima
            , try_cast(maxqty as int) as qtd_maxima
            , try_cast(rowguid as string) as rowguid
            , try_cast(startdate as date) as data_inicio
            , try_cast(enddate as date) as data_fim
            , try_cast(modifieddate as date) as data_modificacao
        from special_offer
    )

select *
from renomear