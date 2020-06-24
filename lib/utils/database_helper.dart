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

  //-------------------------------------1-------------------------------------
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

  //-------------------------------------2-------------------------------------
  //TIMELINE - QUERY -RETURN LIST , id alip -event listesi donderir
  Future<List<Event>> getAllJoinedCommunityEvents(int id) async {
    var db = await _getDatabase();

    //denemelik all event-leri cekmek
    var mapListesi = await db.rawQuery("SELECT * FROM event");

    var list = List<Event>();

    for (Map map in mapListesi) {
      list.add(Event.fromMap(map));
    }

    return list;
  }

  //-------------------------------------3-------------------------------------
  //EXPLORE-COMM -QUERY - RETURN LIST, id alip - community listesi donderur
  Future<List<Community>> getAllNonJoinedCommunity(int id) async {
    var db = await _getDatabase();

    //denemelik all communiyt-leri cekmek
    var mapListesi = await db.rawQuery("SELECT * FROM community");

    var list = List<Community>();

    for (Map map in mapListesi) {
      list.add(Community.fromMap(map));
    }

    return list;

    /*
    var sonuc = await db.execute(
        "SELECT * FROM community WHERE comm_id IN (SELECT comm_id FROM user_comm WHERE user_comm.user_id !=20185156006);");
     */
  }

  //-------------------------------------4-------------------------------------
  //PROFILE-JOINED COMMUNITY - QUERY- RETURN LIST , id alip - community list dondurur
  Future<List<Community>> getAllJoinedCommunity(int id) async {
    //this is is user_id
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery("SELECT * FROM community");

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

  //-------------------------------------5-------------------------------------
  //EXPLORE-EVENT - QUERY - RETURN LIST, id alip - event listesi dondurur
  Future<List<Event>> getAllNonJoinedCommunityEvents(int id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery("SELECT * FROM event");

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

  //-------------------------------------6-------------------------------------
  //TIMELINE-SINGLE EVENT - QUERY - RETURN EVENT, event_id alip - o eventi dondurur
  Future<Event> getSingleJoinedCommunityEvent(int event_id) async {
    var db = await _getDatabase();

    var mapListesi =
        await db.rawQuery("SELECT * FROM event WHERE event_id = $event_id");

    var list = List<Event>();

    for (Map map in mapListesi) {
      list.add(Event.fromMap(map));
    }

    //return the first value which is gonna be single event
    return list[0];
  }

  //-------------------------------------7-------------------------------------
  //EXPLORE-Eventde-SINGLE EVENT - QUERY - RETURN EVENT, event_id alip - o eventi dondurur
  Future<Event> getSingleNonJoinedCommunityEvent(int event_id) async {
    var db = await _getDatabase();

    var mapListesi =
        await db.rawQuery("SELECT * FROM event WHERE event_id = $event_id");

    var list = List<Event>();

    for (Map map in mapListesi) {
      list.add(Event.fromMap(map));
    }

    return list[0];
  }

  //-------------------------------------8-------------------------------------
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

  //-------------------------------------9-------------------------------------
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

  //-------------------------------------10-------------------------------------
  Future<int> getUserJoinedCommunityNumber(int user_id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT COUNT(user_id) AS countOfCommunities FROM user_comm WHERE user_id=${user_id};");

    int number_of_comm = mapListesi[0]["countOfCommunities"];

    return number_of_comm;
    //return 10;
  }

  //-------------------------------------11-------------------------------------
  Future<int> getUserJoinedEventNumber(int user_id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT COUNT(user_id) AS countOfEvents FROM user_event WHERE user_id=${user_id};");

    int number_of_events = mapListesi[0]["countOfEvents"];

    return number_of_events;
    //return 12;
  }

  //-------------------------------------12-------------------------------------
  //joined events through profile
  Future<List<Event>> getAllJoinedEvents(int user_id) async {
    var db = await _getDatabase();

    // query deyisecek
    var mapListesi = await db.rawQuery("SELECT * FROM event");

    var list = List<Event>();

    for (Map map in mapListesi) {
      list.add(Event.fromMap(map));
    }

    return list;
  }

  //-------------------------------------13-------------------------------------
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

  //-------------------------------------13-------------------------------------
  Future<Event> getSingleJoinedEvent(int event_id) async {
    var db = await _getDatabase();

    var mapListesi =
        await db.rawQuery("SELECT * FROM event WHERE event_id = $event_id");

    var list = List<Event>();

    for (Map map in mapListesi) {
      list.add(Event.fromMap(map));
    }

    return list[0];
  }

  //WRITE TO DATABASE
  changeSettingInfoMain(int user_id, String name, String surname, String email,
      String faculty, String department) async {
    var db = await _getDatabase();

    var query = await db.rawQuery(
        "UPDATE users SET user_name='$name',user_surname='$surname', user_mail='$email', faculty='$faculty', department='$department' WHERE user_id=$user_id;");
    
  }




  //   SOXUSSSS
  Future<void> getProfile(String id) async {
    var db = await _getDatabase();

    var sonuc = await db.execute(
        "SELECT u.user_name, u.user_surname, u.profilePic, (SELECT count(*) FROM user_event WHERE user_event.user_id =20185156006) AS eventCount,(SELECT count(*) FROM user_comm  WHERE user_comm.user_id = 20185156006) AS commCount FROM users AS u WHERE u.user_id = 20185156006; ");

    return sonuc;
  }
}
