# Blog Auth

# Blog Auth

## Descrição do Projeto

Blog Auth é uma aplicação web de blog com sistema de autenticação integrado, desenvolvida em Ruby on Rails. O projeto permite que usuários se cadastrem, façam login e publiquem posts em um blog compartilhado. Os usuários também podem interagir através de comentários nos posts. A aplicação foi projetada com foco em segurança, usabilidade e desempenho, seguindo as melhores práticas de desenvolvimento web moderno.

## Tecnologias Utilizadas

* **Ruby on Rails** - Framework web utilizado como base do projeto
* **PostgreSQL** - Sistema de gerenciamento de banco de dados relacional
* **HTML/CSS** - Estruturação e estilização das páginas
* **JavaScript** - Interatividade no lado do cliente
* **Docker** - Containerização para desenvolvimento e implantação consistentes
* **Kamal** - Ferramenta para deploy simplificado de aplicações Rails
* **Bootstrap** - Framework CSS para design responsivo
* **BCrypt** - Biblioteca para criptografia de senhas

## Arquitetura do Projeto

O Blog Auth segue a arquitetura MVC (Model-View-Controller) do Rails:

* **Models** - Representam os dados e a lógica de negócios (User, Post, Comment)
* **Views** - Interface com o usuário, renderizando HTML com Tailwind CSS
* **Controllers** - Coordenam a interação entre models e views

## Estrutura do Projeto

### Models

* **User** - Gerencia usuários, autenticação e relacionamentos com posts e comentários
* **Post** - Gerencia os posts do blog, incluindo título, conteúdo e relacionamentos com usuários e comentários
* **Comment** - Gerencia os comentários em posts, incluindo conteúdo e relacionamentos com usuários e posts

### Controllers

* **ApplicationController** - Controlador base com métodos compartilhados como autenticação
* **UsersController** - Gerencia o cadastro de novos usuários
* **SessionsController** - Gerencia o login e logout de usuários
* **PostsController** - Gerencia a criação, edição, visualização e exclusão de posts
* **CommentsController** - Gerencia a adição e remoção de comentários em posts

### Views

As views são organizadas por controlador, seguindo a convenção do Rails:

* **layouts/** - Templates base compartilhados entre as páginas
* **users/** - Formulários de cadastro e perfil de usuário
* **sessions/** - Formulários de login
* **posts/** - Listagem, visualização, criação e edição de posts
* **comments/** - Formulários e exibição de comentários (parciais)

## Configuração do Ambiente de Desenvolvimento

### Pré-requisitos

* Ruby (versão recomendada na .ruby-version)
* PostgreSQL 12 ou superior
* Node.js 14+ e Yarn
* Docker e Docker Compose (opcional, mas recomendado)
* Git

### Instalação

1. Clone o repositório:
   ```bash
   git clone https://github.com/Arruda95/Blog_auth
   cd blog_auth
   ```

2. Execute `bundle install` para instalar as dependências Ruby:
   ```bash
   bundle install
   ```

3. Configure o banco de dados (veja a seção abaixo)

4. Execute as migrações para criar o banco de dados:
   ```bash
   rails db:create db:migrate
   ```

5. (Opcional) Popule o banco com dados de exemplo:
   ```bash
   rails db:seed
   ```

6. Inicie o servidor de desenvolvimento:
   ```bash
   rails server
   ```

7. Acesse a aplicação em `http://localhost:3000`

### Configuração do Banco de Dados

Crie um arquivo `.env` na raiz do projeto com as seguintes variáveis:

```
DB_USERNAME=seu_usuario_postgres
BLOG_AUTH_DATABASE_PASSWORD=sua_senha_segura
DB_HOST=localhost
RAILS_MAX_THREADS=5
```

Consulte o arquivo `CONFIGURACAO_BD.md` para mais detalhes sobre a configuração do banco de dados.

### Desenvolvimento com Docker

Para iniciar o ambiente de desenvolvimento usando Docker:

```bash
bin/docker-entrypoint
```

## Funcionalidades Principais

### Sistema de Autenticação

* Cadastro de usuários com validação de email
* Login seguro com senhas criptografadas
* Proteção contra ataques de força bruta
* Gerenciamento de sessões
* Recuperação de senha (via email)

### Gerenciamento de Posts

* Criação, edição e exclusão de posts
* Formatação de texto com Markdown
* Upload de imagens
* Categorização de posts
* Busca por conteúdo

### Interação Social

* Comentários em posts
* Perfis de usuários
* Notificações de atividade
* Compartilhamento em redes sociais

### Interface

* Design responsivo para dispositivos móveis e desktop com Tailwind CSS
* Tema claro/escuro
* Acessibilidade (WCAG 2.1)
* Internacionalização (i18n)

## Gems Utilizadas

* **Rails 8.0.2** - Framework web
* **PostgreSQL** - Banco de dados relacional
* **Tailwind CSS** - Framework CSS para design moderno e responsivo
* **Pundit** - Autorização de usuários
* **Friendly ID** - URLs amigáveis para posts
* **BCrypt** - Criptografia de senhas
* **Kaminari** - Paginação
* **Hotwire/Turbo** - Atualizações dinâmicas da interface
* **Active Storage** - Upload e processamento de imagens
* **RSpec** - Testes automatizados
* **Factory Bot** - Factories para testes

## Testes

O projeto utiliza o framework de testes integrado do Rails.

Para executar todos os testes:

```bash
rails test
```

Para testes do sistema (com navegador):

```bash
rails test:system
```

Para verificar a cobertura de testes:

```bash
rails test:coverage
```

## Implantação

O projeto está configurado para implantação usando Kamal e Docker. 

### Deploy com Kamal

```bash
kamal setup
kamal deploy
```

Consulte o arquivo `config/deploy.yml` para mais detalhes sobre a configuração de implantação.

## Capturas de Tela

### Página Inicial

![Página Inicial do Blog Auth](public/Home.png)

*Adicione aqui uma captura de tela da página inicial do blog, mostrando a lista de posts recentes e a navegação principal.*

### Página de Login

![Página de Login](public/Login.png)


### Criação de Post

![Página de Criação de Post](public/Artigos.png)



### Perfil de Usuário

![Perfil de Usuário](public/Login.png)

*Adicione aqui uma captura de tela da página de perfil de usuário, mostrando as informações e posts do usuário.*

## Contribuição

Contribuições são bem-vindas! Para contribuir com o projeto:

1. Faça um fork do repositório
2. Crie uma branch para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. Faça commit das suas alterações (`git commit -am 'Adiciona nova funcionalidade'`)
4. Faça push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

## Contato

* **Desenvolvedor:** Seu Nome
* **Email:** seu.email@exemplo.com
* **GitHub:** [seu-usuario](https://github.com/seu-usuario)
* **LinkedIn:** [seu-perfil](https://linkedin.com/in/seu-perfil)

---

© 2023 Blog Auth. Todos os direitos reservados.
