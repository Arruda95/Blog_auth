// Arquivo JavaScript para controlar o carrossel de comentários
document.addEventListener('turbo:load', function() {
  // Seleciona os elementos do carrossel para manipulação
  const carousel = document.querySelector('.carousel'); // Container principal do carrossel
  const container = document.querySelector('.carousel-container'); // Container que contém os itens do carrossel
  const prevButton = document.querySelector('.carousel-prev'); // Botão para navegar para o item anterior
  const nextButton = document.querySelector('.carousel-next'); // Botão para navegar para o próximo item
  
  // Verifica se todos os elementos necessários existem na página atual
  if (!carousel || !container || !prevButton || !nextButton) return;
  
  // Obtém todos os itens do carrossel para verificar se existem itens para exibir
  const items = container.querySelectorAll('.carousel-item');
  if (items.length === 0) return; // Se não houver itens, não prossegue com a inicialização
  
  // Configura o evento de clique para o botão de navegação anterior
  prevButton.addEventListener('click', function() {
    // Move o scroll para a esquerda com animação suave
    container.scrollBy({ left: -container.offsetWidth / 2, behavior: 'smooth' });
  });
  
  // Configura o evento de clique para o botão de navegação próximo
  nextButton.addEventListener('click', function() {
    // Move o scroll para a direita com animação suave
    container.scrollBy({ left: container.offsetWidth / 2, behavior: 'smooth' });
  });
  
  // Adiciona estilos CSS para esconder a barra de rolagem em diferentes navegadores
  const style = document.createElement('style');
  style.textContent = `
    .scrollbar-hide::-webkit-scrollbar {
      display: none; // Esconde a barra de rolagem no Chrome, Safari e Opera
    }
    .scrollbar-hide {
      -ms-overflow-style: none; // Esconde a barra de rolagem no Internet Explorer e Edge
      scrollbar-width: none; // Esconde a barra de rolagem no Firefox
    }
  `;
  document.head.appendChild(style); // Adiciona os estilos ao cabeçalho do documento
});