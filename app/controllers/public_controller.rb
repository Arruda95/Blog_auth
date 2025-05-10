class PublicController < ApplicationController
  before_action :require_login, only: [ :create_comment ]
  skip_before_action :require_login, only: [ :index, :show ]

  def index
    @posts = Post.page(params[:page]).per(5)
    render "posts/index"
  end

  def show
    @post = Post.friendly.find(params[:id])
    @comments = @post.comments.page(params[:page]).per(5)
    # Definir current_user como helper method para que esteja disponível nas views
    @current_user = current_user
    render "posts/show"
  end
end
