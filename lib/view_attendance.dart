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

class ViewAttendance extends StatefulWidget {
  ViewAttendance({required this.courseName, required this.teacherKey});

  final String courseName;
  final String teacherKey;

  @override
  State<ViewAttendance> createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  var parsedJson;
  bool loading = true;
  int ln = 0;

  Future<void> getStudents() async {
    var url = Uri.parse(baseurl + lecturerGetAttendance);

    String k = widget.teacherKey.substring(1, widget.teacherKey.length - 1);
    print(k);
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
      if (response.body != "No courses Yet")
        parsedJson = jsonDecode(response.body);
      else
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

      if (response.body != "No courses Yet") {
        parsedJson = jsonDecode(response.body);
        ln = parsedJson["All_Students_Data"].length;
      } else
        parsedJson = [];
    } else {
      print(response.statusCode);
      print(response.body);
    }

    setState(() {
      loading = false;
    });
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
          title: Text("View Attendance"),
        ),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : ln == 0
                ? Stack(
                    children: [
                      ListView(),
                      Center(
                        child: Text("No Classes Created Yet!"),
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
                                      Text(parsedJson["All_Students_Data"]
                                                  [index]["Attendance"] ==
                                              null
                                          ? "0"
                                          : parsedJson["All_Students_Data"]
                                                      [index]["Attendance"]
                                                  .toDouble()
                                                  .toStringAsFixed(2) +
                                              "%"),
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
