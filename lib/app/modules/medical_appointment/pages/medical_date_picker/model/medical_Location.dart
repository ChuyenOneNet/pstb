class MedicalLocationObject {
  const MedicalLocationObject({
    required this.id,
    required this.location,
  });

  final int id;
  final String location;

  bool operator ==(o) => o is MedicalLocationObject && o.id == id;
  int get hashCode => id.hashCode;
}
