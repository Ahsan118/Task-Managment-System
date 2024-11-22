import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { searchUrl: String }

  
  performSearch(event) {
    const form = event.target.closest("form");
    const searchUrl = this.searchUrlValue || form.action;
    const formData = new FormData(form);
    const queryParams = new URLSearchParams(formData).toString();

    clearTimeout(this.timeout);

    this.timeout = setTimeout(() => {
      fetch(`${searchUrl}?${queryParams}`, {
        headers: {
          "X-Requested-With": "XMLHttpRequest",
          "Accept": "text/javascript"
        }
      })
      .then(response => response.ok ? response.text() : Promise.reject("Error"))
      .then(html => document.getElementById('search-results').innerHTML = html)
      .catch(error => console.error('Search error:', error));
    }, 300);
  }
}