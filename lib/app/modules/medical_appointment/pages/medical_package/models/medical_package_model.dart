
class MedicalPackageModel {
  final int id;
  final String title;
  final bool insurance;
  final double? minPrice;
  final double? maxPrice;
  final double? price;
  final int type;
  const MedicalPackageModel({
    required this.id,
    required this.title,
    required this.insurance,
    this.minPrice,
    this.maxPrice,
    this.price,
    required this.type,
  });
}

class NavPackageModel {
  final bool consultation;
  final MedicalPackageModel data;
  const NavPackageModel({
    required this.consultation,
    required this.data
  });

}