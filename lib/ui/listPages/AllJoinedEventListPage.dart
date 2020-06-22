import 'package:flutter/material.dart';

class AllJoinedEventListPage extends StatefulWidget {
  int user_id;

  AllJoinedEventListPage({@required this.user_id}) : assert(user_id != null);

  @override
  _AllJoinedEventListPageState createState() => _AllJoinedEventListPageState();
}

class _AllJoinedEventListPageState extends State<AllJoinedEventListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Joined Events"),
      ),
      body: Center(
        child: Text("user id : ${widget.user_id}"),
      ),
    );
  }
}
