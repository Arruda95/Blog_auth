class PostsController < ApplicationController
  # Define uma ação que será executada antes dos métodos show, edit, update e destroy
  # Isso carrega o post específico com base no ID fornecido na URL
  before_action :require_login, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]


  # GET /posts ou /posts.json
  # Método para listar todos os posts do blog
  def index
    # Busca todos os posts do banco de dados e armazena na variável @posts
    # Esta variável estará disponível na view correspondente (index.html.erb)
    @posts = Post.page(params[:page]).per(5) # O .per(5) define quantos posts por página
  end

  # GET /posts/1 ou /posts/1.json
  # Método para exibir um post específico
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.page(params[:page]).per(5)
    # O post já foi carregado pelo before_action :set_post
    # Não é necessário código adicional aqui, pois a view show.html.erb
    # terá acesso à variável @post definida pelo método set_post
  end

  # GET /posts/new
  # Método para exibir o formulário de criação de novo post
  def new
    # Inicializa um novo objeto Post vazio para ser preenchido pelo formulário
    @post = Post.new
  end

  # GET /posts/1/edit
  # Método para exibir o formulário de edição de um post existente
  def edit
    authorize @post
    # O post já foi carregado pelo before_action :set_post
    # Não é necessário código adicional aqui, pois a view edit.html.erb
    # terá acesso à variável @post definida pelo método set_post
  end

  # POST /posts ou /posts.json
  # Método para processar o formulário de criação de post
  def create
    # Cria um novo objeto Post com os parâmetros recebidos do formulário
    @post = Post.new(post_params)

    # Responde de acordo com o formato solicitado (HTML ou JSON)
    respond_to do |format|
      # Tenta salvar o post no banco de dados
      if @post.save
        # Se o salvamento for bem-sucedido:
        # Para requisições HTML, redireciona para a página do post com mensagem de sucesso
        format.html { redirect_to @post, notice: "Post foi criado com sucesso." }
        # Para requisições JSON, retorna o post criado com status 201 (Created)
        format.json { render :show, status: :created, location: @post }
      else
        # Se houver erros de validação:
        # Para requisições HTML, renderiza novamente o formulário com os erros
        format.html { render :new, status: :unprocessable_entity }
        # Para requisições JSON, retorna os erros com status 422 (Unprocessable Entity)
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 ou /posts/1.json
  # Método para processar o formulário de atualização de post
  def update
    authorize @post
    # Responde de acordo com o formato solicitado (HTML ou JSON)
    respond_to do |format|
      # Tenta atualizar o post com os parâmetros recebidos do formulário
      if @post.update(post_params)
        # Se a atualização for bem-sucedida:
        # Para requisições HTML, redireciona para a página do post com mensagem de sucesso
        format.html { redirect_to @post, notice: "Post foi atualizado com sucesso." }
        # Para requisições JSON, retorna o post atualizado
        format.json { render :show, status: :ok, location: @post }
      else
        # Se houver erros de validação:
        # Para requisições HTML, renderiza novamente o formulário com os erros
        format.html { render :edit, status: :unprocessable_entity }
        # Para requisições JSON, retorna os erros com status 422 (Unprocessable Entity)
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 ou /posts/1.json
  # Método para excluir um post existente
  def destroy
    authorize @post
    # Exclui o post do banco de dados usando destroy! que lança exceção em caso de erro
    # O post já foi carregado pelo before_action :set_post
    @post.destroy!

    # Responde de acordo com o formato solicitado (HTML ou JSON)
    respond_to do |format|
      # Para requisições HTML, redireciona para a lista de posts com mensagem de sucesso
      # status: :see_other (303) indica que o cliente deve fazer uma requisição GET para o URL fornecido
      format.html { redirect_to posts_path, status: :see_other, notice: "Post foi excluído com sucesso." }
      # Para requisições JSON, retorna apenas o cabeçalho sem conteúdo (status 204 No Content)
      format.json { head :no_content }
    end
  end

  private
    # Método privado para carregar um post específico com base no ID
    # Este método é chamado pelo before_action para as ações show, edit, update e destroy
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      # Busca o post pelo ID fornecido na URL e armazena na variável @post
      # params.expect(:id) garante que o parâmetro id esteja presente, lançando exceção caso contrário
      @post = Post.friendly.find(params[:id])
    end

    # Método privado para filtrar os parâmetros permitidos do formulário
    # Isso é uma medida de segurança para evitar atribuição em massa de parâmetros não permitidos
    # Only allow a list of trusted parameters through.
    def post_params
      params.expect(post: [ :title, :content, :user_id ])
    end
end
