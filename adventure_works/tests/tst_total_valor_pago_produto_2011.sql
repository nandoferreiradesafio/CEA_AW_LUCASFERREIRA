/*
    Este teste garente que o valor total pago pelos produtos em 2011 estão
    corretas com o valor auditado da contabilidade.  

    soma total 2011 = 12646096.6307
*/

with
    tst_total_valor_pago_produto_2011 as (
        select
            sum(valor_pago_produto) as total_valor_pago
        from {{ ref('fct_vendas') }}
        where data_pedido between '2011-01-01' and '2011-12-31'
    )
    
select
    total_valor_pago
from tst_total_valor_pago_produto_2011
where total_valor_pago not between 12646086 and 12647006