import 'package:path/path.dart';
import 'dart:io';
import 'package:synchronized/synchronized.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{

  static DatabaseHelper _databaseHelper;

  static Database _database;


  //makeing singleton
  DatabaseHelper._internal();


  factory DatabaseHelper() {
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    }else{
      return _databaseHelper;
    }
  }

  //getting database
  Future<Database> _getDatabase() async{
    if(_database == null){
      _database = await _initializeDatabase();
      return _database;
    }else{
      return _database;
    }
  }

  //make database first time
  Future<Database> _initializeDatabase() async{
    var lock = Lock();
    Database _db;

    if(_db == null){
      await lock.synchronized(() async{
        if(_db==null){
          var databasesPath = await getDatabasesPath();
          var path = join(databasesPath, "appDB.db");
          
          var file = new File(path);

          //check if file exists
          if(!await file.exists()){

            ByteData data = await rootBundle.load(join("assets", "karo.db"));
            List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
            await new File(path).writeAsBytes(bytes);
          }

          //open the database
          _db = await openDatabase(path);
        }
      });
    }

    return _db;

  }

  

  


   

}