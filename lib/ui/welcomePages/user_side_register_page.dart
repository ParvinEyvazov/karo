import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:karo_app/models/faculty.dart';
import 'package:karo_app/ui/welcomePages/user_side_login_page.dart';
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
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
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
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
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
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
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
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
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
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
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
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
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
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey[200],
                                              ),
                                            ),
                                          ),
                                          child: DropdownButton<String>(
                                            value: facultyValue,
                                            style:
                                                TextStyle(color: Colors.grey),
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
                                            items: faculty
                                                .map((String currentFaculty) {
                                              return DropdownMenuItem(
                                                child: Text(
                                                  currentFaculty,
                                                ),
                                                value: currentFaculty,
                                              );
                                            }).toList(),
                                          ),
                                        ),

                                        //dropdown -department
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey[200],
                                              ),
                                            ),
                                          ),
                                          child: DropdownButton<String>(
                                            value: departmentValue,
                                            style:
                                                TextStyle(color: Colors.grey),
                                            onChanged: (String selected) {
                                              setState(() {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                departmentValue = selected;
                                              });
                                            },
                                            items: department.map(
                                                (String currentDepartment) {
                                              return DropdownMenuItem(
                                                child: Text(currentDepartment),
                                                value: currentDepartment,
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
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
                                  child: Text(
                                    "already have an account? Log in",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
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
                                  child: Container(
                                    height: 50,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 50),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color(0xFF016DEC),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
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
