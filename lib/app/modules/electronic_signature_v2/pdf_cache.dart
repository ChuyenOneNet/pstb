import 'dart:collection';
import 'dart:typed_data';

class _PdfCacheEntry {
  final Uint8List bytes;
  final DateTime expiry;
  _PdfCacheEntry(this.bytes, this.expiry);
  bool get isExpired => DateTime.now().isAfter(expiry);
}

class PdfCache {
  PdfCache._();
  static final PdfCache I = PdfCache._();

  // FIFO đơn giản; đủ tốt cho cache RAM ngắn hạn
  final _store = LinkedHashMap<String, _PdfCacheEntry>();

  // Tối ưu tùy app:
  int maxEntries = 16;
  Duration ttl = const Duration(minutes: 10);

  Uint8List? getIfFresh(String key) {
    final e = _store[key];
    if (e == null) return null;
    if (e.isExpired) {
      _store.remove(key);
      return null;
    }
    return e.bytes;
    // NOTE: không move to tail -> FIFO, nếu cần LRU thì remove+reinsert key
  }

  void put(String key, Uint8List bytes) {
    if (_store.length >= maxEntries && _store.isNotEmpty) {
      _store.remove(_store.keys.first);
    }
    _store[key] = _PdfCacheEntry(bytes, DateTime.now().add(ttl));
  }

  void remove(String key) => _store.remove(key);
  void clear() => _store.clear();
}
