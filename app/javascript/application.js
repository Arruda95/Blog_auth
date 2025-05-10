// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

// Importa o script do carrossel para funcionalidade de comentários na página inicial
import "./carousel"

// Garante que o Turbo processe corretamente as requisições DELETE
document.addEventListener("turbo:load", function() {
  // Adiciona suporte explícito para links de exclusão
  document.addEventListener("click", function(e) {
    // Verifica se o clique foi no botão de exclusão ou em um elemento filho (como o ícone)
    const deleteLink = e.target.closest("a[data-turbo-method='delete'], .delete-post-link, .delete-comment-link");
    if (deleteLink) {
      e.preventDefault();
      
      // Verifica se há uma mensagem de confirmação
      const confirmMessage = deleteLink.getAttribute("data-turbo-confirm");
      if (!confirmMessage || confirm(confirmMessage)) {
        // Cria um formulário para enviar a requisição DELETE
        const form = document.createElement("form");
        form.method = "POST";
        form.action = deleteLink.href;
        form.style.display = "none";
        
        // Adiciona o token CSRF
        const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
        const csrfInput = document.createElement("input");
        csrfInput.type = "hidden";
        csrfInput.name = "authenticity_token";
        csrfInput.value = csrfToken;
        form.appendChild(csrfInput);
        
        // Adiciona o método DELETE
        const methodInput = document.createElement("input");
        methodInput.type = "hidden";
        methodInput.name = "_method";
        methodInput.value = "delete";
        form.appendChild(methodInput);
        
        // Envia o formulário
        document.body.appendChild(form);
        form.submit();
      }
    }
  });
  
  // Adiciona um fallback para garantir que os links de exclusão funcionem
  console.log("Inicializando manipuladores para links de exclusão");
  document.querySelectorAll('.delete-post-link, .delete-comment-link').forEach(link => {
    console.log("Link de exclusão encontrado:", link);
    link.addEventListener('click', function(e) {
      console.log("Link de exclusão clicado");
    });
  });
})

// Script para controlar o menu mobile
document.addEventListener('turbo:load', function() {
  const mobileMenuButton = document.querySelector('.mobile-menu-button');
  const mobileMenu = document.getElementById('mobile-menu');
  
  if (mobileMenuButton && mobileMenu) {
    mobileMenuButton.addEventListener('click', function() {
      mobileMenu.classList.toggle('hidden');
    });
    
    // Fecha o menu ao clicar em um link
    const mobileMenuLinks = mobileMenu.querySelectorAll('a');
    mobileMenuLinks.forEach(link => {
      link.addEventListener('click', function() {
        mobileMenu.classList.add('hidden');
      });
    });
  }
  
  // A inicialização do editor Trix foi movida para o arquivo _form.html.erb
  // para garantir que funcione corretamente em todos os contextos e evitar conflitos de inicialização
});

// Adiciona listener para redimensionamento da janela
window.addEventListener('resize', function() {
  const mobileMenu = document.getElementById('mobile-menu');
  if (window.innerWidth >= 768 && mobileMenu && !mobileMenu.classList.contains('hidden')) {
    mobileMenu.classList.add('hidden');
  }
});}
