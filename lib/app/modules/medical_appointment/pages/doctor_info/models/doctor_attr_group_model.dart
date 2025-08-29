class DoctorAttributeGroupViewModel {
  String icon;
  String title;
  List<String?> descriptions = <String?>[];

  DoctorAttributeGroupViewModel(this.icon, this.title);

  DoctorAttributeGroupViewModel addDescription(String? description) {
    descriptions.add(description!);
    return this;
  }
}
