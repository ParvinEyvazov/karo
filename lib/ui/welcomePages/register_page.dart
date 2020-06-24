import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameNode = FocusNode();
  final _surnameNode = FocusNode();
  final _passwordNode = FocusNode();
  final _mailNode = FocusNode();
  final _facultyNode = FocusNode();
  final _departmentNode = FocusNode();

  String facultyDropdownInitialValue = 'Engineering';
  List<String> faculties = ['Engineering', 'IIBF', 'Sport', 'Actor'];

  var _initialValues = {
    'studentId': '',
    'name': '',
    'surname': '',
    'password': '',
    'mail': '',
    'faculty': '',
    'department': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blueGrey.shade400,
      body: SingleChildScrollView(
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
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      //Student ID Input
                      decoration: InputDecoration(labelText: 'Student ID'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      initialValue: _initialValues['studentId'],
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_nameNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your Student ID';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      //Name Input
                      decoration: InputDecoration(labelText: 'Name'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      focusNode: _nameNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_surnameNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your name';
                        }
                        if (value.length >= 12) {
                          return 'Your name is too long';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      //Surname Input
                      decoration: InputDecoration(labelText: 'Surname'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      focusNode: _surnameNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_mailNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your surname';
                        }
                        if (value.length >= 12) {
                          return 'Your surname is too long';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      //Mail Input
                      decoration: InputDecoration(labelText: 'Mail'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: _mailNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your mail address';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      
                      //Password Input
                      decoration: InputDecoration(labelText: 'Password'),
                      textInputAction: TextInputAction.next,
                      focusNode: _passwordNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_facultyNode);
                      },
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
                    DropdownButton<String>(
                      //Faculty Dropdown Menu
                      value: facultyDropdownInitialValue,
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String newValue) {
                        this.facultyDropdownInitialValue = newValue;
                      },
                      items: faculties
                          .map<DropdownMenuItem<String>>((String facultyName) {
                        return DropdownMenuItem<String>(
                          value: facultyName,
                          child: Text(facultyName),
                        );
                      }).toList(),
                    ),
                    DropdownButton<String>(
                      //Faculty Dropdown Menu
                      value: facultyDropdownInitialValue,
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String newValue) {
                        facultyDropdownInitialValue = newValue;
                      },
                      items:
                          faculties.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    FlatButton(
                      color: Colors.black,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.blueAccent,
                      onPressed: () {},
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
      ),
    );
  }
}
