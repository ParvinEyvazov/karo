import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  String labelText;
  String placeholder;
  bool isPassword;

  BuildTextField(
      {@required this.labelText,
      @required this.placeholder,
      @required this.isPassword});

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
          TextField(
              obscureText: isPassword,
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
