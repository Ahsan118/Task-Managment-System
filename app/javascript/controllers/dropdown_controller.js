import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "icon", "link"];

  connect() {
    this.openIfSelected();
    document.addEventListener("click", this.closeOnClickOutside.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.closeOnClickOutside.bind(this));
  }

  openIfSelected() {
    // Check if any nested link has the 'selected' class for sidebar
    const isAnyLinkSelected = this.linkTargets.some(link => link.classList.contains("selected"));
    
    if (isAnyLinkSelected) {
      this.menuTarget.classList.remove("hidden");
      if (this.hasIconTarget) {
        this.iconTarget.classList.remove("fa-chevron-down");
        this.iconTarget.classList.add("fa-chevron-up");
      }
      this.element.classList.add("selected");
      this.element.querySelector('button').classList.add('text-white');
    }
  }

  toggle(event) {
    this.menuTarget.classList.toggle("hidden");

    // Determine if the dropdown should open upwards or downwards
    const { bottom } = event.target.getBoundingClientRect();
    const viewportHeight = window.innerHeight;
    const dropdownHeight = this.menuTarget.offsetHeight;

    this.menuTarget.style.top = (bottom + dropdownHeight > viewportHeight) ? "auto" : "100%";
    this.menuTarget.style.bottom = (bottom + dropdownHeight > viewportHeight) ? "100%" : "auto";

    // Toggle the icon if it exists
    if (this.hasIconTarget) {
      this.iconTarget.classList.toggle("fa-chevron-up", !this.menuTarget.classList.contains("hidden"));
      this.iconTarget.classList.toggle("fa-chevron-down", this.menuTarget.classList.contains("hidden"));
    }
  }

  closeOnClickOutside(event) {
    if (!this.element.contains(event.target) && !this.menuTarget.classList.contains("hidden") && !this.element.classList.contains("sidebar-dropdown")) {
      this.menuTarget.classList.add("hidden");
      if (this.hasIconTarget) {
        this.iconTarget.classList.add("fa-chevron-down");
        this.iconTarget.classList.remove("fa-chevron-up");
      }
    }
  }
}
