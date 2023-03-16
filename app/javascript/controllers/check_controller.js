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
          // console.log(data.methods)
        data.methods.forEach((method) => {
          // console.log(method.name);
          list.innerHTML += `<li><a class="text-decoration-none" data-turbo-frame="home" data-check-parent-node-id-value="${event.target.id}" href="/?parent=${event.target.id}&doc=${method.id}">${method.name}</a></li>`
          // <p><%= link_to child.name, "/?parent=#{node.id}&doc=#{child.id}", class: 'text-decoration-none', data: {turbo_frame: 'home'} %></p>

        })
      })
    } else {
      if (list.childNodes.length > 0) {


        list.childNodes.forEach((child) => {
          console.log(child);

          if (child.tagName === "LI") {
            console.log(child.attributes);
            // if (child.childNodes[0].dataset.checkParentNodeIdValue === event.target.id) {
            //   child.remove();
            // }
          }

        })
      }
    }

  }
}

// <% if node.present? %>
//   <% node.path.each do |node_path_item| %>
//     <% node_path_item.children.where(category:['instance_method', 'method']).each do |child| %>
//       <p><%= link_to child.name, "/?parent=#{node.id}&doc=#{child.id}", class: 'text-decoration-none', data: {turbo_frame: 'home'} %></p>
//     <% end %>
//   <% end %>
// <% end %>



    // <% if node.present? %>
    //   <% node.siblings.where(category:['instance methods', 'methods']).each do |child| %>
    //     <h2><%= child.name %></h2>
    //   <% end %>
    // <% end %>
