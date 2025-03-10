{{ config(schema='production') }}

with
    work_order_routing as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'WORKORDERROUTING')}}
    )

    , renomear as (
        select
            try_cast(WORKORDERID as int) as fk_registro_trabalho
            , try_cast(PRODUCTID as int) as fk_produto
            , try_cast(LOCATIONID as int) as fk_localizacao
            , try_cast(OPERATIONSEQUENCE as int) as sequencia_operacao
            , try_cast(ACTUALRESOURCEHRS as double) as recursos_reais
            , try_cast(PLANNEDCOST as double) as custo_planejado
            , try_cast(ACTUALCOST as double) as custo_real
            , try_cast(SCHEDULEDSTARTDATE as date) as data_inicio_programacao
            , try_cast(SCHEDULEDENDDATE as date) as data_fim_programacao
            , try_cast(ACTUALSTARTDATE as date) as data_inicio_real
            , try_cast(ACTUALENDDATE as date) as data_fim_real
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from work_order_routing
    )

    , chave_estrangeira as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'fk_registro_trabalho'
                , 'fk_produto'
                , 'fk_localizacao'
            ]) }} as sk_detalhes_registro_trabalho
            , *
        from renomear
    )

select *
from chave_estrangeira