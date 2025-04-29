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


# Como Instalar e Rodar um Projeto dbt

## Pré-requisitos
- Python instalado (recomendado: versão 3.8 ou superior).
- Git instalado.
- Acesso a uma conta Snowflake (ou outro banco suportado).
- Um terminal (Prompt de Comando, Terminal Mac/Linux, ou VS Code Terminal).

## Passo 1: Instalar o dbt
**1.1. Instale o dbt via pip:**
```bash
pip install dbt-snowflake
```

**1.2. Verifique se o dbt foi instalado corretamente:**
```bash
dbt --version
```

## Passo 2: Clonar o Repositório do Projeto
**2.1. Clone o projeto para sua máquina:**
```bash
git clone https://github.com/seu-usuario/seu-projeto.git
cd seu-projeto
```
(Substitua `seu-usuario/seu-projeto` pelo repositório correto.)

## Passo 3: Configurar a Conexão com o Banco de Dados
O dbt precisa saber onde e como se conectar.

**3.1. Crie o arquivo `profiles.yml`:**

No Windows: `%USERPROFILE%\.dbt\profiles.yml`  
No Mac/Linux: `~/.dbt/profiles.yml`

**Exemplo de `profiles.yml` para Snowflake:**
```yaml
adventure_works:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: seu_conta_id
      user: seu_usuario
      password: sua_senha
      role: seu_papel
      database: seu_banco
      warehouse: seu_armazem
      schema: seu_esquema
      threads: 1
      client_session_keep_alive: False
```
⚡ *Troque as informações acima para o seu ambiente.*

## Passo 4: Rodar o Projeto dbt

**4.1. Testar a conexão:**
```bash
dbt debug
```

**4.2. Compilar e executar os modelos:**
```bash
dbt run
```

**4.3. (Opcional) Rodar testes:**
```bash
dbt test
```

**4.4. (Opcional) Gerar e visualizar a documentação:**
```bash
dbt docs generate
dbt docs serve
```

## Estrutura Básica do Projeto
- `models/`: Transformações em SQL.
- `seeds/`: Arquivos CSV de dados estáticos.
- `snapshots/`: Histórico de alterações de dados.
- `macros/`: Funções SQL reutilizáveis.
- `tests/`: Testes de dados.
- `dbt_project.yml`: Arquivo de configuração principal.

## Dicas Importantes
- Esteja na pasta do projeto antes de rodar comandos.
- O dbt é declarativo: você descreve o que quer construir.
- Mantenha seu ambiente atualizado para evitar incompatibilidades.

## Problemas Comuns
- **Erro de conexão**: Revise seu `profiles.yml`.
- **Comando não encontrado**: Confirme se o dbt foi instalado corretamente.
- **Modelos não encontrados**: Confira o diretório e o `dbt_project.yml`.

## Recursos Úteis
- [Documentação oficial do dbt](https://docs.getdbt.com/)
- [Configuração de perfil Snowflake](https://docs.getdbt.com/reference/warehouse-profiles/snowflake-profile)
