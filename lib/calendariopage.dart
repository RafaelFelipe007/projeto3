import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'tudo_list_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    // Do not pre-select a day on open. Leave _selectedDay null so
    // onDaySelected is triggered only when the user taps a date.
    _selectedDay = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendário')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TableCalendar(
          firstDay: DateTime.now().subtract(const Duration(days: 365)),
          lastDay: DateTime.now().add(const Duration(days: 365)),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TodoListPage(selectedDate: selectedDay),
              ),
            );
          },
          calendarFormat: CalendarFormat.month,
        ),
      ),
    );
  }
}
