import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';
import 'package:karo_app/community_side/components/build_community_list_tile.dart';
import 'package:karo_app/ui/singlePages/SingleJoinedCommunityPage.dart';

class AllJoinedComListPage extends StatefulWidget {
  int user_id;

  AllJoinedComListPage({@required this.user_id}) : assert(user_id != null);

  @override
  _AllJoinedComListPageState createState() => _AllJoinedComListPageState();
}

class _AllJoinedComListPageState extends State<AllJoinedComListPage> {
  @override
  Widget build(BuildContext context) {
    final _communityBloc = BlocProvider.of<CommunityBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Joined Communities"),
      ),
      body: BlocBuilder(
        bloc: _communityBloc,
        builder: (context, CommunityState state) {
          if (state is CommunityInitial) {
            _communityBloc
                .add(FetchAllJoinedCommunityEvent(user_id: widget.user_id));
            return Center(child: CircularProgressIndicator());
          }

          if (state is AllCommunityLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is AllCommunityLoadedState) {
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _communityBloc.add(
                      FetchAllJoinedCommunityEvent(user_id: widget.user_id));
                });
              },
              child: ListView.builder(
                  itemCount: state.community_list.length,
                  itemBuilder: (context, index) {
                    return cardCommunity(
                        comm_id: state.community_list[index].commId,
                        communityName: state.community_list[index].commName,
                        communityDesc: state.community_list[index].commDesc);
                  }),
            );
          }

          if (state is AllCommunityLoadErrorState) {
            return Center(child: Text("ERROR"));
          }
        },
      ),
    );
  }

  Container cardCommunity(
      {@required int comm_id,
      @required String communityName,
      @required String communityDesc}) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 10,
        shadowColor: Colors.blue[900],
        child: BuildCommunityListTile(
          onTap: () {
            Future(() {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MultiBlocProvider(
                          providers: [
                            //to show community info
                            BlocProvider(
                                create: (BuildContext context) =>
                                    CommunityBloc()),
                            //to show events
                            BlocProvider(
                              create: (BuildContext context) => EventBloc(),
                            ),
                          ],
                          child: SingleJoinedCommunityPage(
                              user_id: widget.user_id, comm_id: comm_id))));
            });
          },
          communityName: communityName,
          communityDescription: communityDesc,
        ),
      ),
    );
  }
}
