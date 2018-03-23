import $ from 'jquery';
import "fullcalendar/dist/fullcalendar.min.css"
import 'fullcalendar';

function displayCalendar() {
  const calendarElement = document.getElementById('calendar');
  if (calendarElement) {
    const events = JSON.parse(calendarElement.dataset.events);
      $('#calendar').fullCalendar({
          header: {
            left:   'title',
            center: 'months,weeks,days'
          },
          buttonText: {
            today:    'today',
            month:    'M',
            week:     'W',
            day:      'D'
          },
          views: {
            months: {
              type: 'month',
            },
            weeks: {
              type: 'agendaWeek',
              titleFormat: 'MMM D',
              columnHeaderFormat: 'ddd D',
              scrollTime: "08:00:00",
              nowIndicator: true
            },
            days: {
              type: 'agenda',
              duration: { days: 1 },
              titleFormat: 'MMMM D',
              scrollTime: "08:00:00",
              nowIndicator: true
            }
          },
          events: events
        })
  }
}

export {displayCalendar}

