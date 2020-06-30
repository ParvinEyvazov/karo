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

  //COMMUNITY-NIN DUZENLEDIGI EVENTLERIN TUM BILGILERINI CEKER
  //-------------------------------------14-------------------------------------
  Future<List<Event>> getCommunityEvents(int community_id) async {
    var db = await _getDatabase();

    var mapListesi = await db.rawQuery(
        "SELECT * from event where event.event_id IN (SELECT event_id FROM event_comm where comm_id = $community_id) AND event.deleted = 0");

    var list = List<Event>();

    for (Map map in mapListesi) {
      list.add(Event.fromMap(map));
    }

    return list;
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

  //SELECT * from event where event_id IN (SELECT event_id from event_comm where comm_id = 6) AND event_datetime > CURRENT_DATE gelecekteki eventler
  //SELECT * from event where event_id IN (SELECT event_id from event_comm where comm_id = 6) AND event_datetime < CURRENT_DATE geçmişteki eventler
  //SELECT * from event where event_id IN (SELECT event_id from event_comm where comm_id = 6) AND event_datetime = CURRENT_DATE bugün

//WRITE TO DATABASE
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

  updateCommunityInfo(
    String community_name,
    String community_desc,
    String community_supervisor,
    String contact_info,
    String office_address,
    String community_manager,
    String community_phone,
    int community_id,
  ) async {
    var db = await _getDatabase();
    var query = await db.rawQuery(
        "UPDATE community SET comm_name = '$community_name', comm_desc = '$community_desc', supervisor= '$community_supervisor', contactInfo='$contact_info', office_address='$office_address', comm_manager = '$community_manager',phone = '$community_phone' WHERE comm_id = $community_id");
  }

  //-------------------REGISTER
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

  /*
    static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'my_table';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnAge = 'age';

    _insert() async {

    // get a reference to the database
    // because this is an expensive operation we use async and await
    Database db = await DatabaseHelper.instance.database;

    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : 'Bob',
      DatabaseHelper.columnAge  : 23
    };

    // do the insert and get the id of the inserted row
    int id = await db.insert(DatabaseHelper.table, row);

    // show the results: print all rows in the db
    print(await db.query(DatabaseHelper.table));
  }
  
  
   */

  //   SOXUSSSS
  Future<void> getProfile(String id) async {
    var db = await _getDatabase();

    var sonuc = await db.execute(
        "SELECT u.user_name, u.user_surname, u.profilePic, (SELECT count(*) FROM user_event WHERE user_event.user_id =20185156006) AS eventCount,(SELECT count(*) FROM user_comm  WHERE user_comm.user_id = 20185156006) AS commCount FROM users AS u WHERE u.user_id = 20185156006; ");

    return sonuc;
  }
}
