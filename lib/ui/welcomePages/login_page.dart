import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:karo_app/ui/homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int user_id;
  String user_password;

  TextEditingController _controllerUserId;
  TextEditingController _controllerPassword;

  @override
  void initState() {
    super.initState();
    _controllerUserId = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  @override
  void dispose() {
    _controllerUserId.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade400,
      body: BlocBuilder(
          bloc: _loginBloc,
          builder: (context, LoginState state) {
            //return Center(child: CircularProgressIndicator());
            //FIRST STATE
            if (state is LoginInitial) {
              return Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Text(
                    'KARO',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Pacifico",
                      fontSize: 100,
                    ),
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          //STUDENT ID FORM
                          TextFormField(
                            controller: _controllerUserId,
                            maxLength: 11,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: 'Student ID',
                              focusColor: Colors.black,
                              hoverColor: Colors.black,
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your Student ID';
                              }

                              return null;
                            },
                          ),

                          //STUDENT PASSWORD FORM
                          TextFormField(
                            controller: _controllerPassword,
                            obscureText: true,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              focusColor: Colors.black,
                              hoverColor: Colors.black,
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),

                          //LOGIN BUTTON
                          FlatButton(
                            color: Colors.black,
                            textColor: Colors.white,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                              _loginBloc.add(LoginCheckEvent(
                                  user_id: int.parse(_controllerUserId.text),
                                  user_password: _controllerPassword.text));

                              print(
                                  "user id : ${int.parse(_controllerUserId.text)}  password : ${_controllerPassword.text}");
                              //------------------EVERYTHING WILL HAPPEN THERE----------------------
                            },
                            child: Text(
                              "LOGIN",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            if (state is LoginLoadingState) {
              print("loading");
              return Center(child: CircularProgressIndicator());
            }

            //SUCCESSFUL STATE - go to homepage
            if (state is LoginSuccessState) {
              
              Future(() {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        HomePage(user_id: int.parse(_controllerUserId.text))));
              });

              return Center(child: CircularProgressIndicator());
            }

            if (state is LoginNotSuccessState) {
              return Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Text(
                    'KARO',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Pacifico",
                      fontSize: 100,
                    ),
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          //STUDENT ID FORM
                          TextFormField(
                            controller: _controllerUserId,
                            maxLength: 11,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: 'Student ID',
                              focusColor: Colors.black,
                              hoverColor: Colors.black,
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your Student ID';
                              }

                              return null;
                            },
                          ),

                          //STUDENT PASSWORD FORM
                          TextFormField(
                            controller: _controllerPassword,
                            obscureText: true,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              focusColor: Colors.black,
                              hoverColor: Colors.black,
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),

                          //ERROR MESSAGE ABOUT WRONG PASSWORD OR WRONG ID
                          SizedBox(height: 15),
                          Text(
                            "WRONG STUDENT ID OR PASSWORD, PLEASE TRY AGAIN!",
                            style: TextStyle(color: Colors.red),
                          ),
                          SizedBox(height: 15),
                          //LOGIN BUTTON
                          FlatButton(
                            color: Colors.black,
                            textColor: Colors.white,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                              _loginBloc.add(LoginCheckEvent(
                                  user_id: int.parse(_controllerUserId.text),
                                  user_password: _controllerPassword.text));

                              print(
                                  "user id : ${int.parse(_controllerUserId.text)}  password : ${_controllerPassword.text}");
                              //------------------EVERYTHING WILL HAPPEN THERE----------------------
                            },
                            child: Text(
                              "LOGIN",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            if (state is LoginErrorState) {
              print("Some error happened");
              return Text("error");
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
