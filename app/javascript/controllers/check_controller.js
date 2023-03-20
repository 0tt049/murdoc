import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="check"
export default class extends Controller {
  static targets = [ "list" ]
  static values = { parentNodeId: Number }

  update(event) {

    const list = this.listTarget;

    if (event.target.checked) {
      fetch(`/?path_node=${event.target.id}`, {
        headers: { "Accept": "application/json" }
      })
      .then(response => response.json())
      .then((data) => {

        const buildItem = (method) => {
          return `<li><a class="text-decoration-none" data-turbo-frame="home" data-check-parent-node-id-value="${event.target.id}" href="/?parent=${event.target.id}&doc=${method.id}">${method.name}</a></li>`
        }

        const div = `<div id="${event.target.id}">
        <button type="button" data-bs-toggle="collapse" data-bs-target="#collapse${event.target.id}" data-check-parent-node-id-value="${event.target.id}" aria-expanded="true" aria-controls="collapse${event.target.id}">${event.target.name}</button>
        <div class="collapse show" id="collapse${event.target.id}">${data.methods.map(method => { return buildItem(method) } ).join('')}
        </div>
        </div>`


        list.insertAdjacentHTML('beforeend', div)


      })
    } else {


      if (list.childNodes.length > 0) {

        list.childNodes.forEach((child) => {
          // console.log(child.id);
          if (child.id === event.target.id) {
            setTimeout(() => child.remove(), 0);
          }

        })

      }

    }
  }

}
