# Configuração do Active Storage para garantir que as imagens sejam exibidas corretamente

# Permitir que o Active Storage use variantes de imagem
Rails.application.config.active_storage.variant_processor = :mini_magick

# Configurar o URL para servir arquivos do Active Storage
Rails.application.config.active_storage.service_urls_expire_in = 1.hour

# Configurar os tipos de conteúdo permitidos para upload
Rails.application.config.active_storage.content_types_allowed_inline = %w(
  image/png
  image/gif
  image/jpg
  image/jpeg
)

# Configurar o tamanho máximo para exibição inline
Rails.application.config.active_storage.content_types_to_serve_as_binary = %w(
  image/svg+xml
)

# Configurar o tamanho máximo para preview
Rails.application.config.active_storage.analyzers = [
  ActiveStorage::Analyzer::ImageAnalyzer::Vips,
  ActiveStorage::Analyzer::VideoAnalyzer,
  ActiveStorage::Analyzer::AudioAnalyzer
]