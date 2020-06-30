import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';
import 'package:karo_app/community_side/components/build_avatar_container.dart';
import 'package:karo_app/community_side/components/build_setting_button.dart';
import 'package:karo_app/community_side/components/build_top_circle.dart';
import 'package:karo_app/community_side/components/custom_box_decoration.dart';
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
              body: Stack(
                children: [
                  Column(
                    children: <Widget>[
                      //TOP PART
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
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  BuildSettingButton(
                    settingPage: CommunitySettingsPage(
                      community: community,
                    ),
                  )
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
            FutureBuilder(
              future: future,
              builder: (context, myData) {
                if (myData.hasData) {
                  return Text(myData.data.toString());
                } else {
                  return Text(' ');
                }
              },
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
