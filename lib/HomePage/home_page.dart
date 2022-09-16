import 'package:flutter/material.dart';

import '../AddingTask/AddingNewTask.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

import '../TaskDetails/task_details_screen.dart';
import 'package:badges/badges.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  static Map<DateTime, List<CleanCalendarEvent>> events = {
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      CleanCalendarEvent('Event A',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 12, 0),
          description: 'A special event',
          color: Colors.blue,
          isDone: true),
    ],
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
        [
      CleanCalendarEvent('Event B',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 12, 0),
          color: Colors.orange),
      CleanCalendarEvent('Event C',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 14, 30),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 17, 0),
          color: Colors.pink),
    ],
  };

  @override
  State<MyHomePage> createState() => _MyHomePageState(MyHomePage.events);
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDay = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0);

  late List<CleanCalendarEvent> selectedEvent;
  Map<DateTime, List<CleanCalendarEvent>> events;

  _MyHomePageState(this.events);

  void _handleData(date) {
    setState(() {
      selectedDay = date;
      selectedEvent = events[selectedDay] ?? [];
      //((a, b) => a.length.compareTo(b.length));
      // selectedEvent.any((element) => element.isDone);
      selectedEvent.sort((a, b) {
        if (b.isDone) {
          return -1;
        }
        return 1;
      });
    });
  }

  @override
  void initState() {
    selectedEvent = events[selectedDay] ?? [];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: SafeArea(
        child: Container(
          color: Colors.white30,
          child: Flexible(
            child: Calendar(
              startOnMonday: true,
              selectedColor: Colors.blue,
              todayColor: Colors.red,
              eventColor: Colors.blue,
              eventDoneColor: Colors.green,
              bottomBarColor: Colors.deepOrange,
              onDateSelected: (date) {
                return _handleData(date);
              },
              events: events,
              onEventSelected: (event) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TaskDetails(
                              event: event,
                            )));
              },

              isExpanded: true,

              dayOfWeekStyle: const TextStyle(
                fontSize: 15,
                color: Colors.black12,
                fontWeight: FontWeight.w100,
              ),
              bottomBarTextStyle: const TextStyle(
                color: Colors.white,
              ),
              hideBottomBar: false,
              hideArrows: false,
              weekDays: const ['Sat', 'Sun','Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
              // locale: "ar",
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddingNewTask(selectedDay: selectedDay)));
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.

      drawer: SizedBox(
        width: 250,
        child: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
               DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Image.asset('assets/images/createTask.png'),

              ),
              ListTile(
                title: const Text('schedule'),
                leading: Badge(
                  badgeContent: Text('${selectedEvent.length}'),
                  child: const Icon(Icons.schedule , color: Colors.blueAccent,),
                ),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage(title: "Events")));
                },
              ),

              ListTile(
                title: const Text("Adding Event"),
                leading: const Icon(Icons.add , color: Colors.blueAccent,),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddingNewTask(selectedDay: selectedDay)));

                },
              ),

              ListTile(
                title: const Text('Habits'),
                leading: const Icon(Icons.heat_pump , color: Colors.blueAccent,),
                onTap: () {
                  Navigator.pop(context);
                  //
                  // Navigator.push(context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             MyHomePage(title: "Events")));
                },
              ),


              ListTile(
                title: const Text('My Todo List'),
                leading: const Icon(Icons.list ,  color: Colors.blueAccent,),
                onTap: () {
                  Navigator.pop(context);

                  // Navigator.push(context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             MyHomePage(title: "Events")));
                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}
