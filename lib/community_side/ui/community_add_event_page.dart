import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:karo_app/community_side/components/banner_clipper.dart';
import 'package:karo_app/community_side/components/build_add_event_button.dart';
import 'package:karo_app/community_side/components/build_avatar_container.dart';
import 'package:karo_app/community_side/components/build_background_bottom_circle.dart';
import 'package:karo_app/community_side/components/build_text_field.dart';
import 'package:karo_app/community_side/components/build_top_circle.dart';

class CommunityAddEventPage extends StatefulWidget {
  int community_id;
  CommunityAddEventPage({this.community_id});
  @override
  _CommunityAddEventPageState createState() => _CommunityAddEventPageState();
}

class _CommunityAddEventPageState extends State<CommunityAddEventPage> {
  final blueColor = Color(0XFF5e92f3);
  final yellowColor = Color(0XFFfdd835);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BuildTopCircle(),
        BuildBackgroundBottomCircle(blueColor),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 40),
              child: Column(
                children: [
                  Text(
                    "ADD EVENT",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  BuilAvatarContainer(icon: Icons.event_note),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOutBack,
                    height: 400,
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 2,
                            spreadRadius: 1,
                            offset: Offset(0, 1),
                          )
                        ]),
                    child: SingleChildScrollView(
                      child: buildTextFieldsSection(),
                    ),
                  ),
                  BuildAddEventButton(),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Column buildTextFieldsSection() {
    return Column(
      children: [
        BuildTextField(
          labelText: "TITLE",
          placeholder: "Enter title",
          isPassword: false,
        ),
        SizedBox(
          height: 20,
        ),
        BuildTextField(
          labelText: "DESCRIPTION",
          placeholder: "Enter description",
          isPassword: false,
        ),
        SizedBox(
          height: 20,
        ),
        BuildTextField(
          labelText: "DATE",
          placeholder: "Enter date time",
          isPassword: false,
        ),
        SizedBox(
          height: 20,
        ),
        BuildTextField(
          labelText: "LOCATION",
          placeholder: "Enter location",
          isPassword: false,
        ),
        SizedBox(
          height: 20,
        ),
        BuildTextField(
          labelText: "Quota",
          placeholder: "Enter quota",
          isPassword: false,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  
}
