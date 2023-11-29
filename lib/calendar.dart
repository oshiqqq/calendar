import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _currentDate = DateTime.now();
  List<String> _weekDays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
  List<int> _years = List.generate(50, (index) => DateTime.now().year - 25 + index);

  void _previousMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1, _currentDate.day);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1, _currentDate.day);
    });
  }

  void _changeYear(dynamic year) {
    setState(() {
      _currentDate = DateTime(year, _currentDate.month, _currentDate.day);
    });
  }

  void _goToCurrentDate() {
    setState(() {
      _currentDate = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth = DateTime(_currentDate.year, _currentDate.month + 1, 0).day;
    int weekdayOfFirstDay = DateTime(_currentDate.year, _currentDate.month, 1).weekday;
    int currentDay = DateTime.now().day;
    int currentMonth = DateTime.now().month;

    List<String> _days = List.generate(7 * 6, (index) {
      final day = index + 2 - weekdayOfFirstDay;
      if (day <= 0) {
        return (DateTime(_currentDate.year, _currentDate.month, 0).day + day).toString();
      } else if (day > daysInMonth) {
        return '';
      } else {
        return day.toString();
      }
    });

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: _previousMonth,
            ),
            DropdownButton(
              value: _currentDate.year,
              items: _years.map((int year) {
                return DropdownMenuItem(
                  value: year,
                  child: Text(year.toString()),
                );
              }).toList(),
              onChanged: (dynamic value) {
                _changeYear(value);
              },
            ),
            DropdownButton(
              value: DateFormat.yMMMM().format(_currentDate),
              items: List.generate(12, (index) {
                DateTime month = DateTime(_currentDate.year, index + 1, 1);
                return DropdownMenuItem(
                  value: DateFormat.yMMMM().format(month),
                  child: Text(DateFormat.MMM().format(month)),
                );
              }),
              onChanged: (dynamic value) {
                DateTime selectedMonth = DateFormat.yMMMM().parse(value);
                setState(() {
                  _currentDate = selectedMonth;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: _nextMonth,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0,right: 20,left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _weekDays
                .map(
                  (day) => Text(
                day,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
                .toList(),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
          ),
          itemBuilder: (context, index) {
            try {
              int day = int.parse(_days[index]);
              return Center(
                child: Text(
                  _days[index],
                  style: TextStyle(
                    fontSize: 18,
                    color: day == currentDay && _currentDate.month == currentMonth ? Colors.red : Colors.black,
                  ),
                ),
              );
            } catch (e) {
              return Center(
                child: Text(
                  _days[index],
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              );
            }
          },
          itemCount: 7 * 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _goToCurrentDate,
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF404242)),
              child: Text('В текущую дату'),
            ),
          ],
        ),
      ],
    );
  }
}