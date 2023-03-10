import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="render-partial"
export default class extends Controller {
  static targets = ["main", "tree", "guide", "about"]

  connect() {
    console.log(this.mainTarget)
    console.log(this.treeTarget)
    console.log(this.guideTarget)
    console.log(this.aboutTarget)
  }
  replacePartial(event) {
    event.preventDefault()
    const target = event.target
    const partial = target.dataset.url
    const container = document.querySelector(".container")
    // container.innerHTML = ""
    // container.innerHTML = "<%= j render partial: '' %>"
    // const response = await fetch(url)
    // const html = await response.text()
    container.innerHTML = partial
  }
  // replaceTree() {
  //   this.container.innerHTML = ""
  //   this.container.innerHTML = "<%= j render partial: 'shared/tree' %>"
  // }
  // replaceInstallationGuide() {
  //   this.container.innerHTML = ""
  //   this.container.innerHTML = "<%= j render partial: 'shared/installation_guide' %>"
  // }
  // replaceAboutUs() {
  //   this.container.innerHTML = ""
  //   this.container.innerHTML = "<%= j render partial: 'shared/about_us' %>"
  // }
}
