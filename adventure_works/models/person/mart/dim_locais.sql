{{ config(schema='person') }}

with
    int_locais as (
        select
            sk_locais
            , fk_endereco_faturamento
            , nome_pais
            , nome_cidade
            , nome_estado_provincia
        from {{ ref('int_locais') }}
    )

select *
from int_locais