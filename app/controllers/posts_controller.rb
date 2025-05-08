class PostsController < ApplicationController
  # Configura ações de autenticação e carregamento de post
  before_action :require_login, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]


  # Lista todos os posts do blog com paginação
  def index
    @posts = Post.page(params[:page]).per(5)
  end

  # Exibe um post específico com seus comentários paginados
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.page(params[:page]).per(5)
  end

  # Exibe o formulário para criar um novo post
  def new
    @post = Post.new
  end

  # Exibe o formulário para editar um post existente
  def edit
    authorize @post
  end

  # Processa o formulário de criação de post
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post foi criado com sucesso." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # Processa o formulário de atualização de post
  def update
    authorize @post
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post foi atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # Exclui um post existente
  def destroy
    authorize @post
    @post.destroy!

    respond_to do |format|
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

    # Método para filtrar os parâmetros permitidos do formulário
    def post_params
      params.require(:post).permit(:title, :content, :image, :user_id)
    end
end
