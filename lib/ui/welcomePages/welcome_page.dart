import 'package:flutter/material.dart';
import 'package:karo_app/ui/welcomePages/login_page.dart';
import 'package:karo_app/ui/welcomePages/register_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade400,
      body: SafeArea(
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
            Text(
              'Akdeniz University',
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Pacifico",
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  color: Colors.black,
                  child: Text('LOGIN',style: TextStyle(color: Colors.blueGrey.shade400),),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
                FlatButton(
                  color: Colors.black,
                  child: Text('REGISTER',style: TextStyle(color: Colors.blueGrey.shade400),),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterPage()));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
