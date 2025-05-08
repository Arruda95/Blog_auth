class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Define relacionamento com o usuário (cada post pertence a um usuário)
  belongs_to :user
  
  # Define relacionamento de um-para-muitos com comentários (um post pode ter vários comentários)
  has_many :comments, dependent: :destroy
  has_rich_text :content
  has_one_attached :image
  # Validações para os campos do post:
  # - title: não pode ser vazio
  # - content: não pode ser vazio
  validates :title, :content, presence: true
  
  # Define a ordenação padrão dos posts (do mais recente para o mais antigo)
  default_scope { order(created_at: :desc) }
  
  # Método para verificar se um usuário específico é o autor do post
  # @param [User] user - O usuário a ser verificado
  # @return [Boolean] - Verdadeiro se o usuário for o autor, falso caso contrário
  def authored_by?(user)
    user_id == user&.id
  end
end