import 'package:flutter/material.dart';

class BuildTextFormField extends StatelessWidget {
  String labelText;
  String placeholder;
  bool isPassword;
  int maxLength;
  TextInputType inputType;
  FocusNode focusNode;
  TextEditingController controller;
  String Function(String) validatorFunction;

  BuildTextFormField(
      {@required this.labelText,
      @required this.placeholder,
      @required this.isPassword,
      @required this.maxLength,
      @required this.inputType,
      @required this.focusNode,
      @required this.controller,
      @required this.validatorFunction});

  final blueColor = Color(0XFF5e92f3);
  final yellowColor = Color(0XFFfdd835);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(color: blueColor, fontSize: 12),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
              maxLines: null,
              controller: controller,
              maxLength: maxLength,
              obscureText: isPassword,
              keyboardType: inputType,
              focusNode: focusNode,
              validator: validatorFunction,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                filled: true,
                fillColor: Colors.grey[200],
                hintText: placeholder,
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]),
                ),
              ))
        ],
      ),
    );
  }
}
