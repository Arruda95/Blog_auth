class PostsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Post criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
      validates :title, :content, presence: true
    end
  end
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "Post excluído com sucesso!"
  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: "Você precisa estar logado para acessar esta página."
    end
  end
end