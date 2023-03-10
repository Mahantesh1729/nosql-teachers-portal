import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'consts/constants.dart';

enum Attendance { present, absent }

class TakeAttendance extends StatefulWidget {
  TakeAttendance({required this.courseName, required this.teacherKey});

  final String courseName;
  final String teacherKey;

  @override
  State<TakeAttendance> createState() => _TakeAttendanceState();
}

class _TakeAttendanceState extends State<TakeAttendance> {
  var parsedJson;
  bool loading = true;
  int ln = 0;
  Future<void> getStudents() async {
    var url = Uri.parse(baseurl + lecturerGetAttendance);

    String k = widget.teacherKey.substring(1, widget.teacherKey.length - 1);

    var response = await http.post(
      url,
      body: {"courseName": widget.courseName},
    );
    if (response.statusCode == 201) {
      print(response.statusCode);
      print(response.body);

      setState(() {
        loading = false;
      });
      if (response.body != "No courses Yet") {
        parsedJson = jsonDecode(response.body);
        ln = parsedJson["All_Students_Data"].length;
      } else
        parsedJson = [];
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  void responseBody() async {
    var url = Uri.parse(baseurl + lecturerGetAttendance);

    String k = widget.teacherKey.substring(1, widget.teacherKey.length - 1);

    var response = await http.post(
      url,
      body: {"courseName": widget.courseName},
    );
    if (response.statusCode == 201) {
      print(response.statusCode);
      print(response.body);

      setState(() {
        loading = false;
      });

      if (response.body != "No courses Yet") {
        parsedJson = jsonDecode(response.body);
        ln = parsedJson["All_Students_Data"].length;
      } else
        parsedJson = [];
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  @override
  void initState() {
    super.initState();
    responseBody();
  }

  List<Attendance> attended =
      List<Attendance>.generate(300, (index) => Attendance.present);

  int cardCount = 0;
  List<int> cardList = [];
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: getStudents,
      child: Scaffold(
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: FloatingActionButton(
            backgroundColor: Color.fromARGB(
              230,
              247,
              187,
              133,
            ),
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Text("Submit"),
            onPressed: () async {
              var url = Uri.parse(baseurl + lecturerAddAttendance);

              String k =
                  widget.teacherKey.substring(1, widget.teacherKey.length - 1);
              DateTime now = new DateTime.now();

              String today = DateTime(now.day, now.month, now.year).toString();

              setState(() {
                loading = true;
              });
              List arr = [];

              for (int i = 0; i < parsedJson["All_Students_Data"].length; i++)
                arr.add({
                  "student": parsedJson["All_Students_Data"][i]["usn"],
                  "attendance": attended[i] == Attendance.present ? true : false
                });
              print("ranavickrama");
              var response = await http.post(url,
                  headers: {
                    'Content-type': 'application/json',
                    "Accept": "application/json",
                  },
                  body: json.encode({
                    "key": "63c2753e81a1369752a9b7d6",
                    "dateString": "12122024",
                    "course": widget.courseName,
                    "attendances": arr
                  }));
              print("kantirava");
              print(response.statusCode);
              print(response.body);

              setState(() {
                loading = false;
              });
            },
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://c4.wallpaperflare.com/wallpaper/629/222/456/plain-hd-widescreen-wallpaper-preview.jpg"),
                    fit: BoxFit.cover)),
          ),
          title: Text("Take Attendance"),
        ),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : ln == 0
                ? Stack(
                    children: [
                      ListView(),
                      Center(
                        child: Text("No Students Joined Yet!"),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        top: 15.0, right: 10, left: 10, bottom: 10),
                    child: CupertinoScrollbar(
                      child: ListView.builder(
                          itemCount: parsedJson["All_Students_Data"].length,
                          itemBuilder: (content, index) {
                            return Container(
                              height: 70,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(parsedJson["All_Students_Data"]
                                                [index]["name"]),
                                            Text(parsedJson["All_Students_Data"]
                                                [index]["usn"])
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
                            );
                          }),
                    )),
      ),
    );
  }
}
