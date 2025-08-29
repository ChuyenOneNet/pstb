import 'dart:convert';
import 'package:flutter/material.dart';

class Utils {

  static void printObject(Object? object) {
    if (object == null) return;
    Map jsonMapped = json.decode(json.encode(object));
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String prettyPrint = encoder.convert(jsonMapped);
    debugPrint(prettyPrint);
  }

  static List<Map<int, String>> splitMap(Map<int, String> originalMap, int chunkSize) {
    List<Map<int, String>> result = [];
    List<int> keys = originalMap.keys.toList();

    for (int i = 0; i < keys.length; i += chunkSize) {
      Map<int, String> subMap = {};
      for (int j = i; j < i + chunkSize && j < keys.length; j++) {
        subMap[keys[j]] = originalMap[keys[j]]!;
      }
      result.add(subMap);
    }

    return result;
  }
}
