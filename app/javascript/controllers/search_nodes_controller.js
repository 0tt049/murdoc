import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-nodes"
export default class extends Controller {
  static targets = ["form", "input", "list"]
  connect() {
    console.log(this.listTargett)
    console.log(this.formTarget)
  }

  find() {
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data
      })
    // console.log(event)
  }
}
