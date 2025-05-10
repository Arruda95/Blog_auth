// Manipulador específico para operações de exclusão

document.addEventListener("turbo:load", function() {
  console.log("Delete handler inicializado");
  
  // Função para criar e enviar um formulário DELETE
  function handleDeleteAction(event, link) {
    event.preventDefault();
    event.stopPropagation();
    
    // Verifica se há uma mensagem de confirmação
    const confirmMessage = link.getAttribute("data-turbo-confirm");
    if (confirmMessage && !confirm(confirmMessage)) {
      return; // Usuário cancelou a operação
    }
    
    // Cria um formulário para enviar a requisição DELETE
    const form = document.createElement("form");
    form.method = "POST";
    form.action = link.href;
    form.style.display = "none";
    
    // Adiciona o token CSRF
    const csrfToken = document.querySelector("meta[name='csrf-token']");
    if (csrfToken) {
      const csrfInput = document.createElement("input");
      csrfInput.type = "hidden";
      csrfInput.name = "authenticity_token";
      csrfInput.value = csrfToken.getAttribute("content");
      form.appendChild(csrfInput);
    }
    
    // Adiciona o método DELETE
    const methodInput = document.createElement("input");
    methodInput.type = "hidden";
    methodInput.name = "_method";
    methodInput.value = "delete";
    form.appendChild(methodInput);
    
    // Envia o formulário
    document.body.appendChild(form);
    console.log("Enviando formulário DELETE para: " + link.href);
    form.submit();
  }
  
  // Adiciona listeners para links de exclusão
  function setupDeleteLinks() {
    // Seleciona todos os links de exclusão
    const deleteLinks = document.querySelectorAll(
      'a[data-turbo-method="delete"], .delete-post-link, .delete-comment-link'
    );
    
    console.log(`Encontrados ${deleteLinks.length} links de exclusão`);
    
    // Adiciona listeners para cada link
    deleteLinks.forEach(link => {
      // Remove listeners existentes para evitar duplicação
      link.removeEventListener('click', linkClickHandler);
      
      // Adiciona novo listener
      link.addEventListener('click', linkClickHandler);
      
      // Marca o link como inicializado
      link.setAttribute('data-delete-handler-initialized', 'true');
      console.log("Link de exclusão inicializado:", link.href);
    });
  }
  
  // Função de manipulação de clique para links
  function linkClickHandler(event) {
    console.log("Link de exclusão clicado");
    handleDeleteAction(event, this);
  }
  
  // Configura os links inicialmente
  setupDeleteLinks();
  
  // Configura um MutationObserver para detectar novos links adicionados ao DOM
  const observer = new MutationObserver(function(mutations) {
    let shouldSetup = false;
    
    mutations.forEach(function(mutation) {
      if (mutation.addedNodes.length) {
        shouldSetup = true;
      }
    });
    
    if (shouldSetup) {
      setupDeleteLinks();
    }
  });
  
  // Inicia a observação do documento
  observer.observe(document.body, {
    childList: true,
    subtree: true
  });
});