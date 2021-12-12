import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inventory_app/components/custom_button.dart';
import 'package:inventory_app/components/input_field.dart';
import 'package:inventory_app/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_app/screens/add_material_screen/add_material_screen.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _callApi = false;
  bool _invalidCredentials = false;

  Map<String, String> formContent = {};

  bool emptyFields(User user) {
    return (user.email.isEmpty || user.password.isEmpty);
  }

  Future<bool> validatePassword(User user) async {
    final response = await http.post(
      Uri.parse("${dotenv.env['BACKEND_SERVER']}/api/v1/users/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        "email": user.email,
        "password": user.password,
      }),
    );

    return (response.statusCode == 200);
  }

  @override
  Widget build(BuildContext context) {
    User user = new User();
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.1),
            Text(
              "LOGIN TO CONTINUE",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            Image.asset("lib/assets/icons/login-user.png"),
            _invalidCredentials
                ? Text(
                    "Invalid Credentials",
                    style: TextStyle(
                      color: Colors.red[800],
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : SizedBox.shrink(),
            InputField(
              fieldName: 'email',
              hintText: 'Enter your email',
              icon: Icons.mail,
              textInputType: TextInputType.emailAddress,
              formContent: formContent,
            ),
            InputField(
              fieldName: 'password',
              obscureText: true,
              hintText: 'Enter your password',
              icon: Icons.lock,
              formContent: formContent,
            ),
            CustomButton(
              child: _callApi
                  ? SpinKitCircle(size: 30, color: Colors.black)
                  : Image.asset("lib/assets/icons/login.png"),
              bgColor: Colors.yellow[200] as Color,
              onPressed: () async {
                _formKey.currentState!.save();
                user.email = formContent['email']!;
                user.password = formContent['password']!;

                if (emptyFields(user)) {
                  _formKey.currentState!.reset();
                  setState(() {
                    _invalidCredentials = true;
                  });
                  return;
                }

                setState(() {
                  _callApi = true;
                });

                bool isValidPassword = await validatePassword(user);
                if (isValidPassword) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddMaterialScreen(),
                    ),
                  );
                } else {
                  _formKey.currentState!.reset();
                  setState(() {
                    _callApi = false;
                    _invalidCredentials = true;
                  });
                }
              },
            ),
            SizedBox(height: size.height * 0.05),
            Text(
              "Don't have an account? Create one.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
