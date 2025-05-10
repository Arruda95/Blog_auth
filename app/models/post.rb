class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Define relacionamento com o usuário (cada post pertence a um usuário)
  belongs_to :user

  # Define relacionamento de um-para-muitos com comentários (um post pode ter vários comentários)
  has_many :comments, dependent: :destroy
  
  has_rich_text :content
  has_one_attached :image

  # Validações rigorosas para os campos do post:
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :content, presence: true
  validates :slug, uniqueness: true

  # Validação para imagens anexadas
  validate :acceptable_image, if: -> { image.attached? }

  private

  # Método para validar se a imagem anexada é aceitável
  # Verifica o tipo de arquivo e o tamanho da imagem
  def acceptable_image
    # Verifica se o tipo de arquivo é uma imagem
    unless image.blob.content_type.start_with?("image/")
      errors.add(:image, "deve ser uma imagem")
      return
    end

    # Verifica o tamanho da imagem (máximo de 5MB)
    if image.blob.byte_size > 5.megabytes
      errors.add(:image, "é muito grande (máximo de 5MB)")
    end
  end

  # Define a ordenação padrão dos posts (do mais recente para o mais antigo)
  default_scope { order(created_at: :desc) }

  # Método para verificar se um usuário específico é o autor do post
  # @param [User] user - O usuário a ser verificado
  # @return [Boolean] - Verdadeiro se o usuário for o autor, falso caso contrário
  def authored_by?(user)
    return false unless user
    self.user_id == user.id
  end
end
