import 'package:sqflite/sqflite.dart';
import '../model/request_history.dart';

class RequestHistoryDao {
  final Database db;

  RequestHistoryDao(this.db);

  static const tableName = 'request_history';

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userPhone TEXT NOT NULL,
        requestId TEXT NOT NULL,
        patientName TEXT,
        examTypeName TEXT,
        roomName TEXT,
        createdAt TEXT,
        pdfPath TEXT
      )
    ''');
  }

  Future<void> insertHistory(RequestHistory history) async {
    await db.insert(
      tableName,
      history.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<RequestHistory>> getHistoryByUser(String userPhone) async {
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'userPhone = ?',
      whereArgs: [userPhone],
      orderBy: 'createdAt DESC',
    );
    return maps.map((m) => RequestHistory.fromMap(m)).toList();
  }

  Future<String?> getPdfPath(String requestId) async {
    final result = await db.query(
      tableName,
      where: 'requestId = ?',
      whereArgs: [requestId],
      limit: 1,
    );
    if (result.isNotEmpty) {
      return result.first['pdfPath'] as String?;
    }
    return null;
  }
}
