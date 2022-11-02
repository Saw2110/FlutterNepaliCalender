import 'package:flutter/material.dart';
import 'package:mycalender/nepali_calendar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nepali Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final NepaliCalendarController _nepaliCalendarController =
      NepaliCalendarController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final NepaliDateTime first = NepaliDateTime(2020, 1);
    final NepaliDateTime last = NepaliDateTime(2095, 12);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nepali Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            NepaliCalendar(
              initialDate: NepaliDateTime.now(),
              firstDate: first,
              lastDate: last,
              language: Language.nepali,

              headerDayBuilder: (_, index) {
                return Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        _,
                        style: TextStyle(
                          color: (index == 6) ? Colors.red : null,
                        ),
                      ),
                    ));
              },

              headerBuilder: (_, __, ___, ____, ______) => const Text("header"),
              headerDayType: HeaderDayType.fullName,
              controller: _nepaliCalendarController,
              onHeaderLongPressed: (date) {
                debugPrint("header long pressed $date");
              },
              onHeaderTapped: (date) {
                debugPrint("header tapped $date");
              },
              calendarStyle: CalendarStyle(
                // weekEndTextColor : Colors.green,
                selectedColor: Colors.deepOrange,
                dayStyle: const TextStyle(fontWeight: FontWeight.bold),
                todayStyle: const TextStyle(
                  fontSize: 20.0,
                ),
                todayColor: Colors.orange.shade400,
                // highlightSelected: true,
                renderDaysOfWeek: true,
                highlightToday: true,
              ),
              headerStyle: const HeaderStyle(
                enableFadeTransition: false,
                centerHeaderTitle: false,
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                    fontSize: 20.0),
              ),

              onDaySelected: (day) {
                debugPrint(day.toString());
              },

              // display the english date along with nepali date.
              dateCellBuilder: cellBuilder,
              selectableDayPredicate: (NepaliDateTime day) {
                return true;
              },
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                var result = NepaliDateTime.now();
                debugPrint("Time Stamp => $result");
              },
              child: const Text("Nepali Date Time Stamp"),
            )
          ],
        ),
      ),
    );
  }

  Widget cellBuilder(isToday, isSelected, isDisabled, nepaliDate, label, text,
      calendarStyle, isWeekend) {
    // debugPrint(isSelected);
    Decoration buildCellDecoration() {
      if (isSelected && isToday) {
        return BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(5),
            color: Colors.blue,
            border: Border.all(color: calendarStyle.selectedColor));
      }
      if (isSelected) {
        return BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: calendarStyle.selectedColor));
      } else if (isToday && calendarStyle.highlightToday) {
        return BoxDecoration(
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.transparent),
          color: Colors.blue,
        );
      } else {
        return BoxDecoration(
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.transparent),
        );
      }
    }

    return AnimatedContainer(
      padding: const EdgeInsets.all(3),
      duration: const Duration(milliseconds: 2000),
      decoration: buildCellDecoration(),
      child: Center(
        child: Column(
          children: [
            Text(text,
                style: TextStyle(
                    fontSize: 20, color: isWeekend ? Colors.red : null)),

            // to show events
            const Align(
                alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  radius: 1,
                )),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(nepaliDate.toDateTime().day.toString(),
                  style: TextStyle(
                      fontSize: 8, color: isWeekend ? Colors.red : null)),
            ),
          ],
        ),
      ),
    );
  }
}
