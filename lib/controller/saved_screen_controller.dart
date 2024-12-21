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
    // Open the database and manage schema changes
    database = await openDatabase(
      "saved.db",
      version: 4,  // Incremented version number to 4
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE Save (id INTEGER PRIMARY KEY, title TEXT, publishedAt TEXT, image TEXT, source TEXT, author TEXT, content TEXT, description TEXT, url TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'ALTER TABLE Save ADD COLUMN source TEXT',
          );
        }
        if (oldVersion < 3) {
          await db.execute(
            'ALTER TABLE Save ADD COLUMN author TEXT',
          );
          await db.execute(
            'ALTER TABLE Save ADD COLUMN content TEXT',
          );
          await db.execute(
            'ALTER TABLE Save ADD COLUMN description TEXT',
          );
        }
        if (oldVersion < 4) {
          // Add the new URL column in version 4
          await db.execute(
            'ALTER TABLE Save ADD COLUMN url TEXT',
          );
        }
      },
    );
  }

  // Method to add a new news item with the new fields (including URL)
  Future addNews({
    required String title,
    required String image,
    required String source,
    required String author,
    required String content,
    required String description,
    required String publishedAt,
    required String url,  // Add URL parameter
  }) async {
    await database.rawInsert(
      'INSERT INTO Save(title, image, source, author, content, description, publishedAt, url) VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
      [title, image, source, author, content, description, publishedAt, url], // Insert URL into database
    );
    await getNews();
  }

  // Method to get all saved news, including new fields
  Future getNews() async {
    mylist = await database.rawQuery('SELECT * FROM Save');
    print(mylist);
    notifyListeners();
  }

  // Method to remove news
  removeNews(int id) async {
    await database.rawDelete('DELETE FROM Save WHERE id = ?', [id]);
    await getNews();
  }

  // Fetch all saved news
  Future<List<Map>> getSavedNews() async {
    return await database.rawQuery('SELECT * FROM Save');
  }
}
