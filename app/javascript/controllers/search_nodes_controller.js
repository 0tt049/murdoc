import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-nodes"
export default class extends Controller {
  static targets = ["form", "input", "teste"]
  connect() {
    console.log(this.testeTarget)
    console.log(this.formTarget)
  }

  find() {
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then((data) => {
        this.testeTarget.outerHTML = data
      })
    // console.log(event)
  }
}
