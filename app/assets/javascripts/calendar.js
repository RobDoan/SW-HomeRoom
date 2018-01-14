$(document).ready(function () {
  if ($('#calendar').length > 0) {
    $('#calendar').fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay,listMonth'
      },
      themeSystem: 'standard',
      defaultView: 'agendaWeek',
      navLinks: true, // can click day/week names to navigate views
      businessHours: true, // display business hours
      editable: true,
      events: [
        {
          id: 'availablebooking',
          start: '2018-01-16T10:00:00',
          end: '2018-01-16T14:00:00',
          color: '#00f',
          editable: false,
          overlap: false,
          rendering: 'background'
        },
        {
          id: 'availablebooking',
          start: '2018-01-16T16:00:00',
          end: '2018-01-16T18:00:00',
          color: '#00f',
          editable: false,
          overlap: false,
          rendering: 'background'
        },
        {
          id: 'availablebooking',
          start: '2018-01-14T10:00:00',
          end: '2018-01-14T12:00:00',
          editable: false,
          color: '#00f',
          overlap: false,
          rendering: 'background'
        },
        {
          id: 'availablebooking',
          start: '2018-01-14T16:00:00',
          end: '2018-01-14T18:00:00',
          editable: false,
          color: '#00f',
          overlap: false,
          rendering: 'background'
        },
      ],
      selectConstraint: 'availablebooking',
      selectable: true,
      selectHelper: true,
      select: function (start, end, jsEvent, view) {
        $('#calendar').fullCalendar('renderEvent', {
          title: 'Justin',
          start: start,
          editable: true,
          end: end
        }, true)
      },
      // dayClick: function(date, jsEvent, view){
      //   console.info(date)
      // },
      slotDuration: '00:20:00',
      slotEventOverlap: false,
      minTime: '06:00:00',
      maxTime: '20:00:00',
      allDaySlot: false
    });
  }
});
