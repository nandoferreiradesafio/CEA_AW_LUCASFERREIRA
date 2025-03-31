/*
    Este teste garente que as vendas de 2011 estão
    corretas com o valor auditado da contabilidade.  

    soma total 2011 = 170783734.9557
*/

with
    tst_total_vendas_2011 as (
        select
            sum(total_pagar) as total_vendas
        from {{ ref('fct_vendas') }}
        where data_pedido between '2011-01-01' and '2011-12-31'
    )
    
select
    total_vendas
from tst_total_vendas_2011
where total_vendas not between 170783734.9547 and 170783734.9567
