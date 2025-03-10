{{ config(schema='production') }}

with
    bill_of_materials as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'BILLOFMATERIALS') }}
    )

    , renomear as (
        select
            try_cast("billofmaterialsid" as int) as pk_lista_materiais
            , try_cast("productassemblyid" as int) as fk_produto_montado
            , try_cast("componentid" as int) as fk_componente
            , try_cast("unitmeasurecode" as string) as codigo_unidade_medida
            , try_cast("bomlevel" as int) as nivel_lista_materiais
            , try_cast("perassemblyqty" as int) as quantidade_por_montagem
            , try_cast("startdate" as date) as data_inicio
            , try_cast("enddate" as date) as data_fim
            , try_cast("modifieddate" as date) as data_modificacao
        from bill_of_materials
    )

select *
from renomear