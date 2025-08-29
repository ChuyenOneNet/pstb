import 'dart:core';
extension ListConverter on List<dynamic> {
  List<T> mapList<T>(Function itemConverter) {
    var res = <T>[];
    forEach((element) {
      var converted = itemConverter(element);
      res.add(converted);
    });
    return res;
  }
}
