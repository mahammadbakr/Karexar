import 'dart:convert';

Project projectFromJson(String str) {
  final jsonData = json.decode(str);
  return Project.fromMap(jsonData);
}

String projectToJson(Project data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Project {
  int id;
  String name;
  String location;
  String startDate;
  int cost;
  String detail;
  String image;
  String ownerName;
  int ownerNumber;
  String days;
  int isActive;

  Project(
      {this.id,
      this.name,
      this.location,
      this.startDate,
      this.cost,
      this.detail,
      this.image,
      this.ownerName,
      this.ownerNumber,
      this.days,
      this.isActive
      });

  factory Project.fromMap(Map<String, dynamic> json) => new Project(
      id: json["id"],
      name: json["name"],
      location: json["location"],
      startDate: json["startDate"],
      cost: json["passport"],
      detail: json["detail"],
      image: json["image"],
      ownerName: json["ownerName"],
      ownerNumber: json["ownerNumber"],
      days: json["days"],
      isActive: json["isActive"]
  );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "location": location,
        "startDate": startDate,
        "cost": cost,
        "detail": detail,
        "image": image,
        "ownerName": ownerName,
        "ownerNumber": ownerNumber,
        "days": days,
        "isActive": isActive
      };
}
