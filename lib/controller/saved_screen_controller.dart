import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SavedScreenController with ChangeNotifier {
  static late Database database;
  List<Map> savedArticles = [];

  
  static Future<void> initializeDatabase() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }
   
    database = await openDatabase(
      "saved.db",
      version: 4, 
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE Save (id INTEGER PRIMARY KEY, title TEXT, publishedAt TEXT, image TEXT, source TEXT, author TEXT, content TEXT, description TEXT, url TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE Save ADD COLUMN source TEXT');
        }
        if (oldVersion < 3) {
          await db.execute('ALTER TABLE Save ADD COLUMN author TEXT');
          await db.execute('ALTER TABLE Save ADD COLUMN content TEXT');
          await db.execute('ALTER TABLE Save ADD COLUMN description TEXT');
        }
        if (oldVersion < 4) {
          await db.execute('ALTER TABLE Save ADD COLUMN url TEXT');
        }
      },
    );
  }

 
  Future<bool> isArticleSaved(String title) async {
    await getSavedArticles();
    for (var article in savedArticles) {
      if (article['title'] == title) {
        return true;
      }
    }
    return false; 
  }

  
  Future<void> addNews({
    required String title,
    required String image,
    required String source,
    required String author,
    required String content,
    required String description,
    required String publishedAt,
    required String url, 
  }) async {
   
    
    bool alreadySaved = await isArticleSaved(title);

    if (alreadySaved) {
      log('News article is already saved');
    } else {
      await database.rawInsert(
        'INSERT INTO Save(title, image, source, author, content, description, publishedAt, url) VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
        [title, image, source, author, content, description, publishedAt, url],
      );
      await getSavedArticles(); 
      log('News saved successfully');
    }
    notifyListeners();
  }

  
  Future<void> getSavedArticles() async {
    savedArticles = await database.rawQuery('SELECT * FROM Save');
    log('Saved Articles: ${savedArticles.toString()}');
    notifyListeners();
  }

 
  Future<void> removeNews(int id) async {
    await database.rawDelete('DELETE FROM Save WHERE id = ?', [id]);
    await getSavedArticles();
    notifyListeners();
  }

 
  
}
