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
            type: 'month',
            buttonText: 'Months'
            },
            weeks: {
            type: 'agendaWeek',
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

