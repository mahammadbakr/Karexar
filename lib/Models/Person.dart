import 'dart:convert';

Person personFromJson(String str) {
  final jsonData = json.decode(str);
  return Person.fromMap(jsonData);
}

String personToJson(Person data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Person {
  int id;
  String firstName;
  String secondName;
  int salary;
  String image;
  String description;

  Person(
      {this.id,
      this.firstName,
      this.secondName,
      this.salary,
      this.image,
      this.description});

  factory Person.fromMap(Map<String, dynamic> json) => new Person(
      id: json["id"],
      firstName: json["firstName"],
      secondName: json["secondName"],
      salary: json["salary"],
      image: json["image"],
      description: json["description"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "firstName": firstName,
        "secondName": secondName,
        "salary": salary,
        "image": image,
        "description": description};
}
