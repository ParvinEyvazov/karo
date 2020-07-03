import 'package:flutter/material.dart';
import 'package:karo_app/community_side/components/custom_box_decoration.dart';

class BuildCommunityListTile extends StatelessWidget {
  void Function() onTap;
  String communityName;
  String communityDescription;

  BuildCommunityListTile(
      {@required this.onTap,
      @required this.communityName,
      @required this.communityDescription});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        child: Container(
          decoration: CustomBoxDecoration().create(Colors.white, 10),
          child: ListTile(
            onTap: onTap,
            title: Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  communityName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            subtitle: Container(
              padding: EdgeInsets.only(top: 15.0, bottom: 20.0),
              child: Text(communityDescription),
            ),
          ),
        ),
      ),
    );
  }
}
