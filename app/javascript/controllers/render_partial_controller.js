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
  replaceMain() {
    this.container.innerHTML = ""
    this.container.innerHTML = "<%= j render partial: 'shared/main' %>"
  }
  replaceTree() {
    this.container.innerHTML = ""
    this.container.innerHTML = "<%= j render partial: 'shared/tree' %>"
  }
  replaceInstallationGuide() {
    this.container.innerHTML = ""
    this.container.innerHTML = "<%= j render partial: 'shared/installation_guide' %>"
  }
  replaceAboutUs() {
    this.container.innerHTML = ""
    this.container.innerHTML = "<%= j render partial: 'shared/about_us' %>"
  }
}
