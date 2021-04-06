import 'dart:convert';

Thing thingFromJson(String str) {
  final jsonData = json.decode(str);
  return Thing.fromMap(jsonData);
}

String thingToJson(Thing data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Thing {
  int id;
  String name;
  int cost;
  String date;
  // Map<String,dynamic> projectWork;
  String note;
  int isCash;

  Thing(
      {this.id,
      this.name,
      this.cost,
      this.date,
      // this.projectWork,
      this.note,
      this.isCash
      });

  factory Thing.fromMap(Map<String, dynamic> json) => new Thing(
      id: json["id"],
      name: json["name"],
      cost: json["cost"],
      date: json["date"],
      // projectWork: json["projectWork"],
      note: json["note"],
      isCash: json["isCash"]
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "cost": cost,
        "date": date,
        // "projectWork": projectWork,
        "note": note,
        "isCash": isCash
      };
}
