import 'package:sqflite/sqflite.dart';
import 'history_db.dart';
import 'history_entry_db.dart';
import '../../domain/entities/history_entry.dart';

class HistoryLocalSqliteDs {
  Future<void> add(String userPhone, HistoryEntry e) async {
    final db = await HistoryDb.instance.database;
    await db.insert(
      HistoryEntryDb.table,
      HistoryEntryDb.toRow(e, userPhone),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<HistoryEntry>> getAll(String userPhone) async {
    final db = await HistoryDb.instance.database;
    final rows = await db.query(
      HistoryEntryDb.table,
      where: 'user_phone = ?',
      whereArgs: [HistoryEntryDb.normalizePhone(userPhone)],
      orderBy: 'created_at_iso DESC',
    );
    return rows.map(HistoryEntryDb.fromRow).toList();
  }

  Future<void> clear(String userPhone) async {
    final db = await HistoryDb.instance.database;
    await db.delete(
      HistoryEntryDb.table,
      where: 'user_phone = ?',
      whereArgs: [HistoryEntryDb.normalizePhone(userPhone)],
    );
  }
}
