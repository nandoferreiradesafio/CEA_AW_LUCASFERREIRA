{{ config(schema='purchases') }}

with
    vendor as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'VENDOR') }}
    )

    , renomear as (
        select
            try_cast(accountnumber as string) as pk_fornecedor
            , try_cast(businessentityid as int) as fk_entidade_empresarial
            , try_cast(name as string) as nome_empresa
            , try_cast(creditrating as int) as classificacao_credito
            , try_cast(preferredvendorstatus as boolean) as status_fornecedor_preferencial
            , try_cast(activeflag as boolean) as indicador_fornecedor_ativo
            , try_cast(purchasingwebserviceurl as string) as url_servico_web_compras
            , try_cast(modifieddate as date) as data_modificacao
        from vendor
    )

select *
from renomear