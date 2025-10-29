import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class HistoryDb {
  HistoryDb._();
  static final HistoryDb instance = HistoryDb._();
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'history.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, v) async {
        await db.execute('''
          CREATE TABLE booking_history(
            id TEXT PRIMARY KEY,
            user_phone TEXT NOT NULL,
            patient_name TEXT,
            phone TEXT,
            service_name TEXT,
            visit_date_iso TEXT,
            visit_time_iso TEXT,
            branch TEXT,
            status TEXT,
            created_at_iso TEXT
          );
        ''');
        await db.execute(
            'CREATE INDEX idx_booking_user_created ON booking_history(user_phone, created_at_iso DESC);');
      },
    );
    return _db!;
  }
}
