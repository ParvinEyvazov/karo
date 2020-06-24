import 'package:flutter/material.dart';
import 'package:karo_app/models/faculty.dart';
import 'dart:convert';

class ChangePasswordPage extends StatefulWidget {
  int user_id;

  ChangePasswordPage({@required this.user_id}) : assert(user_id != null);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _password1;
  TextEditingController _password2;
  final formKey = GlobalKey<FormState>();
  bool otoValidation = false;

  @override
  void initState() {
    super.initState();
    _password1 = TextEditingController();
    _password2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),

      //body
      body: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(8),
        child: Form(
            autovalidate: otoValidation,
            key: formKey,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20),
                /////////////////////////////////////////////////////////////////////////////////////
                //password 1
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    obscureText: true,
                    validator: (String pass) {
                      if (pass.length < 5) {
                        return "Password can be at least 6 character.";
                      } else {
                        return null;
                      }
                    },
                    controller: _password1,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
                      hintText: "New Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                /////////////////////////////////////////////////////////////////////////////////////
                //password 2
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    obscureText: true,
                    validator: (String pass) {
                      if (pass.length < 5) {
                        return "Password can be at least 6 character.";
                      } else {
                        return null;
                      }
                    },
                    controller: _password2,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
                      hintText: "Confirm New Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                /////////////////////////////////////////////////////////////////////////////////////
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: RaisedButton(
                        child: Text("Change Password"),
                        onPressed: () {
                          if (formKey.currentState.validate() &&
                              _password1.text == _password2.text) {
                            print("dogru Pass: ${_password2.text} or ${_password1.text}");
                          } else {
                            setState(() {
                              otoValidation = true;
                            });
                          }
                        }))
              ],
            )),
      ),
    );
  }
}
