import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import 'consts/constants.dart';
import 'main.dart';
import 'take_attendance.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'class_attendance.dart';

import 'package:http/http.dart' as http;

class MyClasses extends StatefulWidget {
  MyClasses({required this.teacherKey});

  final String teacherKey;

  @override
  State<MyClasses> createState() => _MyClassesState();
}

class _MyClassesState extends State<MyClasses> {
  var parsedJson;
  bool loading = true;

  void responseBody() async {
    var url = Uri.parse(baseurl + lecturerGetCourses);

    String k = widget.teacherKey.substring(1, widget.teacherKey.length - 1);

    var response = await http.post(
      url,
      body: {"key": k},
    );
    if (response.statusCode == 200) {
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

  Future<void> findClasses() async {
    var url1 = Uri.parse(baseurl + lecturerGetCourses);

    String k = widget.teacherKey.substring(1, widget.teacherKey.length - 1);

    var response1 = await http.post(
      url1,
      body: {"key": k},
    );
    if (response1.statusCode == 200) {
      print(response1.statusCode);
      print(response1.body);

      setState(() {
        loading = false;
      });
      if (response1.body != "No courses Yet")
        parsedJson = jsonDecode(response1.body);
      else
        parsedJson = [];
    } else {
      print(response1.statusCode);
      // print(response1.body);
    }
  }

  @override
  void initState() {
    super.initState();
    responseBody();
  }

  List<String> images = [
    "https://c4.wallpaperflare.com/wallpaper/165/275/593/colorful-windows-10-gradient-minimalism-soft-gradient-hd-wallpaper-preview.jpg",
  ];
  int length = 0;

  final subjectController = TextEditingController();
  final codeController = TextEditingController();
  final sectionController = TextEditingController();
  final yearController = TextEditingController();

  bool fieldsNotFilled = false;
  String errorMessage = "All fields are required!";

  bool formBuffering = false;
  bool formSuccess = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => exit(0),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            PopupMenuButton(
              // add icon, by default "3 dot" icon
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    value: 2,
                    child: TextButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();

                          await prefs.remove('key1');

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => Home()),
                              (route) => false);

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ];
              },
            ),
          ],
          leading: const BackButton(
            color: Colors.black,
          ),
          centerTitle: true,
          toolbarHeight: MediaQuery.of(context).size.height * 0.15,
          title: Text(
            "My Classes",
            style: TextStyle(color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://c4.wallpaperflare.com/wallpaper/629/222/456/plain-hd-widescreen-wallpaper-preview.jpg"),
                    fit: BoxFit.fill)),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(
            230,
            247,
            187,
            133,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AlertDialog(
                        title: Text(
                          "New Classroom",
                          textAlign: TextAlign.center,
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: subjectController,
                                  // textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 90, 104, 110),
                                    ),
                                    border: OutlineInputBorder(),
                                    hintText: 'Subject',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: codeController,
                                  // textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 90, 104, 110),
                                    ),
                                    border: OutlineInputBorder(),
                                    hintText: 'Course Code',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: sectionController,
                                  // textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 90, 104, 110),
                                    ),
                                    border: OutlineInputBorder(),
                                    hintText: 'Section',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                child: TextField(
                                  controller: yearController,
                                  // textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 90, 104, 110),
                                    ),
                                    border: OutlineInputBorder(),
                                    hintText: 'Academic Year',
                                  ),
                                ),
                              ),
                              if (formBuffering)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                ),
                              if (fieldsNotFilled)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    errorMessage,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              if (formSuccess)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "New Class Successflully Created",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(
                              230,
                              247,
                              187,
                              133,
                            )),
                            child: Text("Cancel"),
                            onPressed: () {
                              fieldsNotFilled = false;
                              formSuccess = false;
                              subjectController.text = "";
                              codeController.text = "";
                              sectionController.text = "";
                              yearController.text = "";
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(
                              230,
                              247,
                              187,
                              133,
                            )),
                            child: Text("Create"),
                            onPressed: () async {
                              if (subjectController.text.isEmpty ||
                                  codeController.text.isEmpty ||
                                  sectionController.text.isEmpty ||
                                  yearController.text.isEmpty) {
                                setState(() {
                                  fieldsNotFilled = true;
                                });
                              } else {
                                var url =
                                    Uri.parse(baseurl + lecturerAddCourse);
                                setState(() {
                                  formBuffering = true;
                                });
                                print("hello");
                                String courseName = sectionController.text +
                                    "-" +
                                    subjectController.text +
                                    "-" +
                                    yearController.text;

                                String k = widget.teacherKey
                                    .substring(1, widget.teacherKey.length - 1);

                                var response = await http.post(
                                  url,
                                  body: {
                                    "key": k,
                                    "lecturerID": "dummy",
                                    "name": courseName,
                                    "courseCode": codeController.text
                                  },
                                );
                                print(response.statusCode);
                                print(response.body);
                                if (response.statusCode == 201) {
                                  setState(() {
                                    formBuffering = false;
                                    errorMessage = "Course already exists";
                                    fieldsNotFilled = true;
                                    formSuccess = false;
                                  });
                                } else if (response.statusCode == 200) {
                                  setState(() {
                                    fieldsNotFilled = false;
                                    formBuffering = false;
                                    formSuccess = true;
                                  });

                                  await Future.delayed(Duration(seconds: 1));
                                  formSuccess = false;
                                  subjectController.text = "";
                                  codeController.text = "";
                                  sectionController.text = "";
                                  yearController.text = "";
                                  Navigator.pop(context);
                                } else {
                                  setState(() {
                                    formBuffering = false;
                                    errorMessage = response.body;
                                    fieldsNotFilled = true;
                                  });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: findClasses,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: parsedJson.length == 0
                      ? Stack(
                          children: [
                            ListView(),
                            Center(
                              child: Text("No Classes Created Yet!"),
                            ),
                          ],
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: GridView.builder(
                            itemCount: parsedJson.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 7,
                                    mainAxisSpacing: 7),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ClassAttendance(
                                                  teacherKey: widget.teacherKey,
                                                  subject: parsedJson[index][0]
                                                              ["name"]
                                                          .split('-')[1] +
                                                      " " +
                                                      parsedJson[index][0]
                                                              ["name"]
                                                          .split('-')[0],
                                                  courseName: parsedJson[index]
                                                      [0]["name"],
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: PhysicalModel(
                                      elevation: 10,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        child: Center(
                                            child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                    onPressed: () async {
                                                      showDialog(
                                                        context: context,
                                                        builder: (ctx) =>
                                                            AlertDialog(
                                                          title: const Text(
                                                              "Are You Sure?"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        ctx)
                                                                    .pop();
                                                              },
                                                              child: Text("No"),
                                                            ),
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                var url = Uri.parse(
                                                                    baseurl +
                                                                        lectureDeleteCourse);

                                                                var response =
                                                                    await http
                                                                        .post(
                                                                  url,
                                                                  body: {
                                                                    "courseName":
                                                                        parsedJson[index][0]
                                                                            [
                                                                            "name"]
                                                                  },
                                                                );

                                                                print(response
                                                                    .body);
                                                                print(response
                                                                    .statusCode);

                                                                responseBody();
                                                                Navigator.of(
                                                                        ctx)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                "Yes",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    child: Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.black,
                                                    ))
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(parsedJson[index][0]
                                                        ["name"]
                                                    .split('-')[1]),
                                                Text(parsedJson[index][0]
                                                        ["name"]
                                                    .split('-')[0]),
                                                Text(parsedJson[index][0]
                                                            ["name"]
                                                        .split('-')[2] +
                                                    '-' +
                                                    parsedJson[index][0]["name"]
                                                        .split('-')[3]),
                                              ],
                                            ),
                                          ],
                                        )),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: NetworkImage(images[
                                                    index % images.length]),
                                                fit: BoxFit.fill)),
                                      ),
                                    ),
                                  ));
                            },
                          )),
                ),
              ),
      ),
    );
  }
}
