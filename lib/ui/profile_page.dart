import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade400,
      body: Column(
        children: <Widget>[
          Container(
            //color: Colors.red,
            padding: EdgeInsets.only(top: 35, right: 10),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                  },
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: CircleAvatar(
              radius: 110,
              backgroundImage: NetworkImage(
                  'https://pngimage.net/wp-content/uploads/2018/06/profile-avatar-png-5.png'),
            ),
          ),
          SizedBox(height: 20),
          Text('Parvin Eyvazov', style: TextStyle(fontSize: 25)),
          SizedBox(height: 20),
          Text('20160807002', style: TextStyle(fontSize: 15)),
          Container(
            padding: EdgeInsets.only(top: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      '12',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    Container(
                       padding: EdgeInsets.only(top: 10),
                        width: 90,
                        child: Text(
                          'Joined Communities',
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
                Column(
                  
                  children: <Widget>[
                    Text(
                      '6',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                        width: 80,
                        child: Text(
                          'Joined Events',
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
