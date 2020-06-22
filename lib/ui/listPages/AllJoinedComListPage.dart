import 'package:flutter/material.dart';

class AllJoinedComListPage extends StatefulWidget {
  int user_id;

  AllJoinedComListPage({@required this.user_id}) : assert(user_id != null);

  @override
  _AllJoinedComListPageState createState() => _AllJoinedComListPageState();
}

class _AllJoinedComListPageState extends State<AllJoinedComListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JOINED COMMUNITIES"),
      ),
      body: Center(
        child: Text("user id : ${widget.user_id}"),
      ),
    );
  }
}
