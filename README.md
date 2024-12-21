# Desafio técnico e-commerce

## Estrutura do Projeto

- Models: Lógica principal do domínio `Cart` e `CartItem`.
- Controllers: Gerenciamento de requisições HTTP no `CartsController`.
- Jobs: Processamento de tarefas em segundo plano, no `AbandonedCartJob`.
- Routes: Definições de rotas da API em `config/routes.rb`.

## Funcionalidades 🚀

- Adicionar Produto ao Carrinho ✔️ 

  ``
  POST /cart/add_product: Adiciona um produto ao carrinho.
  Payload: { "product_id": 1 }
  ``

- Atualizar Quantidade de um Produto:

  ``
  PATCH /cart/update_product_quantity: Atualiza a quantidade de um produto no carrinho.
  Payload: { "product_id": 1, "quantity": 2 }
  ``

- Remover Produto do Carrinho: 

  ``
  DELETE /cart/remove_product/:product_id:
  ``

- Visualizar Carrinho:

  ``
  GET /cart: Retorna os produtos no carrinho.
  ``

- Limpeza Automática: 

  Job `AbandonedCartJob` em segundo plano marca carrinhos como abandonados após 3 horas de inatividade e remove carrinhos abandonados após 7 dias.

## Tecnologias Utilizadas 🛠

- Ruby on Rails: Framework principal do projeto.
- Sidekiq: Para o processamento de tarefas em segundo plano.
- Redis: Usado pelo Sidekiq para filas de trabalho.
- Postgres: Banco de dados utilizado no ambiente de desenvolvimento.
- RSpec: Para testes automatizados.
- FactoryBot: Para estruturação dos testes

## Como executar o projeto

clone o repositório
```bash
git clone https://github.com/seu-usuario/seu-repositorio.git
cd seu-repositorio
```

Instalar as dependências do:
```bash
bundle install
```

Executar o sidekiq:
```bash
bundle exec sidekiq
```

Executar projeto:
```bash
bundle exec rails server
```

Executar os testes:
```bash
bundle exec rspec

