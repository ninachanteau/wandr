
const navItem = document.querySelectorAll("li.nav-item");
navItem.forEach((element) => {
  element.addEventListener("click", (event) => {
    const selectedItem = event.currentTarget.querySelector("a");
    navItem.forEach((elem) => {
      elem.querySelector("a").classList.remove("active");
    });
    selectedItem.classList.toggle("active");
  })
});
