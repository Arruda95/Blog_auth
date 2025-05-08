class UsersController < ApplicationController
  # Método para exibir o formulário de cadastro de novo usuário
  # Inicializa um objeto User vazio para ser preenchido pelo formulário
  def new
    @user = User.new
  end

  # Método para processar o formulário de cadastro de usuário
  # Recebe os dados do formulário e tenta criar um novo usuário
  def create
    # Cria um novo objeto User com os parâmetros recebidos do formulário
    @user = User.new(user_params)
    
    # Tenta salvar o usuário no banco de dados
    if @user.save
      # Se o salvamento for bem-sucedido, cria uma sessão para o usuário (login automático)
      session[:user_id] = @user.id
      # Redireciona para a página inicial com mensagem de sucesso
      redirect_to root_path, notice: "Cadastro realizado com sucesso!"
    else
      # Se houver erros de validação, renderiza novamente o formulário com os erros
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Método privado para filtrar os parâmetros permitidos do formulário
  # Isso é uma medida de segurança para evitar atribuição em massa de parâmetros não permitidos
  def user_params
    # Permite apenas os campos email, password e password_confirmation
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end