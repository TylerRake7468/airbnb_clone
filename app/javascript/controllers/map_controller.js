import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["property"];
  connect() {
    let map;
    const properties = this.propertyTargets;
    async function initMap() {
    const position = { lat: -25.344, lng: 131.031 };
    const { Map } = await google.maps.importLibrary("maps");
    const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

    map = new Map(document.getElementById("map"), {
        zoom: 4,
        center: position,
        mapId: "DEMO_MAP_ID",
    });

    properties.forEach(element => {
      const location = {lat: parseFloat(element.dataset.latitude), lng: parseFloat(element.dataset.longitude)};  
      const priceTag = document.createElement("div");

      priceTag.className = "price-tag";
      priceTag.textContent = element.dataset.price;
      const marker = new AdvancedMarkerElement({
          map: map,
          position: location,
          content: priceTag,
      });
    });
    }

    initMap();

  }
}


