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
        backgroundColor: Colors.black,
        body: Center(
          child: OneFieldLoginForm(
            animationDuration: Duration(milliseconds: 200),
            textEditingController: controller,
            login: () {},
            onEmailSubmit: () {},
            onPasswordSubmit: () {},
          ),
        ),
      ),
    );
  }
}
