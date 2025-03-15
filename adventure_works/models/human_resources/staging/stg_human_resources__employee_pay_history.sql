{{ config(schema='human_resources') }}

with
    employee_pay_history as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'EMPLOYEEPAYHISTORY') }}
    )

    , renomear as (
        select
            try_cast(BUSINESSENTITYID as int) as fk_entidade_empresarial
            , try_cast(RATE as float) as taxa_pagamento
            , try_cast(PAYFREQUENCY as int) as frequencia_pagamento
            , try_cast(RATECHANGEDATE as string) as data_alteracao_taxa
            , try_cast(MODIFIEDDATE as date) as data_modificacao
        from employee_pay_history
    )

    , chave_estrageira as (
        select 
            {{ dbt_utils.generate_surrogate_key([
                'fk_entidade_empresarial'
                , 'taxa_pagamento'
            ]) }} as sk_hisotrico_pagamento_funcionario
            , *
        from renomear
    )

select *
from chave_estrageira
