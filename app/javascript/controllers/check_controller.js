import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="check"
export default class extends Controller {
  static targets = [ "list" ]
  static values = { parentNodeId: Number }

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
        // console.log(event.target.name);
          // console.log(data.methods.length)
          list.innerHTML += `<button type="button" data-bs-toggle="collapse" data-bs-target="#collapse${event.target.id}" data-check-parent-node-id-value="${event.target.id}" aria-expanded="true" aria-controls="collapse${event.target.id}">${event.target.name}</button>` +
          `<div class="collapse show" id="collapse${event.target.id}">`

          data.methods.forEach((method) => {
            // console.log(method.name);
            list.innerHTML += `<li><a class="text-decoration-none" data-turbo-frame="home" data-check-parent-node-id-value="${event.target.id}" href="/?parent=${event.target.id}&doc=${method.id}">${method.name}</a></li>`
            // <p><%= link_to child.name, "/?parent=#{node.id}&doc=#{child.id}", class: 'text-decoration-none', data: {turbo_frame: 'home'} %></p>
          })

          list.innerHTML += `</div>`
      })
    } else {

      if (list.childNodes.length > 0) {

        // console.log(list.childNodes);
        list.childNodes.forEach((child) => {

          if (child.nodeName === "BUTTON" && child.dataset.checkParentNodeIdValue === event.target.id) {
            setTimeout(() => child.remove(), 0);
          }

          if (child.nodeName === "DIV" && child.dataset.checkParentNodeIdValue === event.target.id) {
            setTimeout(() => child.remove(), 0);
          }

          if (child.nodeName === "LI" && child.childNodes.length === 1) {
            if (child.childNodes[0].dataset.checkParentNodeIdValue === event.target.id) {
              setTimeout(() => child.remove(), 0);
            }
          }
        })

      }

    }
  }

}
