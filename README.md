# PaLevá

**PaLevá** é uma aplicação desenvolvida em **Ruby on Rails** para facilitar o gerenciamento de restaurantes. A plataforma permite que proprietários de estabelecimentos organizem seus menus, pratos, bebidas e pedidos, tudo em um único lugar.

---

## Principais Funcionalidades

- **API para pedidos**: Consuma a API com o [Projeto PaLevá - Cozinha](https://github.com/marcos-grocha/paleva-cozinha-vuejs)
- **Gerenciamento de Estabelecimentos**: Cadastro de restaurantes, incluindo horários de funcionamento e informações básicas.
- **Gestão de Menus**: Criação de cardápios personalizados com pratos e bebidas.
- **Gerenciamento de Itens**:
  - Cadastro e edição de pratos com porções e recursos adicionais.
  - Cadastro e edição de bebidas, incluindo opções alcoólicas.
- **Sistema de Pedidos**: Registro e acompanhamento de pedidos realizados no restaurante.
- **Busca e Navegação**: Pesquisa de itens e menus dentro do sistema.
- **Autenticação Segura**: Utilização do Devise para autenticação de usuários proprietários.

---

## Tecnologias Utilizadas

- **Ruby on Rails**: Framework principal para desenvolvimento backend.
- **Rspec e Capybara**: Projeto todo criado usando TDD, conta com 190+ testes.
- **Bootstrap 5**: Estilização frontend responsiva.
- **Active Storage**: Gerenciamento de anexos e imagens.
- **SQLite3** ">= 1.4": Banco de dados para desenvolvimento/teste.
- **PWA (Progressive Web App)**: Suporte para service workers e manifest para experiência de aplicativo.

---

## Requisitos do Projeto

- Ruby 3.1.4
- Rails 7.2.1

---

## Como Configurar o Ambiente de Desenvolvimento

### 1. Clonar o Repositório

```bash
git clone https://github.com/marcos-grocha/paleva-app.git
cd paleva-app
```

### 2. Instalar Dependências

```bash
bundle install
```

### 3. Configurar o Banco de Dados

```bash
rails db:create db:migrate db:seed
```

### 4. Rodar o Servidor

```bash
rails server
```

---

## Usuários já disponíveis
- **Usuário Administrador**: email: user@owner.com / senha: password1234
- **Usuário Colaborador**: email: user@employee.com / senha: password1234
- Administrador extra: email: user2@owner.com / senha: password1234

---

## Testes
- O projeto conta com mais de 190 testes, pois foi construindo com desenvolvimento orientado por testes (Test Driven Development).
- Você pode roda-los com o seguinte comando

```bash
rspec
```

---

## Autor
Desenvolvido por [Marcos Guimarães Rocha](https://www.linkedin.com/in/marcos-grocha/).

![PaLevá](https://github.com/marcos-grocha/paleva-app/blob/main/app/assets/images/Screenshot/PaLev%C3%A1%20-%20Estabelecimento%20-%20Seu%20PaLev%C3%A1.png?raw=true)
