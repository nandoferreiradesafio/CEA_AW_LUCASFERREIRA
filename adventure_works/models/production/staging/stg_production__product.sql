{{ config(schema='production') }}

with
    product as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'PRODUCT') }}
    )

    , renomear as (
        select
            try_cast(PRODUCTID as int) as pk_produto
            , try_cast(PRODUCTSUBCATEGORYID as int) as fk_subcategoria_produto
            , try_cast(PRODUCTMODELID as int) as fk_modelo_produto
            , try_cast(SIZEUNITMEASURECODE as string) as codigo_unidade_medida_tamanho
            , try_cast(WEIGHTUNITMEASURECODE as string) as codigo_unidade_medida_peso
            , try_cast("NAME" as string) as nome_produto
            , try_cast(PRODUCTNUMBER as string) as numero_produto
            , try_cast(MAKEFLAG as boolean) as flag_fabricacao
            , try_cast(FINISHEDGOODSFLAG as boolean) as flag_produto_final
            , try_cast(COLOR as string) as cor
            , try_cast(SAFETYSTOCKLEVEL as int) as nivel_estoque_seguranca
            , try_cast(REORDERPOINT as int) as ponto_reposicao
            , try_cast(STANDARDCOST as float) as custo_padrao
            , try_cast(LISTPRICE as float) as preco_lista
            , try_cast("SIZE" as string) as tamanho
            , try_cast("WEIGHT" as float) as peso
            , try_cast(DAYSTOMANUFACTURE as int) as dias_para_fabricacao
            , try_cast(CLASS as string) as linha_produto
            , try_cast(PRODUCTLINE as string) as classe
            , try_cast(STYLE as string) as estilo
            , try_cast(ROWGUID as string) as rowguid
            , try_cast(DISCONTINUEDDATE as int) as data_descontinuacao
            , try_cast(SELLSTARTDATE as date) as data_inicio_venda
            , try_cast(SELLENDDATE as date) as data_fim_venda
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from product
    )

select *
from renomear