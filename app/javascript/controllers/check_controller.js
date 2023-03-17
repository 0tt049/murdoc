import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="check"
export default class extends Controller {
  static targets = [ "list", "path" ]
  static values = { parentNodeId: Number, id: Number }

  update(event) {
    // console.log(event.target.checked);
    // console.log(this.element);
    // console.log("update");
    const list = this.listTarget;
    // list.innerHTML = "Hello, Stimulus!"
    // print in console the event id
    // console.log(event.target.id);

    // event.preventDefault()
    if (event.target.checked) {
      fetch(`/?path_node=${event.target.id}`, {
        headers: { "Accept": "application/json" }
      })
      .then(response => response.json())
      .then((data) => {
          // console.log(data.methods.length)
        data.methods.forEach((method) => {
          // console.log(method.name);
          list.innerHTML += `<li><a class="text-decoration-none" data-turbo-frame="home" data-check-parent-node-id-value="${event.target.id}" href="/?parent=${event.target.id}&doc=${method.id}">${method.name}</a></li>`
          // <p><%= link_to child.name, "/?parent=#{node.id}&doc=#{child.id}", class: 'text-decoration-none', data: {turbo_frame: 'home'} %></p>
        })
      })
    } else {

      if (list.childNodes.length > 0) {

        // console.log(list.childNodes);
        list.childNodes.forEach((child) => {
          // console.log(child.childNodes[0]);
          console.log(child);
          if (child.nodeName === "LI" && child.childNodes.length === 1) {
            if (child.childNodes[0].dataset.checkParentNodeIdValue === event.target.id) {
              setTimeout(() => child.remove(), 0);
            }
          }
        })

      }

    }
  }

  mark(event) {
    // console.log(event.target.id);

    // setTimeout(() =>  this.checkboxes = document.querySelectorAll('input[class="btn-check"]'), 20);

    // console.log(this.pathTarget);
    setTimeout(() => {
      // this.checkboxes = document.querySelectorAll('.btn-check');
      const path = this.pathTargets;
      // console.log(this.checkboxes);
      path.forEach((checkbox) => {

        if (checkbox.dataset.checkIdValue === event.target.id) {
          checkbox.checked = true;
        }

      })
    }, 200);
  }
}
