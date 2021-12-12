import 'package:flutter/material.dart';
import 'package:inventory_app/colors.dart';

class InputField extends StatelessWidget {
  final String fieldName;
  final bool obscureText;
  final String hintText;
  final IconData icon;
  final TextInputType textInputType;
  final Map<String, String> formContent;

  const InputField({
    required this.fieldName,
    this.obscureText = false,
    required this.hintText,
    required this.icon,
    this.textInputType = TextInputType.text,
    required this.formContent,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: inputFieldColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        obscureText: this.obscureText,
        cursorColor: Colors.black,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.black),
          hintText: this.hintText,
          hintStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
        ),
        keyboardType: textInputType,
        onSaved: (value) {
          formContent[fieldName] = value!;
        },
      ),
    );
  }
}
