import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"

flatpickr("#trip_start_date", {
  altInput: true,
  plugins: [new rangePlugin({ input: "#trip_end_date" })]
})

flatpickr("#transportation_departure_date", {
  altInput: true,
  enableTime: true,
  plugins: [new rangePlugin({ input: "#transportation_arrival_date" })]
})
