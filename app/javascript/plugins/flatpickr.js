import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"

flatpickr("#trip_start_date", {
  altInput: true,
  altFormat: "F j, Y",
  dateFormat: "Y-m-d",
  'static': true,
  minDate: "today",
  plugins: [new rangePlugin({ input: "#trip_end_date" })]
})

flatpickr("#transportation_departure_date", {
  altInput: true,
  altFormat: "F j, Y",
  dateFormat: "Y-m-d",
  enableTime: true,
  'static': true,
  // minDate: ,
  // maxDate: ,
  plugins: [new rangePlugin({ input: "#transportation_arrival_date" })]
})

flatpickr("#accommodation_start_date", {
  altInput: true,
  altFormat: "F j, Y",
  dateFormat: "Y-m-d",
  enableTime: true,
  'static': true,
  // minDate: ,
  // maxDate: ,
  plugins: [new rangePlugin({ input: "#accommodation_end_date" })]
})

flatpickr("#restaurant_date", {
  altInput: true,
  altFormat: "F j, Y",
  dateFormat: "Y-m-d",
  enableTime: true,
  'static': true,
  // minDate: ,
  // maxDate:
})

flatpickr("#activity_date", {
  altInput: true,
  altFormat: "F j, Y",
  dateFormat: "Y-m-d",
  enableTime: true,
  'static': true,
  // minDate: ,
  // maxDate:
})
