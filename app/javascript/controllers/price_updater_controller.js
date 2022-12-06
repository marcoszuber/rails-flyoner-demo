import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="price-updater"
export default class extends Controller {
  static targets = [  "startTime", "finishTime", "output",  "price"  ]



  connect() {
    console.log("Connected to price updater controller.")
    this.changePrice()
  }


  changePrice(event) {
    let startTime = new Date(this.startTimeTarget.value).getTime()
    let endTime = new Date(this.finishTimeTarget.value).getTime()
    let days = Math.abs(endTime - startTime) / (1000 * 60 * 60 * 24) + 1
    let price = this.priceTarget.dataset.price
    let total = price * days || 0
    let formattedNumber = total.toLocaleString('de-DE') + " USD"
    this.outputTarget.innerHTML = `<b>  ${formattedNumber}  </b>`;
  }
}
