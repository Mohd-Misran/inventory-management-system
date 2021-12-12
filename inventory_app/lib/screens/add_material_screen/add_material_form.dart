import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inventory_app/components/custom_button.dart';
import 'package:inventory_app/components/input_field.dart';

class AddMaterialForm extends StatefulWidget {
  @override
  _AddMaterialFormState createState() => _AddMaterialFormState();
}

class _AddMaterialFormState extends State<AddMaterialForm> {
  final _formKey = GlobalKey<FormState>();
  bool _callApi = false;

  Map<String, String> formContent = {};

  bool emptyFields(Map<String, String> formContent) {
    bool result = false;
    formContent.forEach((key, value) {
      if (value.isEmpty) {
        result = true;
      }
    });
    return result;
  }

  Future<bool> addMaterial(Map<String, String> formContent) async {
    final response = await http.post(
      Uri.parse("${dotenv.env['BACKEND_SERVER']}/api/v1/materials"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(formContent),
    );

    return (response.statusCode == 201);
  }

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: size.height * 0.05),
            Text(
              "Add New Material",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            InputField(
              fieldName: "partName",
              hintText: "Enter the part name",
              icon: Icons.handyman,
              formContent: formContent,
            ),
            InputField(
              fieldName: "quantity",
              hintText: "Enter the quantity",
              icon: Icons.tag,
              textInputType: TextInputType.number,
              formContent: formContent,
            ),
            InputField(
              fieldName: "description",
              hintText: "Enter the description",
              icon: Icons.description,
              formContent: formContent,
            ),
            InputField(
              fieldName: "date",
              hintText: "Enter the date",
              icon: Icons.description,
              textInputType: TextInputType.datetime,
              formContent: formContent,
            ),
            InputField(
              fieldName: "vendor",
              hintText: "Enter the vendor name",
              icon: Icons.groups,
              formContent: formContent,
            ),
            InputField(
              fieldName: "billNo",
              hintText: "Enter the bill number",
              icon: Icons.list_alt,
              formContent: formContent,
            ),
            InputField(
              fieldName: "cost",
              hintText: "Enter the cost",
              icon: Icons.attach_money,
              textInputType: TextInputType.number,
              formContent: formContent,
            ),
            CustomButton(
              child: _callApi
                  ? SpinKitCircle(size: 30, color: Colors.black)
                  : Text(
                      "SUBMIT",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
              bgColor: Colors.green[200] as Color,
              onPressed: () async {
                _formKey.currentState!.save();
                if (emptyFields(formContent)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red[800],
                      content: Text(
                        "All fields are required.",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                  return;
                }

                setState(() {
                  _callApi = true;
                });
                bool result = await addMaterial(formContent);
                if (result) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green[800],
                      content: Text(
                        "Added material successfully.",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                  setState(() {
                    _callApi = false;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
