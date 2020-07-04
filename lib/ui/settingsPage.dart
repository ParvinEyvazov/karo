import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:karo_app/bloc/user_bloc/bloc/user_bloc.dart';
import 'package:karo_app/community_side/components/build_text_form_field.dart';
import 'package:karo_app/community_side/components/custom_dropdown_menu.dart';
import 'package:karo_app/community_side/components/custom_submit_button.dart';
import 'package:karo_app/models/user.dart';
import 'package:karo_app/ui/changePassword.dart';
import 'package:karo_app/ui/homepage.dart';
import 'package:karo_app/ui/profile_page.dart';
import 'package:karo_app/ui/welcomePages/login_page.dart';
import 'package:karo_app/ui/welcomePages/welcome_page.dart';
import 'package:karo_app/models/faculty.dart';
import 'dart:convert';

import 'package:karo_app/utils/database_helper.dart';

class SettingsPage extends StatefulWidget {
  User user;

  SettingsPage({@required this.user}) : assert(user != null);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController userNameController;
  TextEditingController userSurNameController;
  TextEditingController userMailController;
  TextEditingController userFacultyController;
  TextEditingController userDepartmentController;

  List<String> faculty;
  List<String> department;

  String facultyValue;
  String departmentValue;

  Faculty tempFac;
  DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.user.userName);
    userSurNameController =
        TextEditingController(text: widget.user.userSurname);
    userMailController = TextEditingController(text: widget.user.userMail);

    facultyValue = widget.user.faculty;
    departmentValue = widget.user.department;

    _databaseHelper = DatabaseHelper();

    //dropdown part
    //facultyValue = widget.user.faculty;

    //departmentValue = widget.user.department;
  }

  @override
  Widget build(BuildContext context) {
    bool a = false;

    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),

      //body

      body: FutureBuilder(
          future: fetchFacultyInfo(),
          builder: (context, datam) {
            if (datam.hasData) {
              tempFac = datam.data;

              faculty = tempFac.faculties;
              department = tempFac.departments[facultyValue];

              return Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(8),
                child: Form(
                    child: ListView(
                  children: <Widget>[
                    //TEXTFORM FIELDS

                    //name text form field
                    BuildTextFormField(
                      labelText: "Name",
                      placeholder: "Name",
                      isPassword: false,
                      maxLength: null,
                      inputType: TextInputType.text,
                      focusNode: null,
                      controller: userNameController,
                      validatorFunction: null,
                      prefixIcon: Icon(Icons.account_circle),
                    ),
                    SizedBox(height: 20),
                    //surname text form field
                    BuildTextFormField(
                      labelText: "Surname",
                      placeholder: "Surname",
                      isPassword: false,
                      maxLength: null,
                      inputType: TextInputType.text,
                      focusNode: null,
                      controller: userSurNameController,
                      validatorFunction: null,
                      prefixIcon: Icon(Icons.account_box),
                    ),
                    SizedBox(height: 20),
                    //mail text form field
                    BuildTextFormField(
                      labelText: "Mail",
                      placeholder: "Mail",
                      isPassword: false,
                      maxLength: null,
                      inputType: TextInputType.emailAddress,
                      focusNode: null,
                      controller: userMailController,
                      validatorFunction: null,
                      prefixIcon: Icon(Icons.mail_outline),
                    ),
                    SizedBox(height: 20),
                    //DROPDOWN PARTS

                    //DROPDOWN OF FACULTY
                    CustomDropdownMenu(
                        value: facultyValue,
                        onChanged: (String selected) {
                          setState(() {
                            facultyValue = selected;
                            department = tempFac.departments[facultyValue];
                            departmentValue = department[0];
                          });
                        },
                        list: faculty),
                    SizedBox(height: 20),
                    //DROPDOWN OF DEPARTMENT
                    CustomDropdownMenu(
                        value: departmentValue,
                        onChanged: (String selected) {
                          setState(() {
                            departmentValue = selected;
                          });
                        },
                        list: department),
                    SizedBox(
                      height: 100,
                    ),

                    //-----------------SAVE BUTTON---------------.
                    CustomSubmitButton(
                      buttonColor: Colors.blue,
                      buttonName: "Save",
                      buttonTextColor: Colors.white,
                      onPressedFunction: () {
                        _databaseHelper.changeSettingInfoMain(
                            widget.user.userID,
                            userNameController.text,
                            userSurNameController.text,
                            userMailController.text,
                            facultyValue,
                            departmentValue);

                        print("-USER-INFORMATION-UPDATED-");

                        setState(() {});
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => HomePage(
                                      user_id: widget.user.userID,
                                      aimPage: 2,
                                    )),
                            (route) => false);
                      },
                    ),

                    SizedBox(height: 150),

                    // CHANGE PASSWORD PART
                    FlatButton(
                        onPressed: () {
                          Future(() {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ChangePasswordPage(
                                      user_id: widget.user.userID,
                                    )));
                          });
                        },
                        child: Text("Change Password")),

                    SizedBox(height: 10),

                    //LOG OUT BUTTON
                    FlatButton(
                        onPressed: () {
                          Future(() {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MultiBlocProvider(providers: [
                                      BlocProvider(
                                        create: (context) => LoginBloc(),
                                      ),
                                    ], child: LoginPage())));
                          });
                        },
                        child: Text(
                          "Log Out",
                          style: TextStyle(color: Colors.red),
                        ))
                  ],
                )),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
/*

 */

  Future<Faculty> fetchFacultyInfo() async {
    var cJson = await DefaultAssetBundle.of(context)
        .loadString("assets/faculty_deps.json");

    var ne = Faculty.fromJson(json.decode(cJson));

    return ne;
  }
}
