class SessionsController < ApplicationController
  # GET /login
  # Método para exibir o formulário de login
  # Este método não precisa de código adicional pois apenas renderiza a view new.html.erb
  # A view correspondente (new.html.erb) conterá o formulário com campos para email e senha
  def new
  end

  # POST /login
  # Método para processar o formulário de login
  # Recebe os dados do formulário e tenta autenticar o usuário
  def create
    # Busca o usuário pelo email, convertendo para minúsculas para garantir consistência
    # Isso é importante porque emails não diferenciam maiúsculas de minúsculas
    user = User.find_by(email: params[:email].downcase)
    
    # Tenta autenticar o usuário com a senha fornecida
    # O método authenticate é fornecido pelo has_secure_password no modelo User
    # O operador &. (safe navigation) garante que authenticate só será chamado se user não for nil
    # Isso evita erros quando um email inexistente é fornecido
    if user&.authenticate(params[:password])
      # Se a autenticação for bem-sucedida, cria uma sessão para o usuário
      # Armazena o ID do usuário na sessão, que é um cookie criptografado
      session[:user_id] = user.id
      # Redireciona para a página inicial com mensagem de sucesso
      # A mensagem é armazenada no flash[:notice] e será exibida na próxima requisição
      redirect_to root_path, notice: "Login realizado com sucesso!"
    else
      # Se a autenticação falhar, exibe mensagem de erro
      # flash.now faz a mensagem persistir apenas para a requisição atual
      # Isso é diferente do flash normal, que persiste até a próxima requisição
      flash.now[:alert] = "Email ou senha inválidos."
      # Renderiza novamente o formulário de login
      # status: :unprocessable_entity (422) indica que os dados fornecidos são inválidos
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /logout
  # Método para realizar o logout do usuário
  # Este método encerra a sessão atual do usuário, removendo suas informações da sessão
  def destroy
    # Remove o ID do usuário da sessão, efetivamente deslogando o usuário
    # O método delete remove a chave :user_id da hash de sessão
    # Isso faz com que current_user retorne nil nas próximas requisições
    session[:user_id] = nil
    
    # Redireciona para a página inicial com mensagem de sucesso
    # A mensagem é armazenada no flash[:notice] e será exibida na próxima requisição
    # Isso proporciona feedback ao usuário de que o logout foi realizado com sucesso
    redirect_to root_path, notice: "Logout realizado com sucesso!"
  end
end