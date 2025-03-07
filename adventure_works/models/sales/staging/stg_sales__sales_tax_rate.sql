with
    sales_tax_rate as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESTAXRATE') }}
    )

    , renomear as (
        select
            try_cast(salestaxrateid as int) as pk_taxa_imposto_vendas
            , try_cast(stateprovinceid as int) as fk_provincia_estado
            , try_cast(taxtype as int) as taxa_tipo
            , try_cast(taxrate as double) as taxa_imposto
            , try_cast(name as string) as name_taxa_imposto
            , try_cast(rowguid as string) as rowguid
            , try_cast(modifieddate as date) as data_modificacao
        from sales_tax_rate
    )

select *
from renomear