class UsersController < ApplicationController
  # Exibe o formulário de cadastro de novo usuário
  def new
    @user = User.new
  end

  # Processa o formulário de cadastro de usuário
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Cadastro realizado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Filtra os parâmetros permitidos do formulário
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end