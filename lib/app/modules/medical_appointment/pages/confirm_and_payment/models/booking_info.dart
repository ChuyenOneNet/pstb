import 'package:pstb/app/models/covid_declaration_model.dart';

class BookingInfo {
  int? doctorId;
  final String packageName;
  final int packageId;
  String? doctorName;
  final DateTime? timeSeeDoctor;
  final String address;
  final CovidDeclaration? covidDeclaration;
  final DateTime? timeGetSample;
  final String idCost;
  final int cost;
  final int discount;

  BookingInfo(
      {this.doctorId,
      this.doctorName,
      required this.packageId,
      required this.packageName,
      required this.timeSeeDoctor,
      required this.address,
      required this.timeGetSample,
      required this.idCost,
      required this.cost,
      required this.discount,
      this.covidDeclaration});
}
