import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/user_bloc/bloc/user_bloc.dart';
import 'package:karo_app/models/user.dart';
import 'package:karo_app/ui/changePassword.dart';
import 'package:karo_app/ui/homepage.dart';
import 'package:karo_app/ui/profile_page.dart';
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: userNameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          hintText: "Name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    //surname text form field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: userSurNameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_box),
                          hintText: "Surname",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    //mail text form field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: userMailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline),
                          hintText: "Mail",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    //DROPDOWN PARTS
                    //DROPDOWN OF FACULTY
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: facultyValue,
                        hint: Text(facultyValue),
                        //fetch array
                        items: faculty.map((String currentFaculty) {
                          return DropdownMenuItem(
                            child: Text(currentFaculty),
                            value: currentFaculty,
                          );
                        }).toList(),

                        onChanged: (String selected) {
                          setState(() {
                            facultyValue = selected;
                            department = tempFac.departments[facultyValue];
                            departmentValue = department[0];
                          });
                        },
                      ),
                    ),

                    //DROPDOWN OF DEPARTMENT
                    //DROPDOWN OF department
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton(
                          value: departmentValue,
                          hint: Text(departmentValue),
                          items: department.map((String currentDepartment) {
                            return DropdownMenuItem(
                              child: Text(currentDepartment),
                              value: currentDepartment,
                            );
                          }).toList(),
                          onChanged: (String selected) {
                            setState(() {
                              departmentValue = selected;
                            });
                          }),
                    ),

                    //-----------------SAVE BUTTON---------------.
                    Center(
                      child: RaisedButton(
                        child: Text("Save"),
                        onPressed: () {
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
                                        user_id: widget.user.userID,aimPage: 2,
                                      )),
                              (route) => false);
                        },
                      ),
                    ),

                    SizedBox(height: 150),

                    // CHANGE PASSWORD PART
                    FlatButton(
                        onPressed: () {
                          Future(() {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ChangePasswordPage(user_id: widget.user.userID,)));
                          });
                        },
                        child: Text("Change Password")),
                    
                    SizedBox(height: 10),

                    //LOG OUT BUTTON
                    FlatButton(
                        onPressed: () {
                          Future(() {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        WelcomePage()),
                                (Route<dynamic> route) => false);
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
