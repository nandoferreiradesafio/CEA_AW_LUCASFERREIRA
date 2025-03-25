{{ config(schema='sales') }}

with
    int_motivo_vendas as(
        select
            sk_motivo_vendas
            , fk_pedido_venda
            , nome_motivo_agregado
        from {{ ref('int_motivo_vendas') }}
    )

select *
from int_motivo_vendas