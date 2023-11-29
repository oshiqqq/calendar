import 'package:flutter/material.dart';
import 'package:calendar/calendar.dart';

void main() {
  runApp(CalendarApp());
}

class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalendarScreen(),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF404242),
        title: Text('Calendar'),
      ),
      body: Center(
        child: Calendar(),
      ),
      backgroundColor: Color(0xFFD1E1F1),
    );
  }
}
