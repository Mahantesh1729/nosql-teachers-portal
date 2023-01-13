import 'dart:convert';

import 'consts/constants.dart';
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

    print(k);

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

  @override
  void initState() {
    super.initState();
    responseBody();
  }

  List<String> images = [
    "https://media.istockphoto.com/id/1162337513/photo/school-supplies-border-against-white-background.jpg?s=170667a&w=0&k=20&c=pe0jcmBkYmrDxOMkTPEoRqP-RgOtDRrlpLW6Jvdv9xs=",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM4J70kWDfTxbb4P_WNjvj6Ethr4Qcobcpxx3_DdsFb082OWxFeV_lyHtq6UemK3mBSY8&usqp=CAU",
    "https://i.pinimg.com/736x/af/9f/a8/af9fa80248793a4c95302a6426e656a2.jpg",
    "https://img.freepik.com/free-vector/back-school-background-with-empty-space_23-2148609200.jpg?w=2000",
    "https://static.vecteezy.com/system/resources/previews/005/964/667/original/welcome-back-to-school-background-template-school-supplies-on-white-background-vector.jpg",
    "https://c8.alamy.com/zooms/9/4bf27f42c0734108a7400d06f8f1066b/p7637d.jpg",
    "https://s3.envato.com/files/252564750/20180720-Capture0012.jpg",
    "https://img.freepik.com/free-photo/back-school-background-with-school-supplies-copy-space_23-2148958973.jpg?w=2000",
    "https://www.freevector.com/uploads/vector/preview/31305/Revision_Freevector_School-Stationary_Background_Mf0421-01.jpg"
  ];
  int length = 0;

  final subjectController = TextEditingController();
  final codeController = TextEditingController();
  final sectionController = TextEditingController();
  final yearController = TextEditingController();

  bool fieldsNotFilled = false;
  String errorMessage = "All fields are required!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Text(
          "My Classes",
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                  image: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM4J70kWDfTxbb4P_WNjvj6Ethr4Qcobcpxx3_DdsFb082OWxFeV_lyHtq6UemK3mBSY8&usqp=CAU",
                  ),
                  fit: BoxFit.fill)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("New Classroom"),
                content: Column(
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
                          hintText: 'Class C',
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
                          hintText: 'Lecture ID',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: yearController,
                        // textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 90, 104, 110),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Lecture ID',
                        ),
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
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
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                    itemCount: parsedJson.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 7,
                            mainAxisSpacing: 7),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ClassAttendance()));
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(parsedJson[index]["name"]
                                        .split('-')[0]),
                                    Text(parsedJson[index]["name"]
                                        .split('-')[1]),
                                    Text(parsedJson[index]["name"]
                                            .split('-')[2] +
                                        '-' +
                                        parsedJson[index]["name"]
                                            .split('-')[3]),
                                  ],
                                )),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            images[index % images.length]),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                          ));
                    },
                  )),
            ),
    );
  }
}
