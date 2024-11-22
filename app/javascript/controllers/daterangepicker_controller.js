import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["daterange"];

  connect() {
    this.initializeDateRangePicker();
  }

  initializeDateRangePicker() {
    const element = this.daterangeTarget;
    $(element).daterangepicker({
      autoUpdateInput: false,
      locale: {
        cancelLabel: "Clear",
        format: "YYYY-MM-DD"
      }
    });

    $(element).on("apply.daterangepicker", (event, picker) => {
      element.value = `${picker.startDate.format("YYYY-MM-DD")} - ${picker.endDate.format("YYYY-MM-DD")}`;
      element.dispatchEvent(new Event("change")); // Trigger change event for Stimulus controllers
    });

    $(element).on("cancel.daterangepicker", () => {
      element.value = ""; // Clear the input
      element.dispatchEvent(new Event("change")); // Trigger change event
    });
  }
}
