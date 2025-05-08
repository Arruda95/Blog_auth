class CommentsController < ApplicationController
  # Requer que o usuário esteja logado para todas as ações
  before_action :require_login

  # Cria um novo comentário em um post específico
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      respond_to do |format|
        format.html { redirect_to @post, notice: "Comentário adicionado com sucesso." }
        format.turbo_stream
      end
    else
      redirect_to @post, alert: "Não foi possível adicionar o comentário."
    end
  end

  # Exclui um comentário existente
  def destroy
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

  # Método privado para filtrar os parâmetros permitidos do formulário
  # Isso é uma medida de segurança para evitar atribuição em massa de parâmetros não permitidos
  def comment_params
    # Permite apenas o campo content para criação/atualização de comentários
    params.require(:comment).permit(:content)
  end
end
