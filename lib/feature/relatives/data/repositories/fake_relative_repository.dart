import 'dart:async';

import '../../data/models/relative_model.dart';
import '../../domain/repositories/relative_repository.dart';

/// Repository in-memory chỉ dùng cho DEV / TEST UI.
/// Mọi thao tác thêm/sửa/xoá đều cập nhật trên list trong RAM.
class FakeRelativeRepository implements RelativeRepository {
  final List<RelativeModel> _items = [
    RelativeModel(
      id: 1,
      mainCccd: '037200009029',
      fullName: 'Đào Thị Thùy',
      dob: '1993-08-12',
      cccd: '034193000577',
      phone: '0901234567',
      patientCode: 'BN000123',
      addressDetail: 'Số 12, Ngõ 8, Đường A',
      city: 'TP. Ninh Bình',
      ward: 'Phường Trung Sơn',
      ethnicity: 'Kinh',
      occupation: 'Nhân viên văn phòng',
      country: 'Việt Nam',
      relationship: 'CON',
    ),
    RelativeModel(
      id: 2,
      mainCccd: '037200009029',
      fullName: 'Trịnh Văn Huy',
      dob: '1938-03-15',
      cccd: '001038007113',
      phone: '0912345678',
      patientCode: 'BN000456',
      addressDetail: 'Thôn Đông, Xã X',
      city: 'Ninh Bình',
      ward: 'Xã Y',
      ethnicity: 'Kinh',
      occupation: 'Hưu trí',
      country: 'Việt Nam',
      relationship: 'ONG_BA',
    ),
    RelativeModel(
      id: 3,
      mainCccd: '037200009029',
      fullName: 'Phạm Văn Lưu',
      dob: '1954-10-18',
      cccd: '031054003511',
      phone: '0987654321',
      patientCode: 'BN000789',
      addressDetail: 'Số 5, Đường B',
      city: 'Ninh Bình',
      ward: 'Phường Trung Sơn',
      ethnicity: 'Kinh',
      occupation: 'Kinh doanh',
      country: 'Việt Nam',
      relationship: 'CHA',
    ),
    RelativeModel(
      id: 4,
      mainCccd: '037200009029',
      fullName: 'Đào Thị Thùy',
      dob: '1993-08-12',
      cccd: '034193000577',
      phone: '0901234567',
      patientCode: 'BN000123',
      addressDetail: 'Số 12, Ngõ 8, Đường A',
      city: 'TP. Ninh Bình',
      ward: 'Phường Trung Sơn',
      ethnicity: 'Kinh',
      occupation: 'Nhân viên văn phòng',
      country: 'Việt Nam',
      relationship: 'CON',
    ),
    RelativeModel(
      id: 5,
      mainCccd: '037200009029',
      fullName: 'Trịnh Văn Huy',
      dob: '1938-03-15',
      cccd: '001038007113',
      phone: '0912345678',
      patientCode: 'BN000456',
      addressDetail: 'Thôn Đông, Xã X',
      city: 'Ninh Bình',
      ward: 'Xã Y',
      ethnicity: 'Kinh',
      occupation: 'Hưu trí',
      country: 'Việt Nam',
      relationship: 'ONG_BA',
    ),
    RelativeModel(
      id: 6,
      mainCccd: '037200009029',
      fullName: 'Phạm Văn Lưu',
      dob: '1954-10-18',
      cccd: '031054003511',
      phone: '0987654321',
      patientCode: 'BN000789',
      addressDetail: 'Số 5, Đường B',
      city: 'Ninh Bình',
      ward: 'Phường Trung Sơn',
      ethnicity: 'Kinh',
      occupation: 'Kinh doanh',
      country: 'Việt Nam',
      relationship: 'CHA',
    ),
  ];

  int _nextId = 4;

  Future<T> _delay<T>(T Function() body) async {
    await Future.delayed(const Duration(milliseconds: 500)); // giả lập loading
    return body();
  }

  @override
  Future<List<RelativeModel>> getRelatives(String mainCccd) {
    return _delay(() =>
        _items.where((e) => e.mainCccd == mainCccd).toList(growable: false));
  }

  @override
  Future<RelativeModel> getRelativeDetail(String mainCccd, int id) {
    return _delay(() {
      final item = _items.firstWhere(
        (e) => e.id == id && e.mainCccd == mainCccd,
        orElse: () => throw Exception('RELATIVE_NOT_FOUND'),
      );
      return item;
    });
  }

  @override
  Future<RelativeModel> addRelative(
      String mainCccd, RelativeModel model) async {
    return _delay(() {
      // rule: không cho cccd trùng mainCccd
      if (model.cccd == mainCccd) {
        throw Exception('SELF_AS_RELATIVE_NOT_ALLOWED');
      }
      // rule: (mainCccd, cccd) unique
      final exists = _items.any(
        (e) => e.mainCccd == mainCccd && e.cccd == model.cccd,
      );
      if (exists) throw Exception('RELATIVE_ALREADY_EXISTS');

      final newModel = model.copyWith(
        id: _nextId++,
        mainCccd: mainCccd,
      );
      _items.add(newModel);
      return newModel;
    });
  }

  @override
  Future<RelativeModel> updateRelative(
      String mainCccd, int id, RelativeModel model) {
    return _delay(() {
      final index =
          _items.indexWhere((e) => e.id == id && e.mainCccd == mainCccd);
      if (index == -1) throw Exception('RELATIVE_NOT_FOUND');

      // không cho đổi CCCD trong fake repo cho giống rule backend
      final old = _items[index];
      if (model.cccd != old.cccd) {
        throw Exception('CHANGE_CCCD_NOT_ALLOWED');
      }

      final updated = model.copyWith(id: id, mainCccd: mainCccd);
      _items[index] = updated;
      return updated;
    });
  }

  @override
  Future<void> deleteRelative(String mainCccd, int id) {
    return _delay(() {
      _items.removeWhere((e) => e.id == id && e.mainCccd == mainCccd);
      return;
    });
  }
}
