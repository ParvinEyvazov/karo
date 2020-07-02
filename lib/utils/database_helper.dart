import 'package:karo_app/models/comment.dart';
import 'package:karo_app/models/community.dart';
import 'package:karo_app/models/event.dart';
import 'package:karo_app/models/user.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;

  static Database _database;

  //making singleton
  DatabaseHelper._internal();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }

  //getting database
  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  //make database first time
  Future<Database> _initializeDatabase() async {
    //var lock = Lock();
    Database _db;

    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "demo_asset_example.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "karo.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    // open the database
    _db = await openDatabase(path, readOnly: false);

    return _db;
  }

  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  //-----------------------------------QUERIES----------------------------------
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  //----------------------------------USER-SIDE---------------------------------
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  //------------------------------------READ------------------------------------
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  Future<List<User>> getUser(int user_id, String user_password) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        'SELECT * FROM users WHERE user_id = $user_id AND user_password = "$user_password"');

    var list = List<User>();

    for (Map map in mapListesi) {
      list.add(User.fromMap(map));
    }

    return list;
  }

  Future<List<Event>> getAllJoinedCommunityEvents(int id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT event.*, community.comm_name AS community_name FROM event, event_comm INNER JOIN community ON event.event_id = event_comm.event_id AND community.comm_id = event_comm.comm_id AND event.event_id IN (SELECT event_id FROM event_comm WHERE comm_id IN (SELECT comm_id FROM user_comm WHERE user_id = ${id})) AND event.deleted = 0;");

    var list = List<Event>();

    for (Map map in mapListesi) {
      list.add(Event.fromMap(map));
    }

    return list;
  }

  Future<List<Community>> getAllNonJoinedCommunity(int id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT * FROM community where comm_id NOT IN (SELECT comm_id FROM user_comm WHERE user_id = ${id});");

    var list = List<Community>();

    for (Map map in mapListesi) {
      list.add(Community.fromMap(map));
    }

    if (list.length == 0) {
      print("list is empty");
    }

    return list;
  }

  Future<List<Community>> getAllJoinedCommunity(int id) async {
    //this is is user_id
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT * FROM community WHERE comm_id IN (SELECT comm_id FROM user_comm WHERE user_id = ${id});");

    var list = List<Community>();

    for (Map map in mapListesi) {
      list.add(Community.fromMap(map));
    }

    return list;
  }

  Future<List<Event>> getAllNonJoinedCommunityEvents(int id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT event.*, community.comm_name AS community_name FROM event, event_comm INNER JOIN community ON event.event_id = event_comm.event_id AND community.comm_id = event_comm.comm_id AND event.event_id IN (SELECT event_id FROM event_comm WHERE comm_id IN (SELECT comm_id FROM community where comm_id NOT IN (SELECT comm_id FROM user_comm WHERE user_id = ${id}))) AND event.deleted = 0 ;");

    var list = List<Event>();

    for (Map map in mapListesi) {
      list.add(Event.fromMap(map));
    }

    return list;
  }

  Future<Event> getSingleJoinedCommunityEvent(int event_id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT event.*, community.comm_name AS community_name FROM event, event_comm INNER JOIN community ON event.event_id = event_comm.event_id AND community.comm_id = event_comm.comm_id AND event.event_id = ${event_id} AND event.deleted = 0;");

    var list = List<Event>();

    for (Map map in mapListesi) {
      list.add(Event.fromMap(map));
    }

    return list[0];
  }

  Future<Event> getSingleNonJoinedCommunityEvent(int event_id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT event.*, community.comm_name AS community_name FROM event, event_comm INNER JOIN community ON event.event_id = event_comm.event_id AND community.comm_id = event_comm.comm_id AND event.event_id = ${event_id} AND event.deleted = 0;");

    var list = List<Event>();

    for (Map map in mapListesi) {
      list.add(Event.fromMap(map));
    }

    return list[0];
  }

  Future<Community> getSingleNonJoinedCommunity(int comm_id) async {
    var db = await _getDatabase();

    var mapListesi =
        await db.rawQuery("SELECT * FROM community WHERE comm_id = ${comm_id}");

    var list = List<Community>();

    for (Map map in mapListesi) {
      list.add(Community.fromMap(map));
    }

    return list[0];
  }

  Future<User> getUserInfo(int user_id) async {
    var db = await _getDatabase();

    var mapListesi =
        await db.rawQuery("SELECT * FROM users WHERE user_id = ${user_id}");

    var list = List<User>();

    for (Map map in mapListesi) {
      list.add(User.fromMap(map));
    }

    return list[0];
  }

  Future<int> getUserJoinedCommunityNumber(int user_id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT COUNT(user_id) AS countOfCommunities FROM user_comm WHERE user_id=${user_id};");

    int number_of_comm = mapListesi[0]["countOfCommunities"];

    return number_of_comm;
  }

  Future<int> getUserJoinedEventNumber(int user_id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT COUNT(user_id) AS countOfEvents FROM user_event WHERE user_id= ${user_id} AND status = 'join';");

    int number_of_events = mapListesi[0]["countOfEvents"];

    return number_of_events;
  }

  Future<List<Event>> getAllJoinedEvents(int user_id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT event.*, community.comm_name as community_name FROM event,event_comm INNER JOIN community ON  event.event_id = event_comm.event_id AND community.comm_id = event_comm.comm_id AND event.event_id IN (SELECT event_id FROM user_event WHERE user_id = ${user_id} and status = 'join') AND deleted = 0;");

    var list = List<Event>();

    for (Map map in mapListesi) {
      list.add(Event.fromMap(map));
    }

    return list;
  }

  Future<Community> getSingleJoinedCommunity(int comm_id) async {
    var db = await _getDatabase();

    var mapListesi =
        await db.rawQuery("SELECT * FROM community WHERE comm_id = ${comm_id}");

    var list = List<Community>();

    for (Map map in mapListesi) {
      list.add(Community.fromMap(map));
    }

    return list[0];
  }

  Future<Event> getSingleJoinedEvent(int event_id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT event.*, community.comm_name AS community_name FROM event, event_comm INNER JOIN community ON event.event_id = event_comm.event_id AND community.comm_id = event_comm.comm_id AND event.event_id = ${event_id} AND event.deleted = 0;");

    var list = List<Event>();

    for (Map map in mapListesi) {
      list.add(Event.fromMap(map));
    }

    return list[0];
  }

  Future<Map> getEventJoinedUsers(int community_id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT e.event_id, COUNT(user_event.event_id) AS attendence FROM (SELECT * FROM event WHERE event_id IN (SELECT event_id FROM event_comm WHERE comm_id = $community_id)) e LEFT JOIN user_event ON e.event_id=user_event.event_id AND user_event.event_id AND status = 'join' group by event_title;");

    var list = List<int>();
    var m = new Map();

    for (Map map in mapListesi) {
      m[map['event_id']] = map['attendence'];
    }
    print(m);

    return m;
  }
  //-------------GET EVENT COMMENTS

  Future<List<Comment>> getEventComment(int event_id) async {
    var db = await _getDatabase();

    var list = List<Comment>();
    var mapListesi =
        await db.rawQuery("SELECT * FROM comment WHERE event_id = $event_id;");
    // var mapListesi = await db.rawQuery(
    //     "SELECT comment.text,comment.date_time, users.user_name, users.user_surname FROM comment, users WHERE  comment.user_id = users.user_id AND comment.event_id = $event_id;");
    for (Map map in mapListesi) {
      list.add(Comment.fromMap(map));
    }
    return list;
  }

  //--------------GET COMMUNITY CHOSEN EVENT
  Future<Event> getSingleCommunityEvent(int event_id) async {
    var db = await _getDatabase();

    var list = List<Event>();

    var mapListesi =
        await db.rawQuery("SELECT * FROM event WHERE event_id = $event_id;");

    for (Map map in mapListesi) {
      list.add(Event.fromMap(map));
    }

    return list[0];
  }

  Future<int> getNumberOfMembersOfCommunity(int community_id) async {
    var db = await _getDatabase();
    var list = await db.rawQuery(
        "SELECT COUNT(comm_id) AS countOfMembers FROM user_comm WHERE comm_id=$community_id;");
    int count = list[0]["countOfMembers"];

    return count;
  }

  Future<int> getNumberOfEventsOfCommunity(int community_id) async {
    var db = await _getDatabase();
    var list = await db.rawQuery(
        "SELECT COUNT(event_id) as numberOfEvents FROM event_comm WHERE comm_id = $community_id;");
    int count = list[0]["numberOfEvents"];

    return count;
  }

  //--------GET SINGLE COMMUNITY INFO
  Future<Community> getSingleCommunity(int community_id) async {
    var db = await _getDatabase();

    var list = List<Community>();
    var mapListesi = await db
        .rawQuery("SELECT * FROM community WHERE comm_id = $community_id;");

    for (Map map in mapListesi) {
      list.add(Community.fromMap(map));
    }

    return list[0];
  }

  //-----------GET COMMUNITY MEMBERS
  Future<List<User>> getCommunityMembers(int community_id) async {
    var db = await _getDatabase();

    var list = List<User>();
    var mapListesi = await db.rawQuery(
        "SELECT * FROM (SELECT * from users) WHERE user_id IN (SELECT user_id FROM user_comm WHERE comm_id = $community_id);");

    for (Map map in mapListesi) {
      list.add(User.fromMap(map));
    }

    return list;
  }
  //-----------DELETE USER FROM COMMUNITY

  deleteUserFromCommunity(int user_id, int community_id) async {
    var db = await _getDatabase();

    var query = await db.rawQuery(
        "DELETE FROM user_comm WHERE user_id = $user_id AND comm_id = $community_id");
  }

  updateCommunityInfo(
      String community_name,
      String community_desc,
      String community_supervisor,
      String contact_info,
      String office_address,
      String community_manager,
      String community_phone,
      String community_instagram,
      String community_twitter,
      int community_id) async {
    var db = await _getDatabase();
    var query = await db.rawQuery(
        "UPDATE community SET comm_name = '$community_name', comm_desc = '$community_desc', supervisor= '$community_supervisor', contactInfo='$contact_info', office_address='$office_address', comm_manager = '$community_manager',phone = '$community_phone', instagram='$community_instagram', twitter='$community_twitter' WHERE comm_id = $community_id");
  }

  //-----19--------------------------------------------------------------------------
  Future<String> getUserName(int user_id) async {
    var db = await _getDatabase();

    var query = await db.rawQuery(
        "SELECT users.user_name FROM users WHERE user_id= ${user_id};");

    var tempList = List<String>();

    for (Map map in query) {
      tempList.add(map["user_name"]);
    }

    return tempList[0];
  }

  //print("tabloya eklendi : ${tempQuery}");
  //----------------ADD EVENT
  Future<int> addEvent(
      int communityID,
      String eventTitle,
      String eventDescription,
      String dateTime,
      String eventLocation,
      int quota) async {
    var db = await _getDatabase();

    Map<String, dynamic> rowEvent = {
      'event_title': eventTitle,
      'event_desc': eventDescription,
      'event_datetime': dateTime,
      'event_location': eventLocation,
      'quota': quota,
    };
    int eventID = await db.insert('event', rowEvent);

    Map<String, dynamic> rowEventComm = {
      'comm_id': communityID,
      'event_id': eventID,
    };

    await db.insert('event_comm', rowEventComm);

    return eventID;
  }

  //---------------UPDATE EVENT
  updateEvent(
    int event_id,
    String event_title,
    String event_description,
    String event_datetime,
    String event_location,
    int quota,
  ) async {
    var db = await _getDatabase();

    var query = await db.rawQuery(
      "UPDATE event SET event_title = '$event_title', event_desc = '$event_description', event_datetime = '$event_datetime', event_location = '$event_location', quota = $quota WHERE event_id = $event_id;",
    );
  }

  deleteEvent(int event_id) async {
    var db = await _getDatabase();

    var query = await db.rawQuery(
      "UPDATE event SET deleted =1 WHERE event_id =$event_id;",
    );
  }

  //-----22--------------------------------------------------------------------------
  Future<int> checkUserCommunityJoinState(int user_id, int community_id) async {
    var db = await _getDatabase();

    var tempQuery = await db.rawQuery(
        "SELECT * FROM user_comm WHERE user_comm.user_id = ${user_id} AND user_comm.comm_id = ${community_id}");

    if (tempQuery.length == 0) {
      return 0;
    } else {
      return 1;
    }
  }

  Future<String> getCommunityNameWithID(int comm_id) async {
    var db = await _getDatabase();

    var tempQuery = await db.rawQuery(
        "SELECT community.comm_name FROM community WHERE community.comm_id = ${comm_id}");

    var list = List<String>();

    for (Map map in tempQuery) {
      list.add(map["comm_name"]);
    }

    return list[0];
  }

  Future<List<Event>> getCommunityEventsForUserSide(int community_id) async {
    var db = await _getDatabase();

    var mapList = await db.rawQuery(
        "SELECT * from event where event.event_id IN (SELECT event_id FROM event_comm where comm_id = $community_id)");

    var list = List<Event>();

    for (Map map in mapList) {
      list.add(Event.fromMap(map));
    }

    return list;
  }

  Future<int> getCommunityIdWithEventID(int event_id) async {
    var db = await _getDatabase();

    var map = await db.rawQuery(
        "select comm_id from event_comm where event_id = ${event_id}");

    var list = List<int>();

    for (Map map in map) {
      list.add(map["comm_id"]);
    }

    return list[0];
  }

  Future<List<Comment>> getCommentWithEventIDForUserSide(int event_id) async {
    var db = await _getDatabase();

    var map = await db.rawQuery(
        "SELECT comment.*, users.user_name, users.user_surname FROM comment, users WHERE  comment.user_id = users.user_id AND comment.event_id = ${event_id} and comment.deleted = 0;");

    var list = List<Comment>();

    for (Map map in map) {
      list.add(Comment.fromMap(map));
    }

    return list;
  }

  Future<String> getEventNameWithEventID(int event_id) async {
    var db = await _getDatabase();

    var tempQuery = await db.rawQuery(
        "SELECT event.event_title FROM event WHERE event_id = ${event_id}");

    var list = List<String>();

    for (Map map in tempQuery) {
      list.add(map["event_title"]);
    }
    return list[0];
  }

  Future<String> checkUserEventStatus(int user_id, int event_id) async {
    var db = await _getDatabase();

    var tempQuery = await db.rawQuery(
        "select user_event.status from user_event where user_id = ${user_id} and event_id = ${event_id};");

    if (tempQuery.length == 0) {
      return "null";
    } else {
      return tempQuery[0]["status"];
    }
  }

  Future<int> userEventStatusJoin(
      int user_id, int event_id, String status) async {
    var db = await _getDatabase();

    Map<String, dynamic> row = {
      'user_id': user_id,
      'event_id': event_id,
      'status': status
    };
    //insert into user_event (user_id,event_id,status) VALUES(20185156008, 14, "maybe")

    try {
      int comedID = await db.insert('user_event', row);

      return 1;
    } catch (exceprion) {
      print("-ERROR-WHILE-ADDING-JOIN-STATUS-");
      return 0;
    }
  }

  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  //-----------------------------------WRITE------------------------------------
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------

  Future<int> register(int id, String name, String surname, String mail,
      String password, String faculty, String department) async {
    var db = await _getDatabase();

    Map<String, dynamic> row = {
      'user_id': id,
      'user_name': name,
      'user_surname': surname,
      'user_password': password,
      'user_mail': mail,
      'faculty': faculty,
      'department': department,
    };

    int comeId = await db.insert('users', row);

    print(comeId);

    return comeId;
  }

  Future<int> joinCommunity(int user_id, int community_id) async {
    var db = await _getDatabase();

    Map<String, dynamic> row = {'user_id': user_id, 'comm_id': community_id};

    //problem cikarsa 0donuyor, normalse 1
    try {
      int tempQuery = await db.insert('user_comm', row);
      return 1;
    } catch (exception) {
      return 0;
    }
  }

  userWriteCommentToEvent(int user_id, int event_id, String text) async {
    var db = await _getDatabase();

    Map<String, dynamic> row = {
      'user_id': user_id,
      'event_id': event_id,
      'text': text
    };

    int comeComment = await db.insert('comment', row);

    return comeComment;
  }

  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  //----------------------------------DELETE------------------------------------
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------

  Future<int> exitFromCommunity(int user_id, int community_id) async {
    var db = await _getDatabase();

    //problem cikarsa 0donuyor, normalse 1
    try {
      var temp = await db.rawDelete(
          'DELETE FROM user_comm WHERE user_comm.user_id = ${user_id} AND user_comm.comm_id = ${community_id}');

      return 1;
    } catch (exception) {
      return 0;
    }
  }

  Future<int> userEventStatusDelete(int user_id, int event_id) async {
    var db = await _getDatabase();

    try {
      var temp = await db.rawQuery(
          "DELETE FROM user_event WHERE user_id = ${user_id} AND event_id = ${event_id}");

      return 1;
    } catch (exception) {
      return 0;
    }
  }

  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  //----------------------------------UPDATE------------------------------------
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------

  changeSettingInfoMain(int user_id, String name, String surname, String email,
      String faculty, String department) async {
    var db = await _getDatabase();

    var query = await db.rawQuery(
        "UPDATE users SET user_name='$name',user_surname='$surname', user_mail='$email', faculty='$faculty', department='$department' WHERE user_id=$user_id;");
  }

  changeSettingPassword(int user_id, String password) async {
    var db = await _getDatabase();

    var query = await db.rawQuery(
        "UPDATE users SET user_password ='$password' WHERE user_id = $user_id;");
  }

  Future<int> userEventStatusUpdate(
      int user_id, int event_id, String status) async {
    var db = await _getDatabase();

    try {
      var temp = await db.rawQuery(
          "update user_event set status = '${status}' WHERE user_id = ${user_id} and event_id = ${event_id}");
      return 1;
    } catch (exception) {
      return 0;
    }
  }

  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  //-------------------------------COMMUNITY-SIDE-------------------------------
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  //------------------------------------READ------------------------------------
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------

  Future<List<Event>> getCommunityEvents(int community_id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT * FROM event WHERE event_id IN(SELECT event_id FROM event_comm WHERE comm_id = ${community_id}) AND deleted = 0;");

    var list = List<Event>();

    for (Map map in mapListesi) {
      list.add(Event.fromMap(map));
    }

    return list;
  }

  Future<List<Community>> getCommunity(
      int community_id, String community_password) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        'SELECT * FROM community WHERE comm_id = $community_id AND comm_password = "$community_password";');

    var list = List<Community>();

    for (Map map in mapListesi) {
      list.add(Community.fromMap(map));
    }

    return list;
  }

  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  //-----------------------------------WRITE------------------------------------
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  //----------------------------------DELETE------------------------------------
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  //----------------------------------UPDATE------------------------------------
  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------

}
