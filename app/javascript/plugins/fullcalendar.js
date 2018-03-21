import $ from 'jquery';
import "fullcalendar/dist/fullcalendar.min.css"
import 'fullcalendar';

function displayCalendar() {
  const calendarElement = document.getElementById('calendar');
  const events = JSON.parse(calendarElement.dataset.events);
  $('#calendar').fullCalendar({
      events: events
    })
}

export {displayCalendar}

