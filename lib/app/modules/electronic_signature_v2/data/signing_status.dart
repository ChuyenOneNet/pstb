class SigningStatus {
  static const int unsigned = 0;
  static const int signed = 1;
  // static const int revoked = 2;
}

int? mapStatusKeyToInt(String? key) {
  if (key == null) return null;
  switch (key) {
    case 'unsigned':
      return SigningStatus.unsigned;
    case 'signed':
      return SigningStatus.signed;
      ;
    default:
      return null;
  }
}

String mapIntToLabel(int? v) {
  switch (v) {
    case SigningStatus.unsigned:
      return 'Chưa ký';
    case SigningStatus.signed:
      return 'Đã ký';
    default:
      return '—';
  }
}
