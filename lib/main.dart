// import 'package:attendance/curve_screen.dart';
import 'package:teachers_portal/register.dart';

import 'my_classes.dart';
import 'faculty_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_template.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  Widget gradientButton(
      {required String name,
      required Function navigate,
      required bool facultyLogin}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Color.fromARGB(255, 255, 255, 255),
              padding: const EdgeInsets.all(16.0),
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              navigate(facultyLogin: facultyLogin);
            },
            child: Text(name),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void navigate({required bool facultyLogin}) {
      Navigator.push(
        context,
        facultyLogin
            ? MaterialPageRoute(builder: (context) => FacultyLogin())
            : MaterialPageRoute(builder: (context) => FacultyRegister()),
      );
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 220,
              width: 220,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                "Attendance System \n    Teacher's Portal",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            gradientButton(
                name: "Faculty Login ", navigate: navigate, facultyLogin: true),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New to the portal, ",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                    onPressed: () {
                      navigate(facultyLogin: false);
                    },
                    child: Text("Register here"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
