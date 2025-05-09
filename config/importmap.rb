# Pin npm packages by running ./bin/importmap

pin "application" # Arquivo principal da aplicação
pin "@hotwired/turbo-rails", to: "turbo.min.js" # Framework Turbo para atualizações de página
pin "@hotwired/stimulus", to: "stimulus.min.js" # Framework Stimulus para comportamentos JavaScript
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js" # Carregador do Stimulus
pin_all_from "app/javascript/controllers", under: "controllers" # Controladores Stimulus
pin "trix" # Editor de texto rico
pin "@rails/actiontext", to: "actiontext.esm.js" # Suporte para ActionText
pin "carousel", to: "carousel.js" # Script do carrossel de comentários
