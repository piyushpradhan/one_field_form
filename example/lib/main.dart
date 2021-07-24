import 'package:flutter/material.dart';
import 'package:one_field_form/one_field_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: OneFieldLoginForm(
            animationDuration: Duration(milliseconds: 200),
            textEditingController: controller,
            login: () {
              print("logged in");
            },
            onEmailSubmit: () {},
            onPasswordSubmit: () {},
            textFieldPadding: EdgeInsets.only(left: 55, right: 20, top: 3),
            textFieldBorderStyle: BorderStyle.solid,
            iconBorderStyle: BorderStyle.solid,
            iconErrorColor: Colors.red,
            textFieldErrorBorderColor: Colors.red,
            iconErrorBorderColor: Colors.red,
            validateEmail: () {
              return controller.text.isNotEmpty;
            },
            validatePassword: () {
              return controller.text.isNotEmpty;
            },
          ),
        ),
      ),
    );
  }
}
