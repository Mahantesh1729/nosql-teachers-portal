import 'package:teachers_portal/consts/constants.dart';
import 'package:teachers_portal/register.dart';

import 'my_classes.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  bool faculty;

  String inputMessage, heading;

  Login(
      {required this.faculty,
      required this.heading,
      required this.inputMessage});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool validate = false;

  String loginMessage = "";
  bool loginFailed = false;
  bool loginSuccess = false;

  Widget build(BuildContext context) {
    void navigate({required bool facultyLogin}) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FacultyRegister()),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.heading,
              style: TextStyle(color: Colors.white, fontSize: 35),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 45),
              child: TextField(
                controller: emailController,
                // textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 90, 104, 110),
                  ),
                  border: OutlineInputBorder(),
                  hintText: widget.inputMessage,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                // textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 90, 104, 110),
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'Enter Your Password',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.width * 0.08),
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ))),
                onPressed: () async {
                  setState(() {
                    validate = true;
                  });

                  var url =
                      Uri.parse("https://nosqlaat.onrender.com/lecturer/login");
                  String email = emailController.text;
                  String password = passwordController.text;

                  if (email.isEmpty || password.isEmpty) {
                    setState(() {
                      validate = false;
                      loginMessage = "All fields required!";
                      loginFailed = true;
                    });
                  } else {
                    var response = await http.post(
                      url,
                      body: {"email": email, "password": password},
                    );

                    if (response.statusCode == 201) {
                      setState(() {
                        loginFailed = false;
                        loginMessage = "Login Successful!";
                        loginSuccess = true;
                        validate = false;
                      });
                      await Future.delayed(Duration(seconds: 1));

                      String teacherKey = response.body;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyClasses(
                                  teacherKey: teacherKey,
                                )),
                      );
                    } else {
                      setState(() {
                        loginMessage = "Login failed!";
                        validate = false;
                        loginFailed = true;
                      });
                    }
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ),
            if (validate) CircularProgressIndicator(),
            if (loginFailed)
              Text(
                loginMessage,
                style: TextStyle(color: Colors.red),
              ),
            if (loginSuccess)
              Text(
                loginMessage,
                style: TextStyle(color: Colors.green),
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
