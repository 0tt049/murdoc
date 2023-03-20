document.addEventListener("turbo:load", function() {
  activateTreeview()

});

const activateTreeview = () => {
  var toggler = document.getElementsByClassName("caret");

  for (var i = 0; i < toggler.length; i++) {
    toggler[i].addEventListener("click", function() {
      this.parentElement.querySelector(".nested").classList.toggle("active");
      this.classList.toggle("caret-down");
    });
  }
}

export { activateTreeview }
