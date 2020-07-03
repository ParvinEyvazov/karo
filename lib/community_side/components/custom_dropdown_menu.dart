import 'package:flutter/material.dart';
import 'package:karo_app/community_side/components/custom_box_decoration.dart';

class CustomDropdownMenu extends StatelessWidget {
  String value;
  void Function(String) onChanged;
  List<String> list;

  CustomDropdownMenu(
      {@required this.value, @required this.onChanged, @required this.list});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            decoration: CustomBoxDecoration().create(Colors.white, 10),
            child: DropdownButton<String>(
              value: value,
              style: TextStyle(color: Colors.black45),
              onChanged: onChanged,
              items: list.map((String currentFaculty) {
                return DropdownMenuItem(
                  child: Text(
                    currentFaculty,
                    style: TextStyle(fontSize: 17),
                  ),
                  value: currentFaculty,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
