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

  //-----1--------------------------------------------------------------------------
  //Login icin user checkleme - id ve password alib bir liste donderiyor
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

  //-----2--------------------------------------------------------------------------
  //TIMELINE - QUERY -RETURN LIST , id alip -event listesi donderir
  Future<List<Event>> getAllJoinedCommunityEvents(int id) async {
    var db = await _getDatabase();

    //var mapListesi = await db.rawQuery("SELECT * FROM event");
    var mapListesi = await db.rawQuery(
        "SELECT event.*, community.comm_name AS community_name FROM event, event_comm INNER JOIN community ON event.event_id = event_comm.event_id AND community.comm_id = event_comm.comm_id AND event.event_id IN (SELECT event_id FROM event_comm WHERE comm_id IN (SELECT comm_id FROM user_comm WHERE user_id = ${id})) AND event.deleted = 0;");

    var list = List<Event>();

    for (Map map in mapListesi) {
      list.add(Event.fromMap(map));
    }

    return list;
  }

  //-----3-------------------------------------------------------------------------- !
  //EXPLORE-COMM -QUERY - RETURN LIST, id alip - community listesi donderur
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

  //-----4--------------------------------------------------------------------------
  //PROFILE-JOINED COMMUNITY - QUERY- RETURN LIST , id alip - community list dondurur
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

    /*
    var sonuc = await db.execute(
        "SELECT * FROM community WHERE comm_id IN (SELECT comm_id FROM user_comm WHERE user_comm.user_id =20185156006);");
    */
  }

  //-----5--------------------------------------------------------------------------
  //EXPLORE-EVENT - QUERY - RETURN LIST, id alip - event listesi dondurur
  Future<List<Event>> getAllNonJoinedCommunityEvents(int id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT event.*, community.comm_name AS community_name FROM event, event_comm INNER JOIN community ON event.event_id = event_comm.event_id AND community.comm_id = event_comm.comm_id AND event.event_id IN (SELECT event_id FROM event_comm WHERE comm_id IN (SELECT comm_id FROM community where comm_id NOT IN (SELECT comm_id FROM user_comm WHERE user_id = ${id}))) AND event.deleted = 0 ;");

    var list = List<Event>();

    for (Map map in mapListesi) {
      list.add(Event.fromMap(map));
    }

    return list;

    /*
      var sonuc = await db.execute(
        "SELECT * FROM event WHERE event_id IN (SELECT event_id FROM event_comm WHERE comm_id IN (SELECT comm_id FROM user_comm WHERE user_id != $id));");
   */
  }

  //-----6--------------------------------------------------------------------------
  //TIMELINE-SINGLE EVENT - QUERY - RETURN EVENT, event_id alip - o eventi dondurur
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

  //-----7--------------------------------------------------------------------------
  //EXPLORE-Eventde-SINGLE EVENT - QUERY - RETURN EVENT, event_id alip - o eventi dondurur
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

  //-----8--------------------------------------------------------------------------
  //EXPLORE-COMM-SINGLE COMMUNITY - QUERY - RETURN COMMUNITY, comm_id alip - o comm-u dondurur
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

  //-----9--------------------------------------------------------------------------
  //Get user INFORMATION FOR PROFILE PAGE
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

  //-----10--------------------------------------------------------------------------
  Future<int> getUserJoinedCommunityNumber(int user_id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT COUNT(user_id) AS countOfCommunities FROM user_comm WHERE user_id=${user_id};");

    int number_of_comm = mapListesi[0]["countOfCommunities"];

    return number_of_comm;
    //return 10;
  }

  //-----11--------------------------------------------------------------------------
  Future<int> getUserJoinedEventNumber(int user_id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT COUNT(user_id) AS countOfEvents FROM user_event WHERE user_id= ${user_id} AND status = 'join';");

    int number_of_events = mapListesi[0]["countOfEvents"];

    return number_of_events;
  }

  //-----12--------------------------------------------------------------------------
  //joined events through profile
  Future<List<Event>> getAllJoinedEvents(int user_id) async {
    var db = await _getDatabase();

    //var mapListesi = await db.rawQuery("SELECT * FROM event");

    var mapListesi = await db.rawQuery(
        "SELECT event.*, community.comm_name as community_name FROM event,event_comm INNER JOIN community ON  event.event_id = event_comm.event_id AND community.comm_id = event_comm.comm_id AND event.event_id IN (SELECT event_id FROM user_event WHERE user_id = ${user_id} and status = 'join') AND deleted = 0;");

    var list = List<Event>();

    for (Map map in mapListesi) {
      list.add(Event.fromMap(map));
    }

    return list;
  }

  //-----13--------------------------------------------------------------------------
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

  //-----14--------------------------------------------------------------------------
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

  //COMMUNITY-NIN DUZENLEDIGI EVENTLERIN TUM BILGILERINI CEKER
  //-----15--------------------------------------------------------------------------
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

  //-----16--------------------------------------------------------------------------
  Future<List<int>> getEventJoinedUsers(int community_id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT event_title, COUNT(user_event.user_id) AS attendence FROM event, event_comm, user_event WHERE event.event_id = event_comm.event_id AND event.event_id = user_event.event_id AND event_comm.comm_id = $community_id AND user_event.status = 'join' group by event_title;");

    var list = List<int>();

    for (Map map in mapListesi) {
      list.add(map["attendence"]);
    }

    return list;
  }

  //SELECT * from event where event_id IN (SELECT event_id from event_comm where comm_id = 6) AND event_datetime > CURRENT_DATE gelecekteki eventler
  //SELECT * from event where event_id IN (SELECT event_id from event_comm where comm_id = 6) AND event_datetime < CURRENT_DATE geçmişteki eventler
  //SELECT * from event where event_id IN (SELECT event_id from event_comm where comm_id = 6) AND event_datetime = CURRENT_DATE bugün

//WRITE TO DATABASE

  //-----17--------------------------------------------------------------------------
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

  //-----18--------------------------------------------------------------------------
  //REGISTER
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

  //-----20--------------------------------------------------------------------------
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

    //print("tabloya eklendi : ${tempQuery}");
  }

  //-----21--------------------------------------------------------------------------
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

  //-------------------------------------------------------------------------------
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

  //   SOXUSSSS
  Future<void> getProfile(String id) async {
    var db = await _getDatabase();

    var sonuc = await db.execute(
        "SELECT u.user_name, u.user_surname, u.profilePic, (SELECT count(*) FROM user_event WHERE user_event.user_id =20185156006) AS eventCount,(SELECT count(*) FROM user_comm  WHERE user_comm.user_id = 20185156006) AS commCount FROM users AS u WHERE u.user_id = 20185156006; ");

    return sonuc;
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

  //writing comment to an event
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

  //join to event
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

  //delete join state to event
  Future<int> userEventStatusDelete(int user_id, int event_id) async {
    var db = await _getDatabase();

    try {
      var temp = await db.rawQuery(
          "DELETE FROM user_event WHERE user_id = ${user_id} AND event_id = ${event_id}");

      return 1;
    } catch (exception) {
      return 0;
    }

    //delete from user_event where user_id = 20185156006 and event_id= 2
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
}
