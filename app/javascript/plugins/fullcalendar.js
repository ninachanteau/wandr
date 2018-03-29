import $ from 'jquery';
import "fullcalendar/dist/fullcalendar.min.css"
import 'fullcalendar';

function displayCalendar() {
  const calendarElement = document.getElementById('calendar');
  if (calendarElement) {
    const events = JSON.parse(calendarElement.dataset.events);
    $('#calendar').fullCalendar({
        locale: 'en',
        firstDay: 1,
        height: 450,
        header: {
          left:   'title'
          // center: 'months,weeks,days',
        },
        buttonText: {
          today:    'today',
          month:    'M',
          week:     'W',
          day:      'D'
        },
        views: {
          months: {
            type: 'month'
          },
          weeks: {
            type: 'agendaWeek',
            titleFormat: 'MMM D',
            columnHeaderFormat: 'ddd D',
            scrollTime: "10:00:00",
            nowIndicator: true,
            slotDuration:'01:00:00',
            slotLabelInterval: "02:00"
          },
          days: {
            type: 'agenda',
            duration: { days: 1 },
            titleFormat: 'MMMM D',
            scrollTime: "10:00:00",
            nowIndicator: true,
            slotDuration:'01:00:00',
            slotLabelInterval: "02:00"
          }
        },
        events: events
      });

    if (events.length !== 0 ) {
      $('#calendar').fullCalendar('gotoDate', new Date(events[0].start));
    }

  }
}

export {displayCalendar}

