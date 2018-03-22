import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"

flatpickr("#trip_start_date", {
  altInput: true,
  'static': true,
  plugins: [new rangePlugin({ input: "#trip_end_date" })]
})

flatpickr("#transportation_departure_date", {
  altInput: true,
  enableTime: true,
  'static': true,
  plugins: [new rangePlugin({ input: "#transportation_arrival_date" })]
})

flatpickr("#restaurant_date", {
  altInput: true,
  enableTime: true,
  'static': true,
})

flatpickr("#accommodation_start_date", {
  altInput: true,
  enableTime: true,
  'static': true,
  plugins: [new rangePlugin({ input: "#accommodation_end_date" })]
})

