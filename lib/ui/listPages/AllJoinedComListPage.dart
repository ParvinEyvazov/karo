import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';

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
        title: Text("JOINED COMMUNITIES"),
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
            return ListView.builder(
                itemCount: state.community_list.length,
                itemBuilder: (context, index) {
                  return cardCommunity(
                      comm_id: state.community_list[index].commId,
                      community_name: state.community_list[index].commName,
                      community_desc: state.community_list[index].commDesc);
                });
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
      @required String community_name,
      @required String community_desc}) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: ListTile(
            onTap: () {
              print("$comm_id");
            },
            title: Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                community_name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Container(
              padding: EdgeInsets.only(top: 15, bottom: 20),
              child: Text(community_desc),
            ),
          ),
        ),
      ),
    );
  }

/*
  Container cardCommunity(
      {@required int comm_id,
      @required String communityName,
      @required String communityDesc}) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            onTap: () {
              Future(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                  create: (BuildContext context) =>
                                      CommunityBloc()),
                            ],
                            child: SingleNonJoinedCommunityPage(
                                comm_id: comm_id))));
              });
            },
            title: Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  communityName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            subtitle: Container(
              padding: EdgeInsets.only(top: 15.0, bottom: 20.0),
              child: Text(communityDesc),
            ),
          ),
        ),
      ),
    );
  }
 */

}
