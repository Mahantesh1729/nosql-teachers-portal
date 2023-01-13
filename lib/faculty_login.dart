import 'login_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FacultyLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Login(faculty: true, heading: "Faculty Login", inputMessage: "Enter Your email",);
  }
}
