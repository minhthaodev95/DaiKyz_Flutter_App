import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarWeek extends StatefulWidget {
  TableCalendarWeek({Key? key, required this.selectedDay}) : super(key: key);

  DateTime focusedDay = DateTime.now();
  DateTime selectedDay;
  @override
  State<TableCalendarWeek> createState() => _TableCalendarWeekState();
}

class _TableCalendarWeekState extends State<TableCalendarWeek> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      selectedDayPredicate: (day) {
        return isSameDay(widget.selectedDay, day);
      },
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        setState(() {
          widget.selectedDay = selectedDay;
          widget.focusedDay = focusedDay;
        });
      },
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: widget.selectedDay,
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
          border: Border.all(
            color: const Color(0xff5B67CA).withOpacity(0.55),
            width: 1,
          ),
          color: const Color(0xff5B67CA).withOpacity(0.15),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12.0),
        ),
        selectedDecoration: const BoxDecoration(
          color: Color(0xff5B67CA),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        defaultDecoration: const BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        weekendDecoration: const BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        weekendTextStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
        ),
        defaultTextStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
        ),
        todayTextStyle: const TextStyle(
          color: Colors.black,
          fontFamily: 'Roboto',
          fontSize: 14,
        ),
      ),
    );
  }
}
