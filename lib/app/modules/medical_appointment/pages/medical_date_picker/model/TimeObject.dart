class TimeObject {
  TimeObject({
    required this.id,
    required this.date,
    this.booked,
  });

  int id;
  DateTime date;
  bool? booked;

  bool operator ==(o) => o is TimeObject && o.id == id;
  int get hashCode => id.hashCode;
}
