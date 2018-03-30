const tabs = document.querySelectorAll('.tabs .tab');

tabs.forEach((tab) => {
  tab.addEventListener('click', (event) => {
    if (!event.currentTarget.classList.contains('active')) {
      document.querySelector('.tab.active').classList.remove('active');
      event.currentTarget.classList.add('active');
    }
  });
})
