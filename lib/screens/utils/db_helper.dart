import 'dart:io';

import 'package:api_with_database/screens/download/model/download_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static final DBHelper db = DBHelper._();

  DBHelper._();

  Database? database;

  Future checkDB() async {
    if (database != null) {
      return database;
    } else {
      return await initDB();
    }
  }

  Future<Future<Database>> initDB() async {
    print("Method called ================================");
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "news_app.db");

    return openDatabase(path, onCreate: (db, version) {
      String query =
          "CREATE TABLE news_app (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT ,author TEXT, title TEXT,description TEXT,image TEXT, content TEXT)";

      db.execute(query);
    }, version: 1);
  }

  Future<void> insertDB({required DownNewsModel d1}) async {
    database = await checkDB();
    database!.insert("news_app", {
      "name": d1.name,
      "title": d1.title,
      "description": d1.description,
      "author": d1.author,
      "image": d1.image,
      "content": d1.content
    });
  }

  Future<List<DownNewsModel>> readDB()
  async {
    database = await checkDB();

    String Query = "SELECT * FROM news_app";
    List<Map> data = await database!.rawQuery(Query);

    List<DownNewsModel> downloadData = data.map((e) => DownNewsModel().fromJson(e)).toList();
    return downloadData;
  }

  Future<void> deleteDB({required int id})
  async {
    database = await checkDB();
    database!.delete("news_app",whereArgs: [id],where: "id = ?");
  }
}
