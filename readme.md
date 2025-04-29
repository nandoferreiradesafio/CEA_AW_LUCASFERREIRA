# Adventure Works - Data Warehouse

## Introdução

A **Adventure Works (AW)** é uma indústria de bicicletas em rápido crescimento que está se transformando em uma empresa orientada por dados para sustentar seu crescimento e superar a concorrência. Com um portfólio robusto de mais de 500 produtos, atendendo a 20.000 clientes e gerenciando 31.000 pedidos, a AW utiliza seu Data Warehouse para fundamentar decisões estratégicas e operacionais.

## Objetivos do Projeto

- **Desenvolver um Data Warehouse Escalável e Seguro:** Utilizando a plataforma Snowflake para garantir escalabilidade, segurança e acessibilidade dos dados.
- **Transformação de Dados com dbt Cloud:** Garantir a qualidade e a integridade das informações através de práticas modernas de engenharia de dados.
- **Gerenciamento de Versionamento no GitHub:** Facilitar a colaboração e o controle de versões do projeto.
- **Criação de Dashboards Personalizados:** Desenvolver visualizações estratégicas para a diretoria e relatórios operacionais para a equipe.

## Estrutura do Data Warehouse

### Componentes Principais

1. **Configuração do Projeto (`dbt_project.yml`):**
   - Define as configurações fundamentais do projeto dbt, incluindo diretórios de modelos, sementes, snapshots e testes.

2. **Macros:**
   - Funções reutilizáveis escritas em SQL, como `generate_schema_name.sql`, para gerar nomes de esquemas dinâmicos.

3. **Modelos (`models`):**
   - **Staging (`staging/erp`):** Extrai e transforma dados brutos de sistemas ERP.
   - **Marts (`marts/comercial`):** Contém tabelas de dimensões (`dim_`) e fatos (`fact_`) para análises de vendas.
     - Exemplos: `dim_customers.sql`, `fact_sales.sql`, `agg_salesperson_salesregion.sql`

4. **Sementes (`seeds`):**
   - Arquivos CSV com dados estáticos ou de referência, organizados por áreas de negócio como `human_resources`, `production` e `sales`.

5. **Snapshots:**
   - Captura o estado dos dados em pontos específicos no tempo para análise histórica.

6. **Testes (`tests`):**
   - Scripts SQL para verificar a integridade e a qualidade dos dados, como `tst_total_vendas.sql`.

7. **Versionamento com GitHub:**
   - Controle de versões e colaboração através de branches, pull requests e revisões de código.

## Tecnologias Utilizadas

- **Snowflake:** Plataforma de Data Warehouse na nuvem para armazenamento e gerenciamento de dados.
- **dbt:** Ferramenta para orquestração e automação das transformações de dados.
- **GitHub:** Controle de versionamento e colaboração eficiente entre a equipe.
- **Power BI:** Ferramentas de visualização de dados para criação de dashboards interativos.

## Principais Funcionalidades

- **Dashboards Estratégicos:**
  - Indicadores chave de performance (KPIs) para oferecer uma visão geral da saúde e desempenho da empresa.
  
- **Relatórios Operacionais:**
  - Focados em pedidos, regiões e clientes, fornecendo insights detalhados para gerenciamento eficiente das vendas.
  
- **Modelos de Previsão de Demanda:**
  - Técnicas de Machine Learning para antecipar a demanda futura, otimizar a produção e analisar diferentes cenários estratégicos.

## Contribuição

Contribuições são bem-vindas! Por favor, abra uma *issue* ou envie um *pull request* para discutir melhorias ou novas funcionalidades.

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).
