import 'package:flutter/material.dart';
import 'package:karo_app/ui/welcomePages/login_page.dart';
import 'package:karo_app/ui/welcomePages/register_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KARO'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'KARO',
            style: TextStyle(
              color: Colors.red,
              fontSize: 50,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                color: Theme.of(context).primaryColor,
                child: Text('LOGIN'),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
              FlatButton(
                color: Theme.of(context).primaryColor,
                child: Text('REGISTER'),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
