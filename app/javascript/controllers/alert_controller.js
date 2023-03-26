import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alert"
export default class extends Controller {
  connect() {
  }

  // Connects to data-action="click->alert#dismiss"
  dismiss() {
    this.element.remove()
  }
}
