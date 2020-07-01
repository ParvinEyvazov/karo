import 'package:flutter/material.dart';

class BuildSettingButton extends StatelessWidget {
  Widget settingPage;
  BuildSettingButton({@required this.settingPage});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 40,
      top: 50,
      child: InkWell(
        child: IconButton(
            iconSize: 30,
            icon: Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => settingPage));
            }),
      ),
    );
  }
}
