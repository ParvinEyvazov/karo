import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:karo_app/community_side/components/build_text_form_field.dart';
import 'package:karo_app/community_side/components/custom_box_decoration.dart';
import 'package:karo_app/community_side/components/custom_dropdown_menu.dart';
import 'package:karo_app/community_side/components/custom_submit_button.dart';
import 'package:karo_app/models/faculty.dart';
import 'package:karo_app/ui/welcomePages/login_page.dart';
import 'package:karo_app/utils/database_helper.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
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

              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [
                      Color(0xFF5CA0F2),
                      Color(0xFFC3DBF7),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: height * 1 / 14,
                    ),

                    //register text
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Sign up",
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Text("Welcome Back",
                          // style: TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                    ),

                    //SizedBox(height: height * 1 / 50),

                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            //topLeft: Radius.circular(10),
                            topRight: Radius.circular(100),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: height * 3 / 50),

                                //FORM
                                Form(
                                  autovalidate: otoValidation,
                                  key: formKey,
                                  child: Column(
                                    children: <Widget>[
                                      //student id
                                      BuildTextFormField(
                                        labelText: "",
                                        placeholder: "Student Number",
                                        isPassword: false,
                                        maxLength: null,
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

                                      //name
                                      BuildTextFormField(
                                        labelText: '',
                                        placeholder: "Name",
                                        isPassword: false,
                                        maxLength: null,
                                        inputType: TextInputType.number,
                                        focusNode: null,
                                        controller: nameController,
                                        validatorFunction: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter your name';
                                          }
                                          if (value.length >= 15) {
                                            return 'Your name is too long.';
                                          }
                                          return null;
                                        },
                                        prefixIcon: Icon(Icons.person_outline),
                                      ),

                                      //surname
                                      BuildTextFormField(
                                        labelText: '',
                                        placeholder: "Surname",
                                        isPassword: false,
                                        maxLength: null,
                                        inputType: TextInputType.number,
                                        focusNode: null,
                                        controller: surnameController,
                                        validatorFunction: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter your surname';
                                          }
                                          if (value.length >= 15) {
                                            return 'Your surname is too long';
                                          }
                                          return null;
                                        },
                                        prefixIcon: Icon(Icons.person_outline),
                                      ),

                                      //mail
                                      BuildTextFormField(
                                        labelText: '',
                                        placeholder: "Mail",
                                        isPassword: false,
                                        maxLength: null,
                                        inputType: TextInputType.number,
                                        focusNode: null,
                                        controller: mailController,
                                        validatorFunction: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter your mail address';
                                          }
                                          return null;
                                        },
                                        prefixIcon: Icon(Icons.mail_outline),
                                      ),

                                      //password
                                      BuildTextFormField(
                                        labelText: '',
                                        placeholder: "Password",
                                        isPassword: false,
                                        maxLength: null,
                                        inputType: TextInputType.number,
                                        focusNode: null,
                                        controller: password1Controller,
                                        validatorFunction: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter your password';
                                          }

                                          if (value.length >= 16) {
                                            return 'Your password length must be less than 16';
                                          }

                                          return null;
                                        },
                                        prefixIcon: Icon(Icons.lock_outline),
                                      ),

                                      //confirm password
                                      BuildTextFormField(
                                        labelText: '',
                                        placeholder: "Confirm password",
                                        isPassword: true,
                                        maxLength: null,
                                        inputType: TextInputType.number,
                                        focusNode: null,
                                        controller: password2Controller,
                                        validatorFunction: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter your password';
                                          }

                                          if (value.length >= 16) {
                                            return 'Your password length must be less than 16';
                                          }

                                          return null;
                                        },
                                        prefixIcon: Icon(Icons.lock_outline),
                                      ),

                                      //dropdown -faculty
                                      Flex(
                                        direction: Axis.horizontal,
                                        children: <Widget>[
                                          CustomDropdownMenu(
                                            list: faculty,
                                            onChanged: (String selected) {
                                              setState(() {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                facultyValue = selected;
                                                department = tempFaculty
                                                    .departments[facultyValue];
                                                departmentValue = department[0];
                                              });
                                            },
                                            value: facultyValue,
                                          ),
                                        ],
                                      ),

                                      //dropdown -department
                                      Flex(
                                        direction: Axis.horizontal,
                                        children: <Widget>[
                                          CustomDropdownMenu(
                                              value: departmentValue,
                                              onChanged: (String selected) {
                                                setState(() {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  departmentValue = selected;
                                                });
                                              },
                                              list: department)
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  //height: 40,
                                  height: height * 2 / 50,
                                ),

                                FlatButton(
                                  onPressed: () {
                                    Future(() {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  MultiBlocProvider(providers: [
                                                    BlocProvider(
                                                      create: (context) =>
                                                          LoginBloc(),
                                                    ),
                                                  ], child: LoginPage())));
                                    });
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Already have an account? ',
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Log in',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                                CustomSubmitButton(
                                  onPressedFunction: () {
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
                                                builder:
                                                    (BuildContext context) =>
                                                        MultiBlocProvider(
                                                            providers: [
                                                              BlocProvider(
                                                                create: (context) =>
                                                                    LoginBloc(),
                                                              ),
                                                            ],
                                                            child:
                                                                LoginPage())));
                                      });
                                    } else {
                                      setState(() {
                                        otoValidation = true;
                                      });
                                    }
                                  },
                                  buttonColor: Color(0xFF016DEC),
                                  buttonName: "Sign Up",
                                  buttonTextColor: Colors.white,
                                ),

                                //Register button
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            }
          }),
    );
  }

  Future<Faculty> fetchFacultyInfo() async {
    var jsonFile = await DefaultAssetBundle.of(context)
        .loadString("assets/faculty_deps.json");

    var temp = Faculty.fromJson(json.decode(jsonFile));

    return temp;
  }
}

/*
Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xFF5CA0F2),
              Color(0xFFC3DBF7),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: height * 1 / 14,
            ),

            //register text
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Sign up",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text("Welcome Back",
                  // style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),

            //SizedBox(height: height * 1 / 50),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    //topLeft: Radius.circular(10),
                    topRight: Radius.circular(100),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: height * 3 / 50),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFC3DBF7),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ],
                          ),
                          child: Form(
                            autovalidate: otoValidation,
                            key: formKey,
                            child: Column(
                              children: <Widget>[
                                //student id
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: studentIDController,
                                    decoration: InputDecoration(
                                      hintText: "Student Number",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
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
                                ),
                                //name
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      hintText: "Name",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
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
                                ),
                                //surname
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: surnameController,
                                    decoration: InputDecoration(
                                      hintText: "Surname",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
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
                                ),
                                //mail
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: mailController,
                                    decoration: InputDecoration(
                                      hintText: "Mail",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter your mail address';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                //password
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    obscureText: true,
                                    keyboardType: TextInputType.number,
                                    controller: password1Controller,
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
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
                                ),
                                //confirm password
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    obscureText: true,
                                    keyboardType: TextInputType.number,
                                    controller: password2Controller,
                                    decoration: InputDecoration(
                                      hintText: "Confirm password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
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
                                ),
                                //dropdown -faculty
                                //dropdown -department
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
 */
