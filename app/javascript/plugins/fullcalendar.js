import $ from 'jquery';
import "fullcalendar/dist/fullcalendar.min.css"
import 'fullcalendar';

function displayCalendar() {
  $('#calendar').fullCalendar({
      // put your options and callbacks here
    })
}

export {displayCalendar}
