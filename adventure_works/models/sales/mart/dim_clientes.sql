{{ config(schema='sales') }}

with
    int_clientes as (
        select
            sk_cliente
            , pk_cliente
            , fk_pessoa
            , fk_entidade_empresarial
            , nome_completo
            , nome_loja
        from {{ ref('int_clientes') }}
    )

select *
from int_clientes