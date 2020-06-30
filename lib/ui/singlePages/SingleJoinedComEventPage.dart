import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/comment_bloc/bloc/comment_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';
import 'package:karo_app/utils/database_helper.dart';

class SingleJoinedComEventPage extends StatefulWidget {
  int event_id;
  int user_id;

  SingleJoinedComEventPage({@required this.event_id, @required this.user_id})
      : assert(event_id != null && user_id != null);

  @override
  _SingleJoinedComEventPageState createState() =>
      _SingleJoinedComEventPageState();
}

class _SingleJoinedComEventPageState extends State<SingleJoinedComEventPage> {
  DatabaseHelper _databaseHelper;

  TextEditingController userCommentController;
  String status;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    userCommentController = TextEditingController();
    status = "null";
  }

  @override
  Widget build(BuildContext context) {
    //initialize BLOC
    final _eventBloc = BlocProvider.of<EventBloc>(context);
    final _commentBloc = BlocProvider.of<CommentBloc>(context);

    //get the status between -> user and event
    Future(() {
      FutureBuilder(
          future: getUserEventStatus(widget.user_id, widget.event_id),
          builder: (context, myData) {
            if (myData.hasData) {
              status = myData.data;
            } else {
              //status = "null";
            }
          });
    });

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
            future: getEventName(widget.event_id),
            builder: (context, mydata) {
              if (mydata.hasData) {
                return Text(mydata.data);
              } else {
                return Text("Event");
              }
            }),
        backgroundColor: Color(0xffb321307),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _eventBloc
                .add(FetchSingleJoinedComEventEvent(event_id: widget.event_id));
          });
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: BlocBuilder(
            bloc: _eventBloc,
            builder: (context, EventState state) {
              ////////////////////////////////////////////////////////////////////////////-INITIAL
              if (state is EventInitial) {
                _eventBloc.add(
                    FetchSingleJoinedComEventEvent(event_id: widget.event_id));
                return Center(child: CircularProgressIndicator());
              }

              ////////////////////////////////////////////////////////////////////////////-LOADING
              if (state is SingleEventLoadingState) {
                return Center(child: CircularProgressIndicator());
              }

              ////////////////////////////////////////////////////////////////////////////-LOADED
              if (state is SingleEventLoadedState) {
                return Column(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        "assets/photos/event.jpg",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 35, left: 35, right: 35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            state.event.eventTitle,
                            style: TextStyle(fontSize: 30),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  state.event.community_name,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    IconButton(
                                      tooltip: "Join",
                                      icon: Icon(
                                        Icons.done,
                                        color: status == "join"
                                            ? Colors.green
                                            : Colors.black,
                                      ),
                                      onPressed: () {
                                        //3asama
                                        //1 - eger status kismi null ise-ilk defe qatilacaq
                                        if (status == "null") {
                                          //insert

                                          Future(() async {
                                            int confirm = await _databaseHelper
                                                .userEventStatusJoin(
                                                    widget.user_id,
                                                    widget.event_id,
                                                    "join");

                                            if (confirm == 1) {
                                              setState(() {
                                                print("1-null state");
                                                status = "join";
                                              });
                                            }
                                          });
                                        }
                                        //2 - eger status kismi join ise - yeni silmek ucun tiklayir
                                        if (status == "join") {
                                          Future(() async {
                                            int confirm = await _databaseHelper
                                                .userEventStatusDelete(
                                                    widget.user_id,
                                                    widget.event_id);

                                            if (confirm == 1) {
                                              setState(() {
                                                print("2-delete state");
                                                status = "null";
                                              });
                                            }
                                          });
                                        }
                                        //3 - eger status kismi basqa birsey ise - update etmek ucun tikliyir
                                        else {
                                          //update

                                          Future(() async {
                                            int confirm = await _databaseHelper
                                                .userEventStatusUpdate(
                                                    widget.user_id,
                                                    widget.event_id,
                                                    "join");

                                            if (confirm == 1) {
                                              setState(() {
                                                print("3-update state");
                                                status = "join";
                                              });
                                            }
                                          });
                                        }
                                      },
                                    ),

                                    //-----MAYBE JOIN PART
                                    IconButton(
                                      tooltip: "Maybe join",
                                      icon: Icon(
                                        Icons.nature_people,
                                        color: status == "maybe"
                                            ? Colors.yellowAccent[700]
                                            : Colors.black,
                                      ),
                                      onPressed: () {
                                        //-null state
                                        if (status == "null") {
                                          //insert

                                          Future(() async {
                                            int confirm = await _databaseHelper
                                                .userEventStatusJoin(
                                                    widget.user_id,
                                                    widget.event_id,
                                                    "maybe");

                                            if (confirm == 1) {
                                              setState(() {
                                                print("1-null state");
                                                status = "maybe";
                                              });
                                            }
                                          });
                                        }
                                        //delete state
                                        if (status == "maybe") {
                                          Future(() async {
                                            int confirm = await _databaseHelper
                                                .userEventStatusDelete(
                                                    widget.user_id,
                                                    widget.event_id);

                                            if (confirm == 1) {
                                              setState(() {
                                                print("2-delete state");
                                                status = "null";
                                              });
                                            }
                                          });
                                        } else {
                                          //update

                                          Future(() async {
                                            int confirm = await _databaseHelper
                                                .userEventStatusUpdate(
                                                    widget.user_id,
                                                    widget.event_id,
                                                    "maybe");

                                            if (confirm == 1) {
                                              setState(() {
                                                print("3-update state");
                                                status = "maybe";
                                              });
                                            }
                                          });
                                        }
                                      },
                                    ),

                                    //-----NOT JOIN PART
                                    IconButton(
                                        tooltip: "Don`t join",
                                        icon: Icon(
                                          Icons.clear,
                                          color: status == "not"
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                        onPressed: () {
                                          //--null state
                                          if (status == "null") {
                                            //insert

                                            Future(() async {
                                              int confirm =
                                                  await _databaseHelper
                                                      .userEventStatusJoin(
                                                          widget.user_id,
                                                          widget.event_id,
                                                          "not");

                                              if (confirm == 1) {
                                                setState(() {
                                                  print("1-null state");
                                                  status = "not";
                                                });
                                              }
                                            });
                                          }
                                          //--delete state
                                          if (status == "not") {
                                            Future(() async {
                                              int confirm =
                                                  await _databaseHelper
                                                      .userEventStatusDelete(
                                                          widget.user_id,
                                                          widget.event_id);

                                              if (confirm == 1) {
                                                setState(() {
                                                  print("2-delete state");
                                                  status = "null";
                                                });
                                              }
                                            });
                                          } else {
                                            //update

                                            Future(() async {
                                              int confirm =
                                                  await _databaseHelper
                                                      .userEventStatusUpdate(
                                                          widget.user_id,
                                                          widget.event_id,
                                                          "not");

                                              if (confirm == 1) {
                                                setState(() {
                                                  print("3-update state");
                                                  status = "not";
                                                });
                                              }
                                            });
                                          }
                                        }),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 25),
                          Text(
                            state.event.eventDesc,
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 25),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.date_range),
                                  Text(state.event.eventDateTime)
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.place),
                                  Text(state.event.eventLocation)
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Divider(
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1 / 3,
                      padding: EdgeInsets.only(top: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Comments",
                            style: TextStyle(
                                fontFamily: "Roboto-Bold", fontSize: 20),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),

                    //--------COMMENTS
                    BlocBuilder(
                        bloc: _commentBloc,
                        builder: (context, CommentState state) {
                          if (state is CommentInitial) {
                            _commentBloc.add(FetchAllEventCommentsEvent(
                                event_id: widget.event_id));
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          //loading state
                          if (state is AllCommentsLoadingState) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          //loaded state -main state
                          if (state is AllCommentsLoadedState) {
                            var list = state.comment_list;

                            if (list.length == 0) {
                              return SizedBox(
                                  height: 75,
                                  child:
                                      Text("There is not any comment, yet."));
                            } else {
                              return Container(
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      return commentCard(
                                          context,
                                          list[index].userId,
                                          list[index].userName,
                                          list[index].userSurname,
                                          list[index].eventId,
                                          list[index].dateTime,
                                          list[index].text,
                                          list[index].deleted);
                                    }),
                              );
                            }
                          }

                          if (state is AllCommentsLoadErrorState) {
                            return Center(
                              child: Text("Error while loading comments"),
                            );
                          }
                        }),

                    Padding(
                      padding: EdgeInsets.all(8),
                      child: TextFormField(
                        controller: userCommentController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            hintText: "Write a comment...",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  if (userCommentController.text == null ||
                                      userCommentController.text == "") {
                                    print("you didn`t write anything");
                                  } else {
                                    setState(() {
                                      FocusScope.of(context).unfocus();
                                      Future(() async {
                                        await _databaseHelper
                                            .userWriteCommentToEvent(
                                                widget.user_id,
                                                widget.event_id,
                                                userCommentController.text);

                                        _commentBloc.add(
                                            FetchAllEventCommentsEvent(
                                                event_id: widget.event_id));

                                        print(
                                            "user ${widget.user_id} event ${widget.event_id} -e ' ${userCommentController.text} ' - yazisini yazdi");

                                        userCommentController.text = "";
                                      });
                                    });
                                  }
                                })),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                    )
                  ],
                );
              }

              ////////////////////////////////////////////////////////////////////////////-ERROR
              if (state is SingleEventLoadErrorState) {
                return Center(
                  child: Text(
                    "HATA",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
              ////////////////////////////////////////////////////////////////////////////-END
            },
          ),
        ),
      ),
    );
  }

  Container commentCard(
    @required BuildContext context,
    @required int userId,
    @required String userName,
    @required String userSurname,
    @required int eventId,
    @required String dateTime,
    @required String text,
    @required int deleted,
  ) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 35),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${userName} ${userSurname}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(dateTime),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(text),
          ),
          Divider(
            color: Colors.black,
          )
        ],
      ),
    );
  }

  Future<String> getEventName(int event_id) async {
    String event_title;

    event_title = await _databaseHelper.getEventNameWithEventID(event_id);

    return event_title;
  }

  Future<String> getUserEventStatus(int user_id, int event_id) async {
    String status1;

    status1 = await _databaseHelper.checkUserEventStatus(user_id, event_id);

    status = status1;

    return status1;
  }
}
