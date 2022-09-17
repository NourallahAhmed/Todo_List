import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:todo_list/CustomTimePickerWidget/TimePickerWidget.dart';
import 'package:todo_list/HomePage/home_page.dart';
import 'package:todo_list/main.dart';

class Creating_Event extends StatefulWidget {
  final Function() notifyParent;

  final DateTime selectedDay;

  const Creating_Event(
      {Key? key, required this.selectedDay, required this.notifyParent})
      : super(key: key);

  @override
  State<Creating_Event> createState() => _Creating_EventState(selectedDay);
}

class _Creating_EventState extends State<Creating_Event> {
  final _formKey = GlobalKey<FormState>();

  var taskDesc = TextEditingController();
  var taskSummary = TextEditingController();
  var taskIsDone = TextEditingController();
  var taskStartTime = TextEditingController();
  var taskEndTime = TextEditingController();
  var hourSelected_Start = TextEditingController();
  var minSelected_Start= TextEditingController();


  var hourSelected_End = TextEditingController();
  var minSelected_End = TextEditingController();
  var taskLocation = TextEditingController();

  var taskIsAllDay = false;

  Color selectedColor = Colors.blue;

  late final CleanCalendarEvent event;

  DateTime selectedDay;

  //MARK: TimePicker


  var isAM_Start = false;
  var isPM_Start = false;

  var isAM_End = false;
  var isPM_End = false;


