import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sslcquiz/model/score_data.dart';

import '../model/question_data.dart';
import 'app_data.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  static const int DATABASE_VERSION = 3;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, 'question.db');

    bool isFreshInstall = await AppData().isFreshInstall();

    int currentVersion = await AppData().getDbVersion();

    print("📊 Fresh Install: $isFreshInstall");
    print("📊 Current DB Version: $currentVersion, Required: $DATABASE_VERSION");

    bool exists = await File(dbPath).exists();

    bool shouldReplaceDatabase = !exists || isFreshInstall || currentVersion != DATABASE_VERSION;

    if (shouldReplaceDatabase) {
      if (exists) {
        print("🗑️ Deleting old database (version $currentVersion)...");
        try {
          await File(dbPath).delete();
          print(" Old database deleted successfully");
        } catch (e) {
          print("️ Error deleting old database: $e");
        }
      }

      print("📥 Copying new database from assets (version $DATABASE_VERSION)...");

      try {
        ByteData data = await rootBundle.load('assets/question.db');
        List<int> bytes = data.buffer.asUint8List(
          data.offsetInBytes,
          data.lengthInBytes,
        );

        await File(dbPath).writeAsBytes(bytes, flush: true);

        await AppData().setDbVersion(DATABASE_VERSION);

        if (isFreshInstall) {
          print(" Database installed successfully on fresh install (version $DATABASE_VERSION)");
        } else {
          print(" Database updated successfully (version $DATABASE_VERSION)");
        }
      } catch (e) {
        print("❌ Error copying database from assets: $e");
        rethrow;
      }
    } else {
      print(" Database is up to date (version $currentVersion)");
    }

    // return await openDatabase(dbPath);
    Database db = await openDatabase(dbPath);
    await _ensureColumns(db);
    return db;
  }

  Future<void> forceRefreshDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, 'question.db');

    if (_database != null) {
      await _database!.close();
      _database = null;
    }

    if (await File(dbPath).exists()) {
      await File(dbPath).delete();
      print("🗑️ Old database deleted");
    }

    await AppData().setDbVersion(0);
    print("✅ Database forcefully refreshed");
  }

  Future<List<QuestionData>> getAllItems(String tableName, String query) async {
    print("tableName==${tableName}");
    print("query==${query}");
    final db = await database;
    List<Map<String, dynamic>> map = await db.query(
      tableName,
      where: 'lesson = ?',
      whereArgs: [query],
      // orderBy: 'RANDOM()',
    );
    bool isShuffle = (await AppData().getShuffle());

    List<QuestionData> mapList = map.map((json) {
      return QuestionData.fromJson(json,shuffle: isShuffle);
    }).toList();


    if(isShuffle){
      mapList.shuffle();
    }

    return mapList;
  }

  Future<int> insertScoreData(var map) async {
    print("map===${map}");

    final db = await database;
    int id = await db.insert(
      "score",
      map,
    );
    print("mapinsert===${id}==$map");

    return id;
  }


  Future<void> _ensureColumns(Database db) async {
    var favCols = await db.rawQuery('PRAGMA table_info(favourite)');
    for (var col in favCols) {}
    bool hasIdColumn = favCols.any((c) => c['name'] == 'id');
    
    if (!hasIdColumn) {
      print("Favourite table has no 'id' column - using ref_id for operations");
    }
    
    if (!favCols.any((c) => c['name'] == 'ref_id')) {
      await db.execute('ALTER TABLE favourite ADD COLUMN ref_id INTEGER DEFAULT 0');
    }

    // ── score table ──
    var scoreCols = await db.rawQuery('PRAGMA table_info(score)');
    if (!scoreCols.any((c) => c['name'] == 'total_question')) {
      await db.execute('ALTER TABLE score ADD COLUMN total_question INTEGER DEFAULT 0');
      print("✅ Added total_question to score");
    }
    if (!scoreCols.any((c) => c['name'] == 'ref_id')) {
      await db.execute('ALTER TABLE score ADD COLUMN ref_id TEXT');
      print("✅ Added ref_id to score");
    }
  }

  Future<List<QuestionData>> getHistory(String table,int id) async {
    final db = await database;
    List<Map<String, dynamic>> lis = await db.query(table,whereArgs: [id],where: "id=?");

    if (lis.isNotEmpty) {
      List<QuestionData> mapList = lis.map((json) {
        return QuestionData.fromJson(json);
      }).toList();

      if (mapList.isNotEmpty) {
        return mapList;
      }
    } else {
      return [];
    }
    return [];
  }


  Future<ScoreData?> getScoreData(int id) async {
    print("map1212===${id}");

    final db = await database;
    List<Map<String, dynamic>> lis = await db.query(
      "score",
      where: "id = ?",
      whereArgs: [id], // Update
      // this field
    );
    print("lis12===${lis}");

    if (lis.isNotEmpty) {
      List<ScoreData> mapList = lis.map((json) {
        return ScoreData.fromJson(json);
      }).toList();

      if (mapList.isNotEmpty) {
        print("lis===${lis}");

        return mapList.first;
      }
    } else {
      return null;
    }
    return null;
  }
  Future<List<QuestionData>> getAllFavouriteData() async {
    final db = await database;
    List<Map<String, dynamic>> lis = await db.query("favourite");
    print("mapList==${lis.length}");

    if (lis.isNotEmpty) {
      List<QuestionData> mapList = lis.map((json) {
        return QuestionData.fromJson(json);
      }).toList();

      if (mapList.isNotEmpty) {
        return mapList;
      }
    } else {
      return [];
    }
    return [];
  }
  
  Future<List<QuestionData>> getFavouritesByFilter({
    String? medium,
    String? tableName,
    String? lesson,
  }) async {
    final db = await database;
    
    List<String> whereConditions = [];
    List<dynamic> whereArgs = [];
    
    if (medium != null) {
      whereConditions.add('medium = ?');
      whereArgs.add(medium);
    }
    if (tableName != null) {
      whereConditions.add('tb_name = ?');
      whereArgs.add(tableName);
    }
    if (lesson != null) {
      whereConditions.add('lesson = ?');
      whereArgs.add(lesson);
    }
    
    String? whereClause = whereConditions.isNotEmpty 
        ? whereConditions.join(' AND ') 
        : null;
    
    List<Map<String, dynamic>> lis = await db.query(
      "favourite",
      where: whereClause,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );
    
    if (lis.isNotEmpty) {
      return lis.map((json) => QuestionData.fromJson(json)).toList();
    }
    return [];
  }

  Future<List<ScoreData>> getScoreHistory() async {
    final db = await database;
    List<Map<String, dynamic>> lis = await db.query("score");

    if (lis.isNotEmpty) {
      List<ScoreData> mapList = lis.map((json) {
        return ScoreData.fromJson(json);
      }).toList();

      if (mapList.isNotEmpty) {
        return mapList;
      }
    } else {
      return [];
    }
    return [];
  }

  Future<void> updateFavourite(
    String tableName,
    int id,
    String favourite,
  ) async {
    final db = await database;
    await db.update(
      tableName,
      {'favourite': favourite}, // Update this field
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  Future<void> insertFavourite(
      var map,
      ) async {
    final db = await database;
  int i =   await db.insert(
      "favourite",
      map, // Update this field
    );
  print("i===$i");
  }

  Future<void> insertHistory(
      var map,
      ) async {
    final db = await database;
    await db.insert(
      "history",
      map, // Update this field
    );
  }


  Future<void> deleteFavourite(
      int id,
      String medium,
      String subject,
      String lesson,
      ) async {
    final db = await database;
    await db.delete(
      "favourite",

        where: 'ref_id = ? AND medium = ? AND lesson = ? AND tb_name = ?',
        whereArgs: [id,medium,lesson,subject], // Update this field
    );
  }
  Future<void> removeFavouriteById(
      int favouriteTableId,

      ) async {
    final db = await database;
    var favCols = await db.rawQuery('PRAGMA table_info(favourite)');
    bool hasIdColumn = favCols.any((c) => c['name'] == 'id');
    
    if (hasIdColumn && favouriteTableId > 0) {
      await db.delete(
        "favourite",
        where: 'id = ? ',
        whereArgs: [favouriteTableId],
      );
    } else {
      print(" Cannot delete favourite by id=$favouriteTableId (table has no id column or invalid id)");
    }
  }
  
  Future<void> removeFavouriteByRefId(
      int refId,
      String medium,
      String tableName,
      String lesson,
      ) async {
    final db = await database;
    await db.delete(
      "favourite",
      where: 'ref_id = ? AND medium = ? AND tb_name = ? AND lesson = ?',
      whereArgs: [refId, medium, tableName, lesson],
    );
  }
  Future<void> deleteQuiz() async {
    final db = await database;

    await db.delete("score");
  }

  // You can add insert/update/delete if  needed...
}
