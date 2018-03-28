import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"

function findTripDates(){
  const tripDates = document.getElementById("trip_dates");
  if (tripDates) {
    return JSON.parse(tripDates.dataset.tripDates);
  }
  return {}
}

const tripStartDate = document.getElementById("trip_start_date");
if (tripStartDate) {
  flatpickr("#trip_start_date", {
    altInput: true,
    altFormat: "F j, Y",
    dateFormat: "Y-m-d",
    'static': true,
    minDate: "today",
    plugins: [new rangePlugin({ input: "#trip_end_date" })]
  })
}

const transportationDepartureDate = document.getElementById("transportation_departure_date");
if (transportationDepartureDate) {
  flatpickr("#transportation_departure_date", {
    altInput: true,
    altFormat: "F j, Y",
    dateFormat: "Y-m-d",
    enableTime: true,
    'static': true,
    minDate: findTripDates().start_date,
    maxDate: findTripDates().end_date,
    plugins: [new rangePlugin({ input: "#transportation_arrival_date" })]
  })
}

const accommodationStartDate = document.getElementById("accommodation_start_date");
if (accommodationStartDate) {
  flatpickr("#accommodation_start_date", {
    altInput: true,
    altFormat: "F j, Y",
    dateFormat: "Y-m-d",
    enableTime: true,
    'static': true,
    minDate: findTripDates().start_date,
    maxDate: findTripDates().end_date,
    plugins: [new rangePlugin({ input: "#accommodation_end_date" })]
  })
}

const restaurantDate = document.getElementById("restaurant_date");
if (restaurantDate) {
  flatpickr("#restaurant_date", {
    altInput: true,
    altFormat: "F j, Y",
    dateFormat: "Y-m-d",
    enableTime: true,
    'static': true,
    minDate: findTripDates().start_date,
    maxDate: findTripDates().end_date
  })
}

const activityDate = document.getElementById("activity_date");
if (activityDate) {
  flatpickr("#activity_date", {
    altInput: true,
    altFormat: "F j, Y",
    dateFormat: "Y-m-d",
    enableTime: true,
    'static': true,
    minDate: findTripDates().start_date,
    maxDate: findTripDates().end_date
  })
}
