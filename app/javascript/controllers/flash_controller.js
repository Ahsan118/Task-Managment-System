import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.classList.add('opacity-0', 'transition-opacity', 'duration-1000') // Fade out with 1s duration
      setTimeout(() => this.element.remove(), 1000) // Remove after fade-out
    }, 2000) // Start fading after 2 seconds
  }
}