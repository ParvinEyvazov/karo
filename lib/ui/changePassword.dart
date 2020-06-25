import 'package:flutter/material.dart';
import 'package:karo_app/models/faculty.dart';
import 'package:karo_app/ui/homepage.dart';

import 'package:karo_app/utils/database_helper.dart';

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
  DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _password1 = TextEditingController();
    _password2 = TextEditingController();
    _databaseHelper = DatabaseHelper();
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
                      }
                      if (pass != _password1.text) {
                        return "Insert same password, please!";
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
                            //SEND QUERY

                            _databaseHelper.changeSettingPassword(
                                widget.user_id, _password1.text);

                            print("-PASSWORD-CHANGED-");

                            Future(() {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HomePage(
                                            user_id: widget.user_id,
                                            aimPage: 2,
                                          )),
                                  (route) => false);
                            });
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
