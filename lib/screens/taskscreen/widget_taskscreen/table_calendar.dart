import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarWeek extends StatelessWidget {
  const TableCalendarWeek({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
      calendarFormat: CalendarFormat.week,
      headerVisible: false,
      startingDayOfWeek: StartingDayOfWeek.monday,
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: Color(0xff10275A),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto',
        ),
        weekendStyle: TextStyle(
          color: Color(0xff10275A),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto',
        ),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
            color: const Color(0xff5B67CA),
            borderRadius: BorderRadius.circular(12.0)),
        weekendTextStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
        ),
        defaultTextStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
        ),
        todayTextStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: 14,
        ),
      ),
    );
  }
}
