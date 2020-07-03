import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';
import 'package:karo_app/community_side/bloc/community_events_bloc/bloc/community_events_bloc.dart';
import 'package:karo_app/community_side/components/build_event_list_tile.dart';
import 'package:karo_app/community_side/components/custom_box_decoration.dart';
import 'package:karo_app/community_side/ui/community_single_event_page.dart';
import 'package:karo_app/utils/database_helper.dart';

class CommunityEventsListPage extends StatefulWidget {
  int community_id;

  CommunityEventsListPage({@required this.community_id});
  @override
  _CommunityEventsListPageState createState() =>
      _CommunityEventsListPageState();
}

class _CommunityEventsListPageState extends State<CommunityEventsListPage> {
  DatabaseHelper _databaseHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    final _communityEventsBloc = BlocProvider.of<EventBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Events"),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder(
        bloc: _communityEventsBloc,
        builder: (context, EventState state) {
          if (state is EventInitial) {
            _communityEventsBloc.add(
                FetchAllCommunityEvents(community_id: widget.community_id));

            return Center(child: CircularProgressIndicator());
          }

          if (state is AllEventsLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is AllEventsLoadedState) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.event_list.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      setState(() {});
                    },
                    direction: DismissDirection.horizontal,
                    child: card(
                        state.event_list[index].eventID,
                        state.event_list[index].eventTitle,
                        _communityEventsBloc),
                  );
                });
          }
        },
      ),
    );
  }

  card(int event_id, String eventTitle, EventBloc bloc) {
    return GestureDetector(
      //
      //GO TO SINGLE EVENT PAGE
      //

      // onTap: () {
      //   Future(() {
      //     Navigator.of(context).push(MaterialPageRoute(
      //         builder: (context) => MultiBlocProvider(
      //                 providers: [
      //                   BlocProvider<EventBloc>(
      //                       create: (BuildContext context) => EventBloc())
      //                 ],
      //                 child: CommunitySingleEventPage(
      //                   event_id: event_id,
      //                 ))));
      //   });
      //   print(event_id);
      // },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: CustomBoxDecoration().create(Colors.white, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("${eventTitle}"),
            IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                print("Clicked");
                setState(() {
                  Future(() {
                    showDeleteConfirmationDialog(
                      event_id,
                      bloc,
                    );
                  });
                  // bloc.add(FetchCommunityMembersEvent(
                  //     community_id: widget.community_id));
                  // deleteMember(user_id, community_id);
                });
              },
            )
          ],
        ),
      ),
    );
  }

  showDeleteConfirmationDialog(int event_id, EventBloc bloc) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert!'),
          content: const Text('Are you sure?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                setState(() {
                  Future(() {
                    setState(() {
                      bloc.add(FetchAllCommunityEvents(
                          community_id: widget.community_id));
                      deleteMember(event_id);
                    });
                  });
                  Navigator.pop(context, () {
                    setState(() {});
                  });
                });
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context, () {
                    setState(() {});
                  });
                });
              },
            ),
          ],
        );
      },
    );
  }

  deleteMember(int event_id) {
    print("deleted");
    _databaseHelper.deleteEvent(event_id);
  }
}
