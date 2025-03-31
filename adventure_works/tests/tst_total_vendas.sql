/*
    Este teste garente que as vendas estão
    corretas com o valor auditado da contabilidade.  

    soma total = 2926970124.0414

*/

with
    tst_total_vendas as (
        select
            sum(total_pagar) as total_vendas
        from {{ ref('fct_vendas') }}
    )
    
select
    total_vendas
from tst_total_vendas
where total_vendas not between 2926970124.0404 and 2926970124.0424
