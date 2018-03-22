import $ from 'jquery';
import "fullcalendar/dist/fullcalendar.min.css"
import 'fullcalendar';

function displayCalendar() {
  const calendarElement = document.getElementById('calendar');
  if (calendarElement) {
    const events = JSON.parse(calendarElement.dataset.events);
      $('#calendar').fullCalendar({
          header: {
            left: 'months,weeks,days'
          },
          views: {
            months: {
            type: 'agendaWeek',
            duration: { days: 31 },
            buttonText: 'Months'
            },
            weeks: {
            type: 'agenda',
            duration: { days: 7 },
            buttonText: 'Weeks'
            },
            days: {
            type: 'agenda',
            duration: { days: 1 },
            buttonText: 'Days'
            }
          },
          events: events
        })
  }
}

export {displayCalendar}

