import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';
import 'package:karo_app/community_side/components/build_avatar_container.dart';
import 'package:karo_app/community_side/components/build_setting_button.dart';
import 'package:karo_app/community_side/components/build_top_circle.dart';
import 'package:karo_app/community_side/components/custom_box_decoration.dart';
import 'package:karo_app/community_side/ui/community_members_page.dart';
import 'package:karo_app/community_side/ui/community_settings_page.dart';
import 'package:karo_app/utils/database_helper.dart';

class CommunityProfilePage extends StatefulWidget {
  int community_id;

  CommunityProfilePage({@required this.community_id});
  @override
  _CommunityProfilePageState createState() => _CommunityProfilePageState();
}

class _CommunityProfilePageState extends State<CommunityProfilePage> {
  final blueColor = Color(0XFF5e92f3);

  DatabaseHelper _databaseHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    final _communityBloc = BlocProvider.of<CommunityBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder(
        bloc: _communityBloc,
        builder: (context, CommunityState state) {
          if (state is CommunityInitial) {
            _communityBloc.add(
                FetchSingleCommunityEvent(community_id: widget.community_id));

            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is SingleCommunityLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is SingleCommunityLoadedState) {
            var community = state.community;
            return Scaffold(
              body: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        decoration: CustomBoxDecoration().create(blueColor, 0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              BuildAvatarContainer(
                                icon: Icons.people_outline,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                community.commName,
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Card(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 90, vertical: 10),
                                elevation: 8,
                                child: Row(
                                  children: <Widget>[
                                    cardItem(
                                        Icons.person, getNumberOfMembers()),
                                    cardItem(Icons.flag, getNumberOfEvents()),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Image.asset(
                                        "assets/images/instagram.png"),
                                  ),
                                  Text(
                                    " /${community.instagram}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Image.asset(
                                        "assets/images/twitter.png"),
                                  ),
                                  Text(
                                    " /${community.twitter}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      BuildSettingButton(
                        settingPage: CommunitySettingsPage(
                          community: community,
                        ),
                      ),
                    ],
                  ),
                  //TOP PART
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          padding:
                              EdgeInsets.only(top: 20, left: 20, right: 20),
                          decoration:
                              CustomBoxDecoration().create(Colors.white, 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.info_outline,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  community.commDesc,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width,
                          //height: 300,
                          padding: EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 20),
                          decoration:
                              CustomBoxDecoration().create(Colors.white, 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.person_outline,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  community.commManager,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 20),
                          decoration:
                              CustomBoxDecoration().create(Colors.white, 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.contact_mail,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  community.contactInfo,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 20),
                          decoration:
                              CustomBoxDecoration().create(Colors.white, 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.person_outline,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  community.supervisor,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

////COMMUNITY NAME ALTINDAKI CARD
  Expanded cardItem(IconData icon, Future future) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: <Widget>[
            Container(
              child: Icon(icon),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Future(() {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CommunityMembersPage(
                                community_id: widget.community_id,
                              )),
                      (Route<dynamic> route) => false);
                });
              },
              child: FutureBuilder(
                future: future,
                builder: (context, myData) {
                  if (myData.hasData) {
                    return Text(myData.data.toString());
                  } else {
                    return Text(' ');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

//INFO FROM DATABASE
  Future<int> getNumberOfMembers() async {
    var count = await _databaseHelper
        .getNumberOfMembersOfCommunity(widget.community_id);
    return count;
  }

  Future<int> getNumberOfEvents() async {
    var count =
        await _databaseHelper.getNumberOfEventsOfCommunity(widget.community_id);
    return count;
  }
}
