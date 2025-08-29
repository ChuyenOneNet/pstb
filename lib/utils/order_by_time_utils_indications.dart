import 'package:pstb/app/models/examination_result_model.dart';

List<Map<String, List<Indications>>> getListOrderByTimeIndications(
    {List<Indications>? listOrders}) {
  if (listOrders == null) return [];
  final listGroupByTime = listOrders
      .fold(<String, List<Indications>>{}, (previousValue, element) {
        Map<String, List<Indications>> listDateTime =
            previousValue as Map<String, List<Indications>>;
        if (!listDateTime.containsKey(element.time)) {
          listDateTime[element.time ?? ''] = [];
        }
        listDateTime[element.time ?? '']?.add(element);
        return listDateTime;
      })
      .entries
      .map((e) => {e.key: e.value})
      .toList();
  return listGroupByTime;
}
