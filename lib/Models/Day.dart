import 'dart:convert';

import 'Person.dart';

Day dayFromJson(String str) {
  final jsonData = json.decode(str);
  return Day.fromMap(jsonData);
}

String dayToJson(Day data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}


List<Day> dayListFromJson(String data) {
  return json.decode(data);
}

String dayListToJson(List<Day> data) {
  return json.encode(data);
}


class Day {
  int id;
  DateTime date;
  String projectWork;
  String note;
  String persons;

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
