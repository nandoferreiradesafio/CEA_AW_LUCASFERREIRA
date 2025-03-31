/*
    Este teste garente que as vendas de 2012 estão
    corretas com o valor auditado da contabilidade.  

    soma total 2012 = 972777341.2287
*/

with
    tst_total_vendas_2012 as (
        select
            sum(total_pagar) as total_vendas
        from {{ ref('fct_vendas') }}
        where data_pedido between '2012-01-01' and '2012-12-31'
    )
    
select
    total_vendas
from tst_total_vendas_2012
where total_vendas not between 972777341.2277 and 972777341.2297
