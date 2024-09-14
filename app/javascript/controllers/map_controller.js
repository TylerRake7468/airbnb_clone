import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['property', 'latitude', 'longitude']
  connect() {
    let map;
    let markers = [];
    let properties;
    let setLatitude;
    let setLongitude;
    if(this.targets.find('property')){
      properties = this.propertyTargets;
    }
    if(this.targets.find('latitude') && this.targets.find('longitude')){
      setLatitude = this.latitudeTarget;
      setLongitude = this.longitudeTarget;
    }

    let initialPosition;
    const initMap = async () => {
      if(properties && properties.length != 0){
        initialPosition = {
          lat: parseFloat(properties[0].dataset.latitude), 
          lng: parseFloat(properties[0].dataset.longitude)
        };
      }else{
        initialPosition = {
          lat: parseFloat(this.element.dataset.currentLatitude) || 0, 
          lng: parseFloat(this.element.dataset.currentLongitude) || 0
        };
        console.log("this.element.dataset",this.element.dataset.currentLatitude);
      }

      const { Map } = await google.maps.importLibrary("maps");
      const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

      map = new Map(document.getElementById("map"), {
          zoom: 4,
          center: initialPosition,
          mapId: "DEMO_MAP_ID",
      });

      if( properties && properties.length != 0){

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
          markers.push(marker);
        });
      }else{
        // get lat/lng in edit page based on mouse event click

        map.addListener("click", (mapsMouseEvent) => {
          if(setLatitude && setLongitude){
            setLatitude.value = mapsMouseEvent.latLng.toJSON().lat;
            setLongitude.value = mapsMouseEvent.latLng.toJSON().lng;
            const locationTag = document.createElement("div");

            locationTag.className = "price-tag";
            locationTag.textContent = 'Location';    

            const marker = new AdvancedMarkerElement({
                map: map,
                position: mapsMouseEvent.latLng.toJSON(),
                content: locationTag,
            });
            for(let i=0; i<markers.length;i++){
              markers[i].setMap(null);
            }
            markers.push(marker);
          }
        });
      }
    }
    initMap();
  }
}


