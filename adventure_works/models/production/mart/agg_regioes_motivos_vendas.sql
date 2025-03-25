{{ config(schema='production') }}

with
    stg_person__country_region as (
        select 
            codigo_regiao_pais
            , nome_pais
        from {{ ref('stg_person__country_region') }}
    )

    , stg_person__state_province as (
        select
            pk_estado_provincia
            , codigo_regiao_pais
            , nome_estado_provincia
        from {{ ref('stg_person__state_province') }}
    )

    , stg_person__address as (
        select
            pk_endereco
            , fk_provincia_estado
            , nome_cidade
        from {{ ref('stg_person__address') }}
    )

    , stg_sales__sales_order_header as (
        select
            pk_pedido_venda
            , fk_endereco_faturamento
            , fk_endereco_envio
            , fk_cliente
            , data_pedido
        from {{ ref('stg_sales__sales_order_header') }}
    )

    , join_enderecos as (
        select
            stg_sales__sales_order_header.fk_endereco_faturamento
            , stg_person__country_region.nome_pais
            , stg_person__state_province.nome_estado_provincia
            , stg_person__address.nome_cidade
        from stg_sales__sales_order_header
        left join stg_person__address
            on stg_person__address.pk_endereco = stg_sales__sales_order_header.fk_endereco_envio
        left join stg_person__state_province
            on stg_person__state_province.pk_estado_provincia = stg_person__address.fk_provincia_estado
        left join stg_person__country_region
            on stg_person__country_region.codigo_regiao_pais = stg_person__state_province.codigo_regiao_pais
    )

    , stg_sales__customers as (
        select
            pk_cliente
            , fk_pessoa
            , fk_loja
        from {{ ref('stg_sales__customers') }}
    )

    , stg_sales__stores as (
        select
            fk_entidade_empresarial
            , nome_loja
        from {{ ref('stg_sales__stores') }}
    )

    , stg_person__person as (
        select
            fk_entidade_empresarial
            , nome_completo
        from {{ ref('stg_person__person') }}
    )

    , join_cliente as (
        select
            stg_sales__customers.pk_cliente
            , stg_sales__customers.fk_pessoa
            , stg_sales__customers.fk_loja
            , stg_sales__stores.fk_entidade_empresarial
            , stg_sales__sales_order_header.pk_pedido_venda
            , stg_sales__sales_order_header.fk_endereco_faturamento
            , coalesce(stg_sales__stores.nome_loja, 'Nao Informado') as nome_loja
            , stg_person__person.nome_completo
            , stg_sales__sales_order_header.data_pedido
        from stg_sales__sales_order_header
        left join stg_sales__customers
            on stg_sales__customers.pk_cliente = stg_sales__sales_order_header.fk_cliente
        left join stg_sales__stores
            on stg_sales__stores.fk_entidade_empresarial = stg_sales__customers.fk_loja
        left join stg_person__person
            on stg_person__person.fk_entidade_empresarial = stg_sales__customers.fk_pessoa
    )

    , stg_production__product as (
        select
            pk_produto
            , fk_subcategoria_produto
            , numero_produto
            , nome_produto
        from {{ ref('stg_production__product') }}
    )

    , stg_production__product_category as (
        select
            pk_categoria_produto
            , nome_categoria
        from {{ ref('stg_production__product_category') }}
    )

    , stg_production__product_subcategory as (
        select
            pk_subcategoria_produto
            , fk_categoria_produto
            , nome_subcategoria
        from {{ ref('stg_production__product_subcategory') }}
    )

    , join_produtos as (
        select
            produto.pk_produto
            , categoria_produto.pk_categoria_produto
            , subcategoria_produto.pk_subcategoria_produto
            , produto.numero_produto
            , produto.nome_produto
            , categoria_produto.nome_categoria
            , subcategoria_produto.nome_subcategoria
        from stg_production__product as produto
        left join stg_production__product_subcategory as subcategoria_produto
            on subcategoria_produto.pk_subcategoria_produto = produto.fk_subcategoria_produto
        left join stg_production__product_category as categoria_produto
            on categoria_produto.pk_categoria_produto = subcategoria_produto.fk_categoria_produto
    )

    , stg_sales__sales_order_detail as (
        select
            pk_detalhe_pedido_venda
            , fk_produto
            , fk_pedido_venda
            , quantidade_pedido
            , preco_unitario
        from {{ ref('stg_sales__sales_order_detail') }}
    )

	, join_dados_agregados as (
        select
            nome_pais
            , nome_estado_provincia
            , nome_cidade
            , nome_completo
            , nome_loja
            , nome_produto
            , nome_categoria
            , nome_subcategoria
            , numero_produto
            , quantidade_pedido
            , preco_unitario
            , data_pedido
        from join_cliente
        left join join_enderecos
            on join_enderecos.fk_endereco_faturamento = join_cliente.fk_endereco_faturamento
        left join stg_sales__sales_order_detail
            on stg_sales__sales_order_detail.fk_pedido_venda = join_cliente.pk_pedido_venda
        left join join_produtos
            on join_produtos.pk_produto = stg_sales__sales_order_detail.fk_produto
    )

select
    nome_pais,
    nome_estado_provincia,
    nome_categoria,
    sum(quantidade_pedido) as total_itens,
    sum(quantidade_pedido * preco_unitario) as receita_total
from join_dados_agregados
group by nome_pais, nome_estado_provincia, nome_categoria