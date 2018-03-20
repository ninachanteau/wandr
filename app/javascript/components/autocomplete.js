function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var accommodationAddress = document.getElementById('accommodation_address');
    var restaurantAddress = document.getElementById('restaurant_address');
    var activityAddress = document.getElementById('activity_address');

    console.log(accommodationAddress)
    console.log(restaurantAddress)
    console.log(activityAddress)
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
