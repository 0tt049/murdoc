import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="replace-partial"
export default class extends Controller {
  static targets = [ "container" ]

  connect() {
  }

  get containerTarget() {
    return this.targets.find("container")
  }

  replacePartial() {
    fetch(this.data.get("url"))
      .then(response => response.text())
      .then(html => {
        this.containerTarget.innerHTML = html
      })
      .catch(error => {
        console.error(error)
      })
  }
}
