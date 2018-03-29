function displayTab(tabType) {
  document.getElementById(tabType).style.display = "none";
}

function clickTab(tabType) {
  const tabContent = document.querySelector(".tabcontent");
  const tab = document.querySelector(".tab");
  tab.addEventListener("click", (event) => {
    event.currentTarget.classList.add("active");
    displayTab(tabType);
  });
};


// tabType contenu = #mine or #others
// classes contenu = .tabcontent


