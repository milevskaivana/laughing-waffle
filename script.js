
const filters = [
    { category: 'coding', cards: document.querySelectorAll('.cards-developer') },
    { category: 'marketing', cards: document.querySelectorAll('.cards-marketing') },
    { category: 'design', cards: document.querySelectorAll('.cards-design') }
  ];
  
  filters.forEach(filter => {
    const button = document.querySelector(`#filter-${filter.category}`);
    button.addEventListener('click', () => {
      hideAll();
      if (!button.classList.contains('selected')) {
        button.classList.add('selected');
        filters.filter(f => f.category !== filter.category).forEach(f => {
          document.querySelector(`#filter-${f.category}`).classList.remove('selected');
          f.cards.forEach(card => card.style.display = 'none');
        });
        filter.cards.forEach(card => card.style.display = 'inline-block');
      } else {
        button.classList.remove('selected');
        showAll();
      }
    });
  });
  
  function hideAll() {
    document.querySelectorAll('.all-cards').forEach(card => card.style.display = 'none');
  }
  
  function showAll() {
    document.querySelectorAll('.all-cards').forEach(card => card.style.display = 'inline-block');
  }
  