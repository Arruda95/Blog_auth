class ApplicationController < ActionController::Base
  include Pundit::Authorization
  # Define o método current_user como um helper method
  # Isso permite que o método seja acessível nas views, além dos controllers
  helper_method :current_user
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  private

  # Método para obter o usuário atualmente logado
  # @return [User, nil] Retorna o objeto User do usuário logado ou nil se não houver usuário logado
  def current_user
    # Utiliza memoization (@current_user ||=) para evitar múltiplas consultas ao banco de dados
    # Busca o usuário pelo ID armazenado na sessão, se existir
    # O resultado é armazenado em @current_user para uso futuro na mesma requisição
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Método para verificar se o usuário está logado
  # Redireciona para a página de login se não estiver
  # Este método é usado como before_action em controllers que requerem autenticação
  def require_login
    unless current_user
      redirect_to login_path, alert: "Você precisa estar logado para acessar esta página."
    end
  end

  # Método para verificar se um objeto é de autoria do usuário atual
  # @param [Object] resource - O recurso a ser verificado
  # @return [Boolean] - Verdadeiro se o usuário for o autor, falso caso contrário
  def authored_by?(resource)
    return false unless current_user
    resource.user_id == current_user.id
  end
  def user_not_authorized
    flash[:alert] = "Você não tem permissão para realizar esta ação."
    redirect_to(request.referrer || root_path)
  end
end
