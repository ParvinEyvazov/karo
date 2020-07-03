import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/login_bloc/bloc/login_bloc.dart';

import 'package:karo_app/community_side/components/build_text_form_field.dart';
import 'package:karo_app/community_side/components/custom_submit_button.dart';
import 'package:karo_app/community_side/ui/community_change_password_page.dart';
import 'package:karo_app/community_side/ui/community_homepage.dart';
import 'package:karo_app/models/community.dart';
import 'package:karo_app/ui/welcomePages/login_page.dart';

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
      communityManagerController,
      communityInstagramController,
      communityTwitterController;
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
    communityInstagramController =
        TextEditingController(text: widget.community.instagram);
    communityTwitterController =
        TextEditingController(text: widget.community.twitter);

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
              maxLength: null,
              inputType: TextInputType.text,
              focusNode: null,
              controller: communityNameController,
              validatorFunction: null,
              prefixIcon: null,
            ),
            SizedBox(height: 20),
            BuildTextFormField(
              labelText: "Description",
              placeholder: "Enter description",
              isPassword: false,
              maxLength: null,
              inputType: TextInputType.multiline,
              focusNode: null,
              controller: communityDescriptionController,
              validatorFunction: null,
              prefixIcon: null,
            ),
            SizedBox(height: 20),
            BuildTextFormField(
              labelText: "Supervisor",
              placeholder: "Enter name of supervisor",
              isPassword: false,
              maxLength: null,
              inputType: TextInputType.text,
              focusNode: null,
              controller: communitySupervisorController,
              validatorFunction: null,
              prefixIcon: null,
            ),
            SizedBox(height: 20),
            BuildTextFormField(
              labelText: "Contact Info",
              placeholder: "Enter contact info",
              isPassword: false,
              maxLength: null,
              inputType: TextInputType.text,
              focusNode: null,
              controller: communityContactInfoController,
              validatorFunction: null,
              prefixIcon: null,
            ),
            SizedBox(height: 20),
            BuildTextFormField(
              labelText: "Office Address",
              placeholder: "Enter office address",
              isPassword: false,
              maxLength: null,
              inputType: TextInputType.text,
              focusNode: null,
              controller: communityOfficeAddressController,
              validatorFunction: null,
              prefixIcon: null,
            ),
            SizedBox(height: 20),
            BuildTextFormField(
              labelText: "Manager",
              placeholder: "Enter name of Manager",
              isPassword: false,
              maxLength: null,
              inputType: TextInputType.text,
              focusNode: null,
              controller: communityManagerController,
              validatorFunction: null,
              prefixIcon: null,
            ),
            SizedBox(height: 20),
            BuildTextFormField(
              labelText: "Instagram",
              placeholder: "Enter name instagram address",
              isPassword: false,
              maxLength: null,
              inputType: TextInputType.text,
              focusNode: null,
              controller: communityInstagramController,
              validatorFunction: null,
              prefixIcon: null,
            ),
            SizedBox(height: 20),
            BuildTextFormField(
              labelText: "Twitter",
              placeholder: "Enter name twitter address",
              isPassword: false,
              maxLength: null,
              inputType: TextInputType.text,
              focusNode: null,
              controller: communityTwitterController,
              validatorFunction: null,
              prefixIcon: null,
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CustomSubmitButton(
                  buttonName: "UPDATE",
                  onPressedFunction: updateCommunityInfo,
                  buttonColor: Colors.blue[500],
                  buttonTextColor: Colors.white,
                ),
                SizedBox(height: 20),

                // CHANGE PASSWORD PART
                FlatButton(
                  onPressed: () {
                    Future(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CommunityChangePasswordPage(
                                community_id: widget.community.commId,
                              )));
                    });
                  },
                  child: Text(
                    "Change Password",
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
                SizedBox(height: 20),
                FlatButton(
                  onPressed: () {
                    Future(() {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MultiBlocProvider(providers: [
                                    BlocProvider(
                                      create: (context) => LoginBloc(),
                                    )
                                  ], child: LoginPage())),
                          (Route<dynamic> route) => false);
                    });
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            //LOG OUT BUTTON
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
        communityInstagramController.text,
        communityTwitterController.text,
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
