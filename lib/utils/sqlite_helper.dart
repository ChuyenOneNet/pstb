// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// class RequestDatabase {
//   static final RequestDatabase instance = RequestDatabase._internal();
//   static Database? _db;
//
//   RequestDatabase._internal();
//
//   Future<Database> get database async {
//     if (_db != null) return _db!;
//     _db = await _initDB();
//     return _db!;
//   }
//
//   Future<Database> _initDB() async {
//     Directory docsDir = await getApplicationDocumentsDirectory();
//     String path = join(docsDir.path, 'requests.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//         CREATE TABLE requests (
//           id INTEGER PRIMARY KEY AUTOINCREMENT,
//           userPhone TEXT NOT NULL,
//           requestId TEXT NOT NULL,
//           title TEXT,
//           createdAt TEXT,
//           pdfPath TEXT
//         )
//         ''');
//       },
//     );
//   }
//
//   Future<int> insertRequest({
//     required String userPhone,
//     required String requestId,
//     required String title,
//     required String createdAt,
//     required String pdfPath,
//   }) async {
//     final db = await database;
//     return await db.insert('requests', {
//       'userPhone': userPhone,
//       'requestId': requestId,
//       'title': title,
//       'createdAt': createdAt,
//       'pdfPath': pdfPath,
//     });
//   }
//
//   Future<List<Map<String, dynamic>>> getRequestsByUser(String userPhone) async {
//     final db = await database;
//     return await db.query(
//       'requests',
//       where: 'userPhone = ?',
//       whereArgs: [userPhone],
//       orderBy: 'createdAt DESC',
//     );
//   }
//
//   Future<String?> getPdfPath(String requestId) async {
//     final db = await database;
//     final result = await db.query(
//       'requests',
//       where: 'requestId = ?',
//       whereArgs: [requestId],
//     );
//     if (result.isNotEmpty) {
//       return result.first['pdfPath'] as String;
//     }
//     return null;
//   }
// }
