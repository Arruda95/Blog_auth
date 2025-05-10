class PostsController < ApplicationController
  before_action :require_login, except: [ :index, :show, :feed ] # Configura ações de autenticação
  before_action :set_post, only: [ :show, :edit, :update, :destroy ] # Carregamento de post

  def feed # Fornece o feed RSS dos posts
    @posts = Post.all.limit(20)
    respond_to do |format|
      format.rss { render layout: false }
    end
  end

  def index # Lista todos os posts do blog com paginação
    @posts = Post.page(params[:page]).per(5)
  end

  def show # Exibe um post específico com seus comentários paginados
    @post = Post.friendly.find(params[:id])
    @comments = @post.comments.page(params[:page]).per(5)
  end

  def new # Exibe o formulário para criar um novo post
    @post = Post.new
  end

  def edit # Exibe o formulário para editar um post existente
    authorize @post
  end

  def create # Processa o formulário de criação de post
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

  def update # Processa o formulário de atualização de post
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

  def destroy # Exclui um post existente
    authorize @post
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post foi excluído com sucesso." } # status: :see_other (303) indica requisição GET
      format.json { head :no_content } # Para requisições JSON, retorna apenas o cabeçalho sem conteúdo
    end
  end

  private
    def set_post # Carrega um post específico com base no ID ou slug
      @post = Post.friendly.find(params[:id]) # Usa friendly.find para buscar pelo slug se disponível
    end

    def post_params # Filtra os parâmetros permitidos do formulário
      params.require(:post).permit(:title, :content, :image, :user_id)
    end
end
