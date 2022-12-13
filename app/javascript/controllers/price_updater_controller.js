import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="price-updater"
export default class extends Controller {
  static targets = [  "startTime", "finishTime", "output",  "price", "startAirport", "finishAirport"  ]



  connect() {
    console.log("Connected to price updater controller.")
    this.changePrice()
  }



  // findAirportById(id) {
  //   let query = `query { SELECT * FROM airports WHERE id = ${id} }`
  //   fetch(query)
  // }

  // calculateDistance() {
  // const startAirport = findAirportById( this.startAirportTarget.value);
  // const finishAirport = findAirportById( this.finishAirportTarget.value);

  // const distances = geolib.getDistance(
  // {latitude: startAirport.lat, longitude: startAirport.lon},
  // {latitude: finishAirport.lat, longitude: finishAirport.lon}
  // );
  // return distances = Math.round(distances * 0.001 * 10) / 10;
  // }



  changePrice(event) {
    fetch(`/airports/price?start_airport_id=${this.startAirportTarget.value}&finish_airport_id=${this.finishAirportTarget.value}`, {
      headers: { accept: "application/json" },
      method: "POST",
      body: JSON.stringify({
        start_airport_id: this.startAirportTarget.value,
        finish_airport_id: this.finishAirportTarget.value,
      }),
    })
    .then(response => response.json())
    .then((data) => {
      this.priced = data.price;
      this.calculateTotalPrice();
    });
    // let startTime = new Date(this.startTimeTarget.value).getTime()
    // let endTime = new Date(this.finishTimeTarget.value).getTime()
    // let days = Math.abs(endTime - startTime) / (1000 * 60 * 60 * 24) + 1
    // let price = this.priceTarget.dataset.price
    // let total = price * days + cv  || 0
    // let formattedNumber = total.toLocaleString('de-DE') + " USD"
    // this.outputTarget.innerHTML = `<b>  ${formattedNumber}  </b>`;
  }
  calculateTotalPrice() {
    let startTime = new Date(this.startTimeTarget.value).getTime()
    if (this.finishTimeTarget.value === "") {
      this.finishTimeTarget.value = this.startTimeTarget.value
    }


    let endTime = new Date(this.finishTimeTarget.value).getTime()
    let days = Math.abs(endTime - startTime) / (1000 * 60 * 60 * 24) + 1
    let price = this.priceTarget.dataset.price
    let cv = this.priced
    let total = price * days + cv || 0
    let formattedNumber = total.toLocaleString('de-DE') + " USD"
    this.outputTarget.innerHTML = `<b>  ${formattedNumber}  </b>`;
  }
}
