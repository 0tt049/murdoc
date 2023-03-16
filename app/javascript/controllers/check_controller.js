import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="check"
export default class extends Controller {
  static targets = [ "list" ]
  connect() {
  }

  update(event) {
    // console.log(this.element);
    console.log("update");
    const list = this.listTarget;
    list.innerHTML = "Hello, Stimulus!"
    // print in console the event id
    console.log(event.target.id);

    // event.preventDefault()

    fetch(`/?path_node=${event.target.id}`, {
      headers: { "Accept": "application/json" }
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
        // list.innerHTML = data.html
      })




  }
}

// <% if node.present? %>
//   <% node.siblings.where(category:['instance methods', 'methods']).each do |child| %>
//     <h2><%= child.name %></h2>
//   <% end %>
// <% end %>
