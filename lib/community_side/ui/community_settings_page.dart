import 'package:flutter/material.dart';

import 'package:karo_app/community_side/components/build_text_form_field.dart';
import 'package:karo_app/community_side/components/custom_submit_button.dart';
import 'package:karo_app/community_side/ui/community_homepage.dart';
import 'package:karo_app/models/community.dart';

import 'package:karo_app/ui/welcomePages/welcome_page.dart';

import 'package:karo_app/utils/database_helper.dart';

class CommunitySettingsPage extends StatefulWidget {
  Community community;

  CommunitySettingsPage({@required this.community}) : assert(community != null);

  @override
  _CommunitySettingsPageState createState() => _CommunitySettingsPageState();
}

class _CommunitySettingsPageState extends State<CommunitySettingsPage> {
  TextEditingController communityNameController,
      communityDescriptionController,
      communitySupervisorController,
      communityContactInfoController,
      communityOfficeAddressController,
      communityPhoneController,
      communityManagerController;
  DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    communityNameController =
        TextEditingController(text: widget.community.commName);
    communityDescriptionController =
        TextEditingController(text: widget.community.commDesc);
    communitySupervisorController =
        TextEditingController(text: widget.community.supervisor);
    communityContactInfoController =
        TextEditingController(text: widget.community.contactInfo);
    communityOfficeAddressController =
        TextEditingController(text: widget.community.officeAddress);
    communityPhoneController =
        TextEditingController(text: widget.community.phone);
    communityManagerController =
        TextEditingController(text: widget.community.commManager);

    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),

      //body

      body: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(8),
        child: Form(
            child: ListView(
          children: <Widget>[
            //TEXTFORM FIELDS

            BuildTextFormField(
                labelText: "Name",
                placeholder: "Enter community name",
                isPassword: false,
                maxLength: 50,
                inputType: TextInputType.text,
                focusNode: null,
                controller: communityNameController,
                validatorFunction: null),
            BuildTextFormField(
                labelText: "Description",
                placeholder: "Enter description",
                isPassword: false,
                maxLength: 500,
                inputType: TextInputType.multiline,
                focusNode: null,
                controller: communityDescriptionController,
                validatorFunction: null),
            BuildTextFormField(
                labelText: "Supervisor",
                placeholder: "Enter name of supervisor",
                isPassword: false,
                maxLength: 50,
                inputType: TextInputType.text,
                focusNode: null,
                controller: communitySupervisorController,
                validatorFunction: null),
            BuildTextFormField(
                labelText: "Contact Info",
                placeholder: "Enter contact info",
                isPassword: false,
                maxLength: 100,
                inputType: TextInputType.text,
                focusNode: null,
                controller: communityContactInfoController,
                validatorFunction: null),
            BuildTextFormField(
                labelText: "Office Address",
                placeholder: "Enter office address",
                isPassword: false,
                maxLength: 200,
                inputType: TextInputType.text,
                focusNode: null,
                controller: communityOfficeAddressController,
                validatorFunction: null),
            BuildTextFormField(
                labelText: "Manager",
                placeholder: "Enter name of Manager",
                isPassword: false,
                maxLength: 50,
                inputType: TextInputType.text,
                focusNode: null,
                controller: communityManagerController,
                validatorFunction: null),
            SizedBox(height: 10),

            //LOG OUT BUTTON
            CustomSubmitButton(
              buttonName: "UPDATE",
              onPressedFunction: updateCommunityInfo,
            ),
            SizedBox(height: 100),
            CustomSubmitButton(
              buttonName: "LOGOUT",
              onPressedFunction: () {
                Future(() {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => WelcomePage()),
                      (Route<dynamic> route) => false);
                });
              },
            )
          ],
        )),
      ),
    );
  }

  void updateCommunityInfo() async {
    _databaseHelper.updateCommunityInfo(
        communityNameController.text,
        communityDescriptionController.text,
        communitySupervisorController.text,
        communityContactInfoController.text,
        communityOfficeAddressController.text,
        communityManagerController.text,
        communityPhoneController.text,
        widget.community.commId);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => CommunityHomepage(
                  community_id: widget.community.commId,
                  aimPage: 2,
                )),
        (route) => false);
  }
/*

 */
}
