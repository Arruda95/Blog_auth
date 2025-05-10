class CommentsController < ApplicationController
  before_action :require_login # Requer que o usuário esteja logado para todas as ações

  def create # Cria um novo comentário em um post específico
    @post = Post.friendly.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.html { redirect_to @post, notice: "Comentário adicionado com sucesso." }
        format.turbo_stream
      end
    else
      redirect_to @post, alert: "Não foi possível adicionar o comentário."
    end
  end

  def destroy # Exclui um comentário existente
    @comment = Comment.find(params[:id])

    if @comment.user == current_user
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to @comment.post, notice: "Comentário excluído com sucesso." }
        format.turbo_stream
      end
    else
      redirect_to @comment.post, alert: "Você não tem permissão para excluir este comentário."
    end
  end

  private

  def comment_params # Filtra os parâmetros permitidos do formulário para segurança
    params.require(:comment).permit(:content) # Permite apenas o campo content
  end
end
