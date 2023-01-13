import 'take_attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ClassAttendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
              //replace with our own icon data.
            ),
            title: Text("NoSql 7C"),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Row(
                    children: [
                      Icon(Icons.bookmark_add),
                      Text("Attendance"),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      Icon(Icons.download),
                      Text("View Attendance"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              TakeAttendance(),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}
