import 'dart:io';
import 'package:amc/models/notification_model.dart';
import 'package:amc/Styles/Keys.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static DatabaseManager _databaseManger;
  static Database _database;

  DatabaseManager._createInstance();

  factory DatabaseManager() {
    _databaseManger ??= DatabaseManager._createInstance();
    return _databaseManger;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = directory.path + Keys.database;

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(Keys.notificationSchema);

  }

  Future<List<Map<String, dynamic>>> getMapList(String table) async {
    Database db = await database;
    return await db.query(table,
        orderBy: '${Keys.ID} DESC');
  }

  Future<int> insert(String table, dynamic model) async {
    Database db = await database;
    return await db.insert(table, model.toMap());
  }

  Future<int> clear(String table) async {
    Database db = await database;
    return await db.delete(table);
  }

  Future<int> getCount(String table) async {
    Database db = await database;

    List<Map<String, dynamic>> list = await db.rawQuery('SELECT COUNT (*) FROM $table');
    return Sqflite.firstIntValue(list);
  }

  Future<List<NotificationModel>> getNotification() async {

    var noteMapList = await getMapList(Keys.notification);
    int count = noteMapList.length;

    List<NotificationModel> list = [];

    for (int i = 0; i < count; i++) {
      list.add(NotificationModel.fromMap(noteMapList[i]));
    }

    return list;
  }

}