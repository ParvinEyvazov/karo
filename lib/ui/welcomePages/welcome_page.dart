import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:karo_app/community_side/bloc/community_events_bloc/bloc/community_events_bloc.dart';
import 'package:karo_app/community_side/ui/community_homepage.dart';
import 'package:karo_app/ui/welcomePages/login_page.dart';
import 'package:karo_app/ui/welcomePages/register_page.dart';
import 'package:karo_app/utils/database_helper.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
                  child: Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.blueGrey.shade400),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                            create: (context) => LoginBloc(),
                            child: LoginPage1())));
                  },
                ),
                FlatButton(
                  color: Colors.black,
                  child: Text(
                    'COMMUNITY',
                    style: TextStyle(color: Colors.blueGrey.shade400),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                            create: (context) => CommunityEventsBloc(),
                            child: CommunityHomepage(
                              community_id: 8,
                            ))));
                  },
                ),
                FlatButton(
                  color: Colors.black,
                  child: Text(
                    'REGISTER',
                    style: TextStyle(color: Colors.blueGrey.shade400),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Register1Page()));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
