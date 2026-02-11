import 'package:pstb/app/models/business_detail_model.dart';
import 'date_utils.dart';

/// Grouping utilities for XetNghiem and Image data
class GroupingUtils {
  /// Group XetNghiem by date, sorted newest first
  static Map<String, List<XetNghiemInfo>> groupXetNghiemByDate(
    List<XetNghiemInfo>? items,
  ) {
    if (items == null || items.isEmpty) return {};
    final grouped = <String, List<XetNghiemInfo>>{};
    for (final item in items) {
      final dt = DateUtilsHelper.getDateModified(item.dateModified);
      final key = DateUtilsHelper.formatDate(dt);
      (grouped[key] ??= []).add(item);
    }
    final sorted = grouped.entries.toList()
      ..sort((a, b) => DateUtilsHelper.parseDate(b.key)
          .compareTo(DateUtilsHelper.parseDate(a.key)));
    return Map.fromEntries(sorted);
  }

  /// Group UrlData (Images) by date, sorted newest first
  static Map<String, List<UrlDataInfo>> groupImageByDate(
    List<UrlDataInfo>? items,
  ) {
    if (items == null || items.isEmpty) return {};
    final grouped = <String, List<UrlDataInfo>>{};
    for (final item in items) {
      final dt = DateUtilsHelper.getDateModified(item.dateModified);
      final key = DateUtilsHelper.formatDate(dt);
      (grouped[key] ??= []).add(item);
    }
    final sorted = grouped.entries.toList()
      ..sort((a, b) => DateUtilsHelper.parseDate(b.key)
          .compareTo(DateUtilsHelper.parseDate(a.key)));
    return Map.fromEntries(sorted);
  }

  /// Group XetNghiem by type within a date
  static Map<String, List<XetNghiemInfo>> groupXetNghiemByType(
    List<XetNghiemInfo> items,
  ) {
    final grouped = <String, List<XetNghiemInfo>>{};
    for (final item in items) {
      final type = item.tenLoaiXetNghiem ?? 'Không xác định';
      (grouped[type] ??= []).add(item);
    }
    return grouped;
  }
}
