import 'package:flutter/material.dart';
import 'package:inventory_app/screens/add_material_screen/add_material_form.dart';

class AddMaterialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: AddMaterialForm(),
        ),
      ),
    );
  }
}
