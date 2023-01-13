import 'package:teachers_portal/consts/constants.dart';
import 'package:teachers_portal/faculty_login.dart';

import 'my_classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:http/http.dart' as http;

class FacultyRegister extends StatefulWidget {
  @override
  State<FacultyRegister> createState() => _FacultyRegisterState();
}

class _FacultyRegisterState extends State<FacultyRegister> {
  final lectureIdController = TextEditingController();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  bool registering = false;

  String registerMessage = "";

  bool registerError = false;

  bool registerSuccess = false;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.greenAccent,
      body: Form(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              Text(
                "Register",
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                child: TextField(
                  controller: lectureIdController,
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
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                child: TextField(
                  controller: nameController,
                  // textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 90, 104, 110),
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                child: TextFormField(
                  validator: (value) {
                    if (emailController.text.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailController.text)) {
                      return 'Enter a valid email!';
                    }
                    return null;
                  },
                  controller: emailController,
                  // textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 90, 104, 110),
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                child: TextField(
                  controller: phoneController,
                  // textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 90, 104, 110),
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Phone',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                child: TextField(
                  controller: passwordController,
                  // textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 90, 104, 110),
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                child: TextField(
                  controller: confirmPasswordController,
                  // textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 90, 104, 110),
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Confirm Password',
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ))),
                  onPressed: () async {
                    setState(() {
                      registering = true;
                    });

                    if (lectureIdController.text.isEmpty ||
                        nameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty) {
                      setState(() {
                        registerError = true;
                        registerMessage = "All fields are required!";
                        registering = false;
                      });
                    } else if (passwordController.text !=
                        confirmPasswordController.text) {
                      setState(() {
                        registerError = true;
                        registerMessage = "Passwords do not match";
                        registering = false;
                      });
                    } else {
                      var url = Uri.parse(baseurl + lectureRegister);

                      var response = await http.post(
                        url,
                        body: {
                          "lecturerID": lectureIdController.text,
                          "name": nameController.text,
                          "email": emailController.text,
                          "phone": phoneController.text,
                          "password": passwordController.text
                        },
                      );

                      if (response.statusCode == 200) {
                        setState(() {
                          registerError = false;
                          registerMessage = "Registration Successful";
                          registerSuccess = true;
                          registering = false;
                        });

                        await Future.delayed(Duration(seconds: 1));

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FacultyLogin()),
                        );
                      }

                      if (response.statusCode == 501) {
                        setState(() {
                          registerMessage = "User already Exists";
                          registerSuccess = false;
                          registerError = true;
                          registering = false;
                        });
                      }

                      print(response.body);
                      print(response.statusCode);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ),
              if (registering) CircularProgressIndicator(),
              if (registerError)
                Text(
                  registerMessage,
                  style: TextStyle(color: Colors.red),
                ),
              if (registerSuccess)
                Text(
                  registerMessage,
                  style: TextStyle(color: Colors.green),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Existing User, ",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FacultyLogin()),
                      );
                    },
                    child: Text("Login here"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
