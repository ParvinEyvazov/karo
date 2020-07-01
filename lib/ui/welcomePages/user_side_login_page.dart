import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:karo_app/ui/homepage.dart';
import 'package:karo_app/ui/welcomePages/user_side_register_page.dart';
import 'package:karo_app/utils/database_helper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controllerUserId;
  TextEditingController _controllerPassword;
  final formKey = GlobalKey<FormState>();
  bool otoValidation = false;
  DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _controllerUserId = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      body: BlocBuilder(
        bloc: _loginBloc,
        builder: (context, LoginState state) {
          //initial state
          if (state is LoginInitial) {
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
                    //height: 80,
                  ),

                  //--------------login-welcome
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Welcome Back",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 1 / 50),

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
                              //textfields
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
                                      //student number textfield
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey[200],
                                            ),
                                          ),
                                        ),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: _controllerUserId,
                                          decoration: InputDecoration(
                                            hintText: "Student Number",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'please enter your student number';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),

                                      //password textfield
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: _controllerPassword,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'please enter your password';
                                            }
                                            return null;
                                          },
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

                              //go to register
                              FlatButton(
                                onPressed: () {
                                  Future(() {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage()));
                                  });
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),

                              SizedBox(
                                height: height * 2 / 50,
                              ),

                              //button
                              GestureDetector(
                                onTap: () {
                                  //--first check validation , then call bloc
                                  if (formKey.currentState.validate()) {
                                    _loginBloc.add(LoginCheckEvent(
                                        user_id:
                                            int.parse(_controllerUserId.text),
                                        user_password:
                                            _controllerPassword.text));
                                  } else {
                                    setState(() {
                                      otoValidation = true;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color(0xFF016DEC),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 2.5 / 50),

                              //admin login
                              FlatButton(
                                onPressed: () {
                                  print("com log");
                                },
                                child: Text(
                                  "Community Login",
                                  style: TextStyle(color: Colors.blueGrey),
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
            );
          }

          if (state is LoginNotSuccessState) {
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
                    //height: 80,
                    height: height * 1 / 14,
                  ),

                  //--------------login-welcome
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Wrong student number or password",
                            style: TextStyle(
                                color: Colors.redAccent[400], fontSize: 18)),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 1 / 50),

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            //topLeft: Radius.circular(10),
                            topRight: Radius.circular(100),
                          )),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 60),
                              //textfields
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
                                      //student number textfield
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey[200],
                                            ),
                                          ),
                                        ),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: _controllerUserId,
                                          decoration: InputDecoration(
                                            hintText: "Student Number",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'please enter your student number';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),

                                      //password textfield
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]),
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: _controllerPassword,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'please enter your password';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 40),

                              //go to register
                              FlatButton(
                                onPressed: () {},
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),

                              SizedBox(height: height * 2 / 50),

                              //button
                              GestureDetector(
                                onTap: () {
                                  //--first check validation , then call bloc
                                  if (formKey.currentState.validate()) {
                                    _loginBloc.add(LoginCheckEvent(
                                        user_id:
                                            int.parse(_controllerUserId.text),
                                        user_password:
                                            _controllerPassword.text));
                                  } else {
                                    setState(() {
                                      otoValidation = true;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color(0xFF016DEC),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 2.5 / 50),

                              //admin login
                              FlatButton(
                                onPressed: () {
                                  print("com log");
                                },
                                child: Text(
                                  "Community Login",
                                  style: TextStyle(color: Colors.blueGrey),
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
            );
          }

          if (state is LoginLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is LoginSuccessState) {
            print("-USER-LOGGED-IN-");
            Future(() {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          HomePage(user_id: int.parse(_controllerUserId.text))),
                  (Route<dynamic> route) => false);
            });

            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
