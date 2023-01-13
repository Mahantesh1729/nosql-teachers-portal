import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

enum Attendance { present, absent }

class TakeAttendance extends StatefulWidget {
  @override
  State<TakeAttendance> createState() => _TakeAttendanceState();
}

class _TakeAttendanceState extends State<TakeAttendance> {
  List<Attendance> attended =
      List<Attendance>.generate(60, (index) => Attendance.present);

  int cardCount = 0;
  List<int> cardList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Take Attendance"),
        backgroundColor: Colors.amber[400],
      ),
      body: Padding(
          padding:
              const EdgeInsets.only(top: 15.0, right: 10, left: 10, bottom: 10),
          child: CupertinoScrollbar(
            child: ListView.builder(
                itemCount: 61,
                itemBuilder: (content, index) {
                  return index < 60
                      ? Container(
                          height: 70,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Jackie Chan'),
                                        Text('1BM19CS219')
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text("P"),
                                      Radio(
                                          value: Attendance.present,
                                          groupValue: attended[index],
                                          activeColor: Colors.green,
                                          onChanged: (value) {
                                            setState(() {
                                              attended[index] = value!;
                                            });
                                          }),
                                      Text("A"),
                                      Radio(
                                          activeColor: Colors.red,
                                          value: Attendance.absent,
                                          groupValue: attended[index],
                                          onChanged: (value) {
                                            setState(() {
                                              attended[index] = value!;
                                            });
                                          }),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            elevation: 8,
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                String contentText = "Content of Dialog";
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      elevation: 10,
                                      scrollable: true,
                                      title: Text("Today's Absentees"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          for (int i = 0; i < 10; i++)
                                            Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('Jackie Chan'),
                                                          Text('1BM19CS219')
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text("P"),
                                                        Radio(
                                                            value: Attendance
                                                                .present,
                                                            groupValue:
                                                                attended[0],
                                                            activeColor:
                                                                Colors.green,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                attended[0] =
                                                                    value!;
                                                              });
                                                            }),
                                                        Text("A"),
                                                        Radio(
                                                            activeColor:
                                                                Colors.red,
                                                            value: Attendance
                                                                .absent,
                                                            groupValue:
                                                                attended[0],
                                                            onChanged: (value) {
                                                              setState(() {
                                                                attended[0] =
                                                                    value!;
                                                              });
                                                            }),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              elevation: 8,
                                            ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              contentText =
                                                  "Changed Content of Dialog";
                                            });
                                          },
                                          child: Text("Submit"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Text("Confirm"));
                }),
          )),
    );
  }
}
