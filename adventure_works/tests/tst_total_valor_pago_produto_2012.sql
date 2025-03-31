/*
    Este teste garente que o valor total pago pelos produtos em 2012 estão
    corretas com o valor auditado da contabilidade.  

    soma total 2012 = 33710339.7679
*/

with
    tst_total_valor_pago_produto_2012 as (
        select
            sum(valor_pago_produto) as total_valor_pago
        from {{ ref('fct_vendas') }}
        where data_pedido between '2012-01-01' and '2012-12-31'
    )
    
select
    total_valor_pago
from tst_total_valor_pago_produto_2012
where total_valor_pago not between 33710329 and 33710349