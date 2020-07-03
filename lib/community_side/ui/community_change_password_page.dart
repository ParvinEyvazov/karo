import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';
import 'package:karo_app/community_side/components/build_text_form_field.dart';
import 'package:karo_app/community_side/ui/community_homepage.dart';
import 'package:karo_app/community_side/ui/community_profile_page.dart';
import 'package:karo_app/models/faculty.dart';
import 'package:karo_app/ui/homepage.dart';

import 'package:karo_app/utils/database_helper.dart';

class CommunityChangePasswordPage extends StatefulWidget {
  int community_id;

  CommunityChangePasswordPage({@required this.community_id})
      : assert(community_id != null);

  @override
  _CommunityChangePasswordPageState createState() =>
      _CommunityChangePasswordPageState();
}

class _CommunityChangePasswordPageState
    extends State<CommunityChangePasswordPage> {
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
                BuildTextFormField(
                    labelText: "New Password",
                    placeholder: "New Password",
                    isPassword: true,
                    maxLength: null,
                    inputType: TextInputType.text,
                    focusNode: null,
                    controller: _password1,
                    validatorFunction: null,
                    prefixIcon: null),
                SizedBox(
                  height: 20,
                ),

                /////////////////////////////////////////////////////////////////////////////////////
                //password 2
                BuildTextFormField(
                    labelText: "Confirm New Password",
                    placeholder: "Confirm New Password",
                    isPassword: true,
                    maxLength: null,
                    inputType: TextInputType.text,
                    focusNode: null,
                    controller: _password2,
                    validatorFunction: (String pass) {
                      if (pass.length < 5) {
                        return "Password can be at least 6 character.";
                      }
                      if (pass != _password1.text) {
                        return "Insert same password, please!";
                      } else {
                        return null;
                      }
                    },
                    prefixIcon: null),

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

                            _databaseHelper.changeCommunityPassword(
                                widget.community_id, _password1.text);

                            print("-PASSWORD-CHANGED-");

                            Future(() {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          BlocProvider(
                                            create: (context) =>
                                                CommunityBloc(),
                                            child: CommunityHomepage(
                                              community_id: widget.community_id,
                                              aimPage: 2,
                                            ),
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
