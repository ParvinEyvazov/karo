import 'package:flutter/material.dart';
import 'package:karo_app/community_side/components/build_text_form_field.dart';
import 'package:karo_app/models/faculty.dart';
import 'package:karo_app/ui/welcomePages/welcome_page.dart';
import 'package:karo_app/utils/database_helper.dart';
import 'dart:convert';

class Register1Page extends StatefulWidget {
  @override
  _Register1PageState createState() => _Register1PageState();
}

class _Register1PageState extends State<Register1Page> {
  final _nameNode = FocusNode();
  final _surnameNode = FocusNode();
  final _passwordNode = FocusNode();
  final _mailNode = FocusNode();
  final _facultyNode = FocusNode();
  final _departmentNode = FocusNode();

  //text controllers
  TextEditingController studentIDController;
  TextEditingController nameController;
  TextEditingController surnameController;
  TextEditingController mailController;
  TextEditingController password1Controller;
  TextEditingController password2Controller;

  Faculty tempFaculty;

  List<String> faculty;
  List<String> department;

  String facultyValue;
  String departmentValue;

  bool otoValidation = false;
  DatabaseHelper _databaseHelper;

  bool firstTime = true;

  //form key
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    studentIDController = TextEditingController();
    nameController = TextEditingController();
    surnameController = TextEditingController();
    mailController = TextEditingController();
    password1Controller = TextEditingController();
    password2Controller = TextEditingController();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blueGrey.shade400,
      body: FutureBuilder(
          future: fetchFacultyInfo(),
          builder: (context, myData) {
            if (myData.hasData) {
              tempFaculty = myData.data;

              //if it is first time to open page -initialize it
              if (firstTime == true) {
                faculty = tempFaculty.faculties;
                facultyValue = faculty[0];

                department = tempFaculty.departments[facultyValue];
                departmentValue = department[0];
                firstTime = false;
              }

              faculty = tempFaculty.faculties;

              department = tempFaculty.departments[facultyValue];

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'KARO',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Pacifico",
                        fontSize: 100,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    //---------------------REGISTER PART-----------------------
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        autovalidate: otoValidation,
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            //STUDENT ID -------------------------------------------------------------------
                            BuildTextFormField(
                              labelText: null,
                              placeholder: 'Student number',
                              isPassword: false,
                              maxLength: 11,
                              inputType: TextInputType.number,
                              focusNode: null,
                              controller: studentIDController,
                              validatorFunction: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your Student Number';
                                }
                                if (value.length < 11) {
                                  return 'Student number must be at least 11 character.';
                                }
                                return null;
                              },
                              prefixIcon: Icon(Icons.perm_identity),
                            ),
                            TextFormField(
                              controller: studentIDController,
                              maxLength: 11,
                              decoration: InputDecoration(
                                  labelText: 'Student number',
                                  labelStyle: TextStyle(color: Colors.black)),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your Student Number';
                                }
                                if (value.length < 11) {
                                  return 'Student number must be at least 11 character.';
                                }
                                return null;
                              },
                            ),

                            //NAME    -------------------------------------------------------------------
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: TextStyle(color: Colors.black)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                if (value.length >= 15) {
                                  return 'Your name is too long.';
                                }
                                return null;
                              },
                            ),

                            //SURNAME   -------------------------------------------------------------------
                            TextFormField(
                              controller: surnameController,
                              decoration: InputDecoration(
                                  labelText: 'Surname',
                                  labelStyle: TextStyle(color: Colors.black)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your surname';
                                }
                                if (value.length >= 15) {
                                  return 'Your surname is too long';
                                }
                                return null;
                              },
                            ),

                            //MAIL     -------------------------------------------------------------------
                            TextFormField(
                              controller: mailController,
                              decoration: InputDecoration(
                                  labelText: 'Mail',
                                  labelStyle: TextStyle(color: Colors.black)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your mail address';
                                }
                                return null;
                              },
                            ),

                            //PASSWORD -------------------------------------------------------------------
                            TextFormField(
                              obscureText: true,
                              controller: password1Controller,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: Colors.black)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your password';
                                }

                                if (value.length >= 16) {
                                  return 'Your password length must be less than 16';
                                }

                                return null;
                              },
                            ),

                            //CONFIRM PASSWORD -------------------------------------------------------------
                            TextFormField(
                              obscureText: true,
                              controller: password2Controller,
                              decoration: InputDecoration(
                                labelText: "Confirm Password",
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please confirm your password";
                                }
                                if (value.length < 6) {
                                  return 'Your password is too week.';
                                }
                                if (value != password1Controller.text) {
                                  return "Insert same password, please!";
                                }

                                return null;
                              },
                            ),

                            //DROPDAOWN-FACULTY-------------------------------------------------------------
                            DropdownButton<String>(
                              value: facultyValue,
                              style: TextStyle(color: Colors.black),
                              onChanged: (String selected) {
                                setState(() {
                                  facultyValue = selected;
                                  department =
                                      tempFaculty.departments[facultyValue];
                                  departmentValue = department[0];
                                });
                              },
                              items: faculty.map((String currentFaculty) {
                                return DropdownMenuItem(
                                  child: Text(currentFaculty),
                                  value: currentFaculty,
                                );
                              }).toList(),
                            ),

                            //DROPDOWN -DEPARTMENT-------------------------------------------------------------
                            DropdownButton<String>(
                                value: departmentValue,
                                style: TextStyle(color: Colors.black),
                                onChanged: (String selected) {
                                  setState(() {
                                    departmentValue = selected;
                                  });
                                },
                                items:
                                    department.map((String currentDepartment) {
                                  return DropdownMenuItem(
                                    child: Text(currentDepartment),
                                    value: currentDepartment,
                                  );
                                }).toList()),

                            //REGISTER -BUTTON -------------------------------------------------------------
                            FlatButton(
                              color: Colors.black,
                              textColor: Colors.white,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              padding: EdgeInsets.all(8.0),
                              splashColor: Colors.blueAccent,
                              onPressed: () async {
                                //VALIDATOR
                                if (formKey.currentState.validate()) {
                                  //DATABASE PART

                                  _databaseHelper.register(
                                      int.parse(studentIDController.text),
                                      nameController.text,
                                      surnameController.text,
                                      mailController.text,
                                      password1Controller.text,
                                      facultyValue,
                                      departmentValue);

                                  Future(() {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                WelcomePage()));
                                  });
                                } else {
                                  setState(() {
                                    otoValidation = true;
                                  });
                                }
                              },
                              child: Text(
                                "REGISTER",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  //---------------fetch faculty json as faculty object---------
  Future<Faculty> fetchFacultyInfo() async {
    var jsonFile = await DefaultAssetBundle.of(context)
        .loadString("assets/faculty_deps.json");

    var temp = Faculty.fromJson(json.decode(jsonFile));

    return temp;
  }
}
