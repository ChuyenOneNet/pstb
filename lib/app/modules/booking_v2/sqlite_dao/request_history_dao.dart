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
        cccd TEXT,
        age INTEGER,
        gender INTEGER,
        birthDate TEXT,
        jobName TEXT,
        job TEXT,
        addressDetail TEXT,
        phone TEXT,
        fatherName TEXT,
        motherName TEXT,
        idIssueDate TEXT,
        idIssuePlace TEXT,
        nationalId TEXT,
        ethnic TEXT,
        provinceId TEXT,
        communeWardId TEXT,
        nationalName TEXT,
        ethnicName TEXT,
        provinceName TEXT,
        communeWardName TEXT,
        examTypeId TEXT,
        examTypeName TEXT,
        clinicRoomCode TEXT,
        roomName TEXT,
        reason TEXT,
        priority TEXT,
        arrivalMethod TEXT,
        createdAt TEXT,
        pdfPath TEXT,
        hasInsurance INTEGER DEFAULT 0,
        price TEXT
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
