import 'package:flutter/material.dart';
import 'package:inventory_app/screens/login_screen/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(child: LoginForm()),
      ),
    );
  }
}
