const headerToggle = document.querySelector(".header__toggle");
const headerLinks = document.querySelector(".header__links");

headerToggle.addEventListener("click", () => {
  headerLinks.classList.toggle("active");
});
