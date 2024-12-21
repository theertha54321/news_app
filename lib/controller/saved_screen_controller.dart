import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SavedScreenController with ChangeNotifier {
  static late Database database;
  List<Map> mylist = [];

  static Future<void> initDb() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }
    // Open database and manage schema changes
    database = await openDatabase(
      "saved.db",
      version: 2,  // Increased version number for migration
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE Save (id INTEGER PRIMARY KEY, title TEXT, publishedAt TEXT, image TEXT, source TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // If we are upgrading from a previous version, add the 'source' column
          await db.execute(
            'ALTER TABLE Save ADD COLUMN source TEXT',
          );
        }
      },
    );
  }

  Future addNews({
    required String title,
    
    required String image,
    required String source,  // Include source in addNews
  }) async {
    await database.rawInsert(
      'INSERT INTO Save(title,  image, source) VALUES(?, ?, ?)',
      [title, image, source],
    );
    await getNews();
  }

  Future getNews() async {
    mylist = await database.rawQuery('SELECT * FROM Save');
    print(mylist);
    notifyListeners();
  }

  removeNews() {
    // Add logic for removing news from the database
  }
  Future<List<Map>> getSavedNews() async {
  // Fetch the list of saved news articles
  return await database.rawQuery('SELECT * FROM Save');
}

}
