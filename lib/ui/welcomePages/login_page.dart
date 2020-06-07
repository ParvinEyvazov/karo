import 'package:flutter/material.dart';
import 'package:karo_app/ui/homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _initialValues = {
    'studentId': '',
    'password': '',
  };

  final _passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade400,
      body: Column(
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
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelText: 'Student ID',
                      focusColor: Colors.black,
                      hoverColor: Colors.black,
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    initialValue: _initialValues['studentId'],
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your Student ID';
                      }

                      return null;
                    },
                  ),
                  TextFormField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      focusColor: Colors.black,
                      hoverColor: Colors.black,
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: _passwordNode,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          FlatButton(
            color: Colors.black,
            textColor: Colors.white,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text(
              "LOGIN",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}
