class DetailHospitalModel {
  int? id;
  String? name;
  String? image;
  String? openedTime;
  String? closedTime;
  String? description;
  int? numberExamination;
  int? rating;
  bool status = false;
  bool isChoose = false;

  DetailHospitalModel(
      {this.id,
        this.name,
        this.image,
        this.openedTime,
        this.closedTime,
        this.description,
        this.numberExamination,
        this.rating});

  DetailHospitalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    openedTime = json['openedTime'];
    closedTime = json['closedTime'];
    description = json['description'];
    numberExamination = json['numberExamination'];
    rating = json['rating'];
  }
}