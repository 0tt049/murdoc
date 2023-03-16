import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="check"
export default class extends Controller {
  static targets = [ "list" ]
  connect() {
  }

  update() {
    console.log("update");
    const list = this.listTarget;
    list.innerHTML = "Hello, Stimulus!"


  }
}
