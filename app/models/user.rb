class User < ApplicationRecord
    # Adiciona funcionalidades para autenticação segura com senha criptografada
    has_secure_password
    
    # Define relacionamento de um-para-muitos com posts (um usuário pode ter vários posts)
    has_many :posts  
    
    # Define relacionamento de um-para-muitos com comentários (um usuário pode fazer vários comentários)
    has_many :comments
  
    # Executa o método downcase_email antes de salvar o usuário no banco de dados
    before_save :downcase_email
  
    # Validações para o campo email:
    # - presence: true -> email não pode ser vazio
    # - uniqueness: true -> email deve ser único no sistema
    # - format -> email deve seguir o formato padrão de endereços de email
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  
    private
  
    # Método para converter o email para minúsculas antes de salvar
    # Isso garante consistência na busca de emails, independente de como o usuário digitou
    def downcase_email
      self.email = email.downcase
    end
  end