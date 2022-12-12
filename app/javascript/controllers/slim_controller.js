import { Controller } from "@hotwired/stimulus"
import SlimSelect from "slim-select"

// Connects to data-controller="slim"
export default class extends Controller {
  connect() {
    console.log("slim controller connected")
    new SlimSelect({
      select: this.element,
    })
  }
}
