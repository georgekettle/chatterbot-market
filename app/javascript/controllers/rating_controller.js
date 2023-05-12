import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["star"]

  connect() {
    this.highlightRating()
  }

  highlightRating() {
    const rating = parseInt(this.data.get("ratingValue")) || 0

    this.starTargets.forEach((star, index) => {
      star.classList.toggle("text-info-500", index < rating)
      star.classList.toggle("text-tertiary-400", index >= rating)
    })
  }

  selectRating(event) {
    const rating = parseInt(event.currentTarget.value) || 0
    this.data.set("ratingValue", rating)
    this.highlightRating()
  }
}
