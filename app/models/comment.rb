class Comment < ApplicationRecord
  # Define relacionamento com o usuário (cada comentário pertence a um usuário)
  # Isso estabelece que um comentário sempre está associado a um usuário específico
  belongs_to :user
  
  # Define relacionamento com o post (cada comentário pertence a um post)
  # Isso estabelece que um comentário sempre está associado a um post específico
  belongs_to :post
  
  # Validações implícitas:
  # - user_id: não pode ser nulo (devido ao belongs_to)
  # - post_id: não pode ser nulo (devido ao belongs_to)
  
  # Ordenação padrão dos comentários (do mais antigo para o mais recente)
  default_scope { order(created_at: :asc) }
end
