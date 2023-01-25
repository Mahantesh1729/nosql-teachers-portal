import 'package:teachers_portal/view_attendance.dart';

import 'consts/constants.dart';
import 'take_attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ClassAttendance extends StatefulWidget {
  ClassAttendance(
      {required this.teacherKey,
      required this.subject,
      required this.courseName});

  final String teacherKey;
  final String subject;
  final String courseName;

  @override
  State<ClassAttendance> createState() => _ClassAttendanceState();
}

class _ClassAttendanceState extends State<ClassAttendance> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: MediaQuery.of(context).size.height * 0.10,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                      image: NetworkImage(
                          "https://c4.wallpaperflare.com/wallpaper/629/222/456/plain-hd-widescreen-wallpaper-preview.jpg"),
                      fit: BoxFit.fill)),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
              //replace with our own icon data.
            ),
            title: Text(widget.subject),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: Row(
                    children: [
                      // Icon(Icons.bookmark_add),
                      Text(
                        "Attendance",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      Text("View Attendance",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              TakeAttendance(
                  courseName: widget.courseName, teacherKey: widget.teacherKey),
              ViewAttendance(
                  courseName: widget.courseName, teacherKey: widget.teacherKey)
            ],
          ),
        ),
      ),
    );
  }
}
