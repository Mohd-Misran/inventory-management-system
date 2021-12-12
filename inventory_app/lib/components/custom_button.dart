import 'package:flutter/material.dart';
import 'package:inventory_app/colors.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Color bgColor;
  final Function() onPressed;

  const CustomButton({
    required this.child,
    required this.bgColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ElevatedButton(
          child: child,
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          ),
        ),
      ),
    );
  }
}
