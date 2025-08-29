import 'dart:core';

extension MapConverter on Map<String, dynamic> {
  List<T>? tryGetList<T>(String name, Function itemConverter) {
    var res = <T>[];
    if (this[name] != null) {
      this[name].forEach((v) {
        res.add(itemConverter(v));
      });
    }
    return res;
  }
}

