import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat-scroll"
export default class extends Controller {
  static targets = [ "message" ]

  connect() {
    this.scrollBottom()
  }

  containerNearBottom() {
    const { offsetHeight, scrollHeight, scrollTop } = this.element
    return scrollHeight <= scrollTop + offsetHeight + 100
  }

  scrollBottom() {
    const { scrollHeight } = this.element
    this.element.scrollTo(0, scrollHeight)
  }

  messageTargetConnected() {
    if (this.containerNearBottom()) {
      this.scrollBottom()
    }
  }
}
