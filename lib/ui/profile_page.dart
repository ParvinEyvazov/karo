import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';
import 'package:karo_app/bloc/user_bloc/bloc/user_bloc.dart';
import 'package:karo_app/ui/listPages/AllJoinedComListPage.dart';
import 'package:karo_app/ui/listPages/AllJoinedEventListPage.dart';

class ProfilePage extends StatefulWidget {
  int user_id;

  ProfilePage({this.user_id});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    //User BLOC
    final _userBloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade400,
      body: BlocBuilder(
          bloc: _userBloc,
          builder: (context, UserState state) {
            //INITIAL STATE TO CALL EVENT
            if (state is UserInitial) {
              _userBloc.add(FetchUserInfoEvent(user_id: widget.user_id));
              return Center(child: CircularProgressIndicator());
            }

            //LOADING STATE
            if (state is UserInfoLoadingState) {
              return Center(child: CircularProgressIndicator());
            }

            //LOADED STATE
            if (state is UserInfoLoadedState) {
              return Column(
                children: <Widget>[
                  Container(
                    //color: Colors.red,
                    padding: EdgeInsets.only(top: 35, right: 10),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () {},
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
                  Text("${state.user.userName} ${state.user.userSurname}",
                      style: TextStyle(fontSize: 25)),
                  SizedBox(height: 20),
                  Text(state.user.userID.toString(),
                      style: TextStyle(fontSize: 15)),
                  Container(
                    padding: EdgeInsets.only(top: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        //JOINED COMMUNITY PART
                        GestureDetector(
                          onTap: () {
                            Future(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                              create: (BuildContext context) =>
                                                  CommunityBloc())
                                        ],
                                        child: AllJoinedComListPage(
                                            user_id: widget.user_id),
                                      )));
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.blueGrey,
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  state.joined_comm.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900),
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
                          ),
                        ),

                        //JOINED EVENT PART
                        GestureDetector(
                          onTap: () {
                            Future(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                              create: (BuildContext context) =>
                                                  EventBloc())
                                        ],
                                        child: AllJoinedEventListPage(
                                            user_id: widget.user_id),
                                      )));
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.blueGrey,
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  state.joined_event.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900),
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
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }

            //ERROR STATE
            if (state is UserInfoLoadErrorState) {
              return Center(child: Text("ERROR"));
            }
          }),
    );
  }
}

/*
Column(
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
        )
 */
