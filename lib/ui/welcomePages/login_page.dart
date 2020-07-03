import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:karo_app/community_side/components/build_text_form_field.dart';
import 'package:karo_app/community_side/ui/community_homepage.dart';
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

  TextEditingController _controllerCommunityId;
  TextEditingController _controllerCommunityPassword;

  final formKey = GlobalKey<FormState>();
  bool otoValidation = false;
  DatabaseHelper _databaseHelper;

  bool isLoginCheck;

  @override
  void initState() {
    super.initState();
    _controllerUserId = TextEditingController();
    _controllerPassword = TextEditingController();

    _controllerCommunityId = TextEditingController();
    _controllerCommunityPassword = TextEditingController();

    isLoginCheck = true;
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
            return main(
              _loginBloc,
              height,
              width,
              Text("Welcome Back!",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            );
          }

          if (state is LoginNotSuccessState) {
            return main(
              _loginBloc,
              height,
              width,
              Text("Wrong ID/Password",
                  style: TextStyle(color: Colors.redAccent, fontSize: 18)),
            );
          }

          if (state is LoginLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is LoginSuccessState) {
            print("-USER-LOGGED-IN-");
            isLoginCheck == true
                ? Future(() {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomePage(
                                user_id: int.parse(_controllerUserId.text))),
                        (Route<dynamic> route) => false);
                  })
                : Future(() {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CommunityHomepage(
                                    community_id: int.parse(
                                        _controllerCommunityId.text))),
                        (Route<dynamic> route) => false);
                  });

            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  main(LoginBloc _loginBloc, var height, var width, Text message) {
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
                isLoginCheck == true
                    ? Text(
                        "User Login",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )
                    : Text(
                        "Admin Login",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                SizedBox(
                  height: 10,
                ),
                message,
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
                          decoration: BoxDecoration(),
                          child: isLoginCheck == true
                              ? Form(
                                  autovalidate: otoValidation,
                                  key: formKey,
                                  child: Column(
                                    children: <Widget>[
                                      //student number textfield
                                      BuildTextFormField(
                                        labelText: "",
                                        controller: _controllerUserId,
                                        focusNode: null,
                                        inputType: TextInputType.text,
                                        isPassword: false,
                                        maxLength: null,
                                        placeholder: "Student Number",
                                        validatorFunction: (value) {
                                          if (value.isEmpty) {
                                            return "Empty";
                                          }
                                        },
                                        prefixIcon: Icon(Icons.perm_identity),
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),

                                      //password textfield
                                      BuildTextFormField(
                                        labelText: "",
                                        controller: _controllerPassword,
                                        focusNode: null,
                                        inputType: TextInputType.text,
                                        isPassword: true,
                                        maxLength: null,
                                        placeholder: "Password",
                                        validatorFunction: (value) {
                                          if (value.isEmpty) {
                                            return "Empty";
                                          }
                                        },
                                        prefixIcon: Icon(Icons.lock_outline),
                                      ),
                                    ],
                                  ),
                                )
                              : Form(
                                  autovalidate: otoValidation,
                                  key: formKey,
                                  child: Column(
                                    children: <Widget>[
                                      //student number textfield
                                      BuildTextFormField(
                                        labelText: "",
                                        controller: _controllerCommunityId,
                                        focusNode: null,
                                        inputType: TextInputType.text,
                                        isPassword: false,
                                        maxLength: null,
                                        placeholder: "Community ID",
                                        validatorFunction: (value) {
                                          if (value.isEmpty) {
                                            return "Empty";
                                          }
                                        },
                                        prefixIcon: Icon(Icons.perm_identity),
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),

                                      //password textfield
                                      BuildTextFormField(
                                        labelText: "",
                                        controller:
                                            _controllerCommunityPassword,
                                        focusNode: null,
                                        inputType: TextInputType.text,
                                        isPassword: true,
                                        maxLength: null,
                                        placeholder: "Password",
                                        validatorFunction: (value) {
                                          if (value.isEmpty) {
                                            return "Empty";
                                          }
                                        },
                                        prefixIcon: Icon(Icons.lock_outline),
                                      ),
                                    ],
                                  ),
                                )),

                      SizedBox(
                        //height: 40,
                        height: height * 2 / 50,
                      ),

                      //go to register
                      FlatButton(
                        onPressed: () {
                          Future(() {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegisterPage()));
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
                      isLoginCheck == true
                          ? GestureDetector(
                              onTap: () {
                                //--first check validation , then call bloc
                                if (formKey.currentState.validate()) {
                                  _loginBloc.add(LoginCheckEvent(
                                      user_id:
                                          int.parse(_controllerUserId.text),
                                      user_password: _controllerPassword.text));
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
                            )
                          : FlatButton(
                              onPressed: () {
                                setState(() {
                                  isLoginCheck = !isLoginCheck;
                                });
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ),

                      SizedBox(height: height * 2.5 / 50),

                      //admin login
                      isLoginCheck == false
                          ? GestureDetector(
                              onTap: () {
                                //--first check validation , then call bloc
                                if (formKey.currentState.validate()) {
                                  _loginBloc.add(CommunityLoginCheckEvent(
                                      community_id: int.parse(
                                          _controllerCommunityId.text),
                                      community_password:
                                          _controllerCommunityPassword.text));
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
                                    "Community Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : FlatButton(
                              onPressed: () {
                                setState(() {
                                  isLoginCheck = !isLoginCheck;
                                });
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
}
