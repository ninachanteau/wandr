function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var transportationDeparturePort = document.getElementById('transportation_departure_port');
    var transportationArrivalPort = document.getElementById('transportation_arrival_port');
    var accommodationAddress = document.getElementById('accommodation_address');
    var restaurantAddress = document.getElementById('restaurant_address');
    var activityAddress = document.getElementById('activity_address');

    if (transportationDeparturePort) {
      var autocomplete = new google.maps.places.Autocomplete(transportationDeparturePort, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(transportationDeparturePort, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
    if (transportationArrivalPort) {
      var autocomplete = new google.maps.places.Autocomplete(transportationArrivalPort, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(transportationArrivalPort, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
    if (accommodationAddress) {
      var autocomplete = new google.maps.places.Autocomplete(accommodationAddress, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(accommodationAddress, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
    if (restaurantAddress) {
      console.log(google.maps.places)
      console.log("2")
      var autocomplete = new google.maps.places.Autocomplete(restaurantAddress, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(restaurantAddress, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
    if (activityAddress) {
      console.log("3")
      var autocomplete = new google.maps.places.Autocomplete(activityAddress, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(activityAddress, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { autocomplete };
