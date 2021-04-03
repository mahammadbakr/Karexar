import 'dart:convert';

Day dayFromJson(String str) {
  final jsonData = json.decode(str);
  return Day.fromMap(jsonData);
}

String dayToJson(Day data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Day {
  int id;
  DateTime date;
  Map<String,dynamic> projectWork;
  String note;
  List<Map<String,dynamic>> persons;

  Day(
      {this.id,
      this.date,
      this.projectWork,
      this.note,
      this.persons});

  factory Day.fromMap(Map<String, dynamic> json) => new Day(
      id: json["id"],
      date: json["date"],
      projectWork: json["projectWork"],
      note: json["note"],
      persons: json["persons"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "date": date,
        "projectWork": projectWork,
        "note": note,
        "persons": persons
      };
}
