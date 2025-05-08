class CommentsController < ApplicationController
  # Define que todas as ações deste controlador requerem que o usuário esteja logado
  # Isso é implementado pelo método require_login definido no ApplicationController
  before_action :require_login

  # POST /posts/:post_id/comments
  # Método para processar a criação de um novo comentário em um post específico
  def create
    # Busca o post pelo ID fornecido na URL
    @post = Post.find(params[:post_id])

    # Cria um novo comentário associado ao post e ao usuário atual
    # O método build cria um objeto Comment associado ao @post, mas ainda não salvo no banco
    # merge(user: current_user) adiciona o usuário atual como autor do comentário
    @comment = @post.comments.build(comment_params.merge(user: current_user))

    # Tenta salvar o comentário no banco de dados
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @post, notice: "Comentário adicionado com sucesso." }
        format.turbo_stream  # Resposta Turbo Stream para atualização em tempo real
      end
    else
      redirect_to @post, alert: "Não foi possível adicionar o comentário."
    end
  end

  # DELETE /comments/:id
  # Método para excluir um comentário existente
  def destroy
    # Busca o comentário pelo ID fornecido na URL
    @comment = Comment.find(params[:id])

    # Verifica se o usuário atual é o autor do comentário
    # Isso é uma medida de segurança para garantir que apenas o autor possa excluir seu próprio comentário
    if @comment.user == current_user
      # Se for o autor, exclui o comentário do banco de dados
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to @comment.post, notice: "Comentário excluído com sucesso." }
        format.turbo_stream  # Resposta Turbo Stream para remoção do comentário em tempo real
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