  _Creating_EventState(this.selectedDay);

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
            appBar: AppBar(title: const Text("Create new Events")),
            body:
             Container(
               height: double.infinity,
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.lightBlueAccent),
                    // borderRadius: const BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                      Colors.blue.withOpacity(0.0),
                      Colors.white,
                    ],
                        stops: const [
                      0.0,
                      1.0
                    ])
                    // color: Colors.blue.shade200
                    ),
                child:  SingleChildScrollView(
                  child: Column(
                    children: [
                      ///   TITLE
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Create New Task ",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Image.network(
                              "https://images-na.ssl-images-amazon.com/images/I/31RvOPlfH7L.png",
                              height: 60,
                              width: 60,
                            ),
                          ],
                        ),
                      ),

                      /// Description
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },

                          decoration: const InputDecoration(
                            //90CAF9FF
                            fillColor: Colors.blue, //.fromARGB(09,56, 79, 98)  ,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(color: Colors.blueAccent, width: 1)),
                            hintText: "Description",
                            prefixIcon: Icon(
                              Icons.description,
                              color: Colors.blue,
                            ),
                          ),
                          controller: taskDesc,
                        ),
                      ),

                      /// Summary
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },

                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(color: Colors.blueAccent, width: 1)),
                            hintText: "Summary",
                            prefixIcon: Icon(
                              Icons.description,
                              color: Colors.blue,
                            ),
                          ),
                          controller: taskSummary,
                        ),
                      ),


                      /// Location
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(color: Colors.blueAccent, width: 1)),
                            hintText: "location",
                            // labelText: IsEditable ? widget.event.location : "",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: Icon(
                              Icons.location_city,
                              color: Colors.blue,
                            ),
                          ),
                          controller: taskLocation,
                        ),
                      ),


                      /// IS ALL DAY
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.blueAccent, width: 1.0),
                            borderRadius: const BorderRadius.all(Radius.circular(
                                    10.0) //                 <--- border radius here
                                ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                "Is All Day : ",
                                style: TextStyle(color: Colors.blue),
                              ),
                              Checkbox(
                                checkColor: Colors.blue,
                                activeColor: Colors.white,
                                value: taskIsAllDay,
                                onChanged: (value) {
                                  setState(() {
                                    taskIsAllDay
                                        ? taskIsAllDay = false
                                        : taskIsAllDay = true;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),


                      /// Start Time
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                Text("Start Time" , style: TextStyle(color: Colors.blue),),
                                Icon(Icons.timer , color: Colors.blue, )
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                /// HR
                                Flexible(
                                  child: TextField(
                                    maxLength: 2,
                                    decoration: const InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(4),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            borderSide: BorderSide(width: 2)),
                                        hintText: "${TimeOfDay.hoursPerDay}",
                                        labelText: "hr"),
                                    controller: hourSelected_Start,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),

                                /// MIN
                                Flexible(
                                  child: TextField(
                                    maxLength: 2,
                                    decoration: const InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(4),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            borderSide: BorderSide(width: 2)),
                                        hintText: "${TimeOfDay.minutesPerHour}",
                                        labelText: "min"),
                                    controller: minSelected_Start,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),

                                /// AM / PM
                                Flexible(
                                    child: Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (isAM_Start) {
                                                isAM_Start = false;
                                                isPM_Start = true;
                                              } else {
                                                isAM_Start = true;
                                                isPM_Start = false;
                                              }
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: isAM_Start ? Colors.blue.shade200 : Colors.grey,
                                          ),
                                          child: const Text("AM",
                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                if (isPM_Start) {
                                                  isPM_Start = false;
                                                  isAM_Start = true;
                                                } else {
                                                  isAM_Start = false;
                                                  isPM_Start = true;
                                                }
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: isPM_Start ? Colors.blue.shade200 : Colors.grey,
                                            ),
                                            child: const Text("PM",
                                                style: TextStyle(fontWeight: FontWeight.bold))),
                                      ],
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),


                      /// End Time

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                Text("End Time" , style: TextStyle(color: Colors.blue),),
                                Icon(Icons.timer , color: Colors.blue, )
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                /// HR
                                Flexible(
                                  child: TextField(
                                    maxLength: 2,
                                    decoration: const InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(4),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            borderSide: BorderSide(width: 2)),
                                        hintText: "${TimeOfDay.hoursPerDay}",
                                        labelText: "hr"),
                                    controller: hourSelected_End,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),

                                /// MIN
                                Flexible(
                                  child: TextField(
                                    maxLength: 2,
                                    decoration: const InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(4),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            borderSide: BorderSide(width: 2)),
                                        hintText: "${TimeOfDay.minutesPerHour}",
                                        labelText: "min"),
                                    controller: minSelected_End,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),

                                /// AM / PM
                                Flexible(
                                    child: Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {


                                              if (isAM_End) {
                                                isAM_End = false;
                                                isPM_End = true;
                                              } else {
                                                isAM_End = true;
                                                isPM_End = false;
                                              }



                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: isAM_End ? Colors.blue.shade200  : Colors.grey,
                                          ),
                                          child: const Text("AM",
                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                if (isPM_End) {
                                                  isPM_End = false;
                                                  isAM_End = true;
                                                } else {
                                                  isAM_End = false;
                                                  isPM_End = true;
                                                }
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: isPM_End ? Colors.blue.shade200 : Colors.grey,
                                            ),
                                            child: const Text("PM",
                                                style: TextStyle(fontWeight: FontWeight.bold))),
                                      ],
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),


                      //TODO: priority
                      Container(
                        // padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                        // alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          // color: Colors.blue.shade200
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Priority: ",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 15)),
                            OutlinedButton(
                              autofocus: false,
                              onPressed: () {
                                selectedColor = Colors.red;
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    // <-- Icon
                                    Icons.circle,
                                    size: 24.0,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('High'), // <-- Text
                                ],
                              ),
                            ),
                            OutlinedButton(
                              autofocus: false,
                              onPressed: () {
                                selectedColor = Colors.blue;
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    // <-- Icon
                                    Icons.circle,
                                    size: 24.0,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Normal'), // <-- Text
                                ],
                              ),
                            ),
                            OutlinedButton(
                              autofocus: false,
                              onPressed: () {
                                selectedColor = Colors.yellow;
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    // <-- Icon
                                    Icons.circle,
                                    size: 24.0,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Low'), // <-- Text
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(
                                    'Processing Data')),
                              );

                              event = CleanCalendarEvent(taskSummary.text,
                                  startTime: DateTime(
                                      selectedDay.year,
                                      selectedDay.month,
                                      selectedDay.day,
                                      int.parse(hourSelected_Start.text),
                                      int.parse(hourSelected_Start.text)),
                                  endTime: DateTime(
                                      selectedDay.year,
                                      selectedDay.month,
                                      selectedDay.day,
                                      int.parse(hourSelected_End.text),
                                      int.parse(hourSelected_End.text)));

                              event.description = taskDesc.text;

                              event.location = taskLocation.text;
                              event.isAllDay = taskIsAllDay;
                              event.color = selectedColor;

                              if (MyHomePage.events.containsKey(DateTime(
                                  selectedDay.year,
                                  selectedDay.month,
                                  selectedDay.day))) {
                                MyHomePage.events.update(
                                    DateTime(
                                        selectedDay.year, selectedDay.month,
                                        selectedDay.day),
                                        (value) => value + [event]);
                              } else {
                                Map<DateTime,
                                    List<CleanCalendarEvent>> instance = {
                                  DateTime(selectedDay.year, selectedDay.month,
                                      selectedDay.day): [
                                    event,
                                  ]
                                };

                                MyHomePage.events.addAll(instance);
                              }
                              widget.notifyParent();

                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Create'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
    );
  }
}
