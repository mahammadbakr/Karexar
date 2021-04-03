import 'dart:async';
import 'dart:io';

import 'package:kar_administration/Models/Day.dart';
import 'package:kar_administration/Models/Person.dart';
import 'package:kar_administration/Models/Project.dart';
import 'package:kar_administration/Models/Thing.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  //init database
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "MainDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await createProject(db);
      await createPerson(db);
      await createDay(db);
      await createThing(db);
    });
  }

  Future<void> createProject(Database db) async {
    await db.execute("CREATE TABLE Project ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "location TEXT,"
        "startDate TEXT,"
        "cost INTEGER,"
        "detail TEXT,"
        "image TEXT,"
        "ownerName TEXT,"
        "ownerNumber TEXT,"
        "days TEXT,"
        "isActive BOOLEAN"
        ")");
  }

  Future<void> createPerson(Database db) async {
    await db.execute("CREATE TABLE Person ("
        "id INTEGER PRIMARY KEY,"
        "firstName TEXT,"
        "secondName TEXT,"
        "salary INTEGER,"
        "image TEXT,"
        "description TEXT"
        ")");
  }

  Future<void> createDay(Database db) async {
    await db.execute("CREATE TABLE Day ("
        "id INTEGER PRIMARY KEY,"
        "date TEXT,"
        "projectWork TEXT,"
        "note TEXT,"
        "persons TEXT"
        ")");
  }

  Future<void> createThing(Database db) async {
    await db.execute("CREATE TABLE Thing ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "cost INTEGER,"
        "date TEXT,"
        "projectWork TEXT,"
        "note TEXT,"
        "isCash BOOLEAN"
        ")");
  }

  //#################################################################
  //New (ADD) queries

  newProject(Project obj) async {
    final db = await database;
    // var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM User");
    // int id = table.first["id"];
    var res = await db.rawInsert(
        "INSERT Into Project (name,location,startDate,cost,detail,image,ownerName,ownerNumber,days,isActive)"
        " VALUES (?,?,?,?,?,?,?,?,?,?)",
        [
          obj.name,
          obj.location,
          obj.startDate,
          obj.cost,
          obj.detail,
          obj.image,
          obj.ownerName,
          obj.ownerNumber,
          obj.days,
          obj.isActive
        ]);
    return res;
  }

  newPerson(Person obj) async {
    final db = await database;
    // var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM User");
    // int id = table.first["id"];
    var res = await db.rawInsert(
        "INSERT Into Person (firstName,secondName,salary,image,description)"
        " VALUES (?,?,?,?,?)",
        [
          obj.firstName,
          obj.secondName,
          obj.salary,
          obj.image,
          obj.description,
        ]);
    return res;
  }

  newDay(Day obj) async {
    final db = await database;
    // var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM User");
    // int id = table.first["id"];
    var res = await db.rawInsert(
        "INSERT Into Day (date,projectWork,note,persons)"
        " VALUES (?,?,?,?)",
        [
          obj.date,
          obj.projectWork,
          obj.note,
          obj.persons,
        ]);
    return res;
  }

  newThing(Thing obj) async {
    final db = await database;
    // var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM User");
    // int id = table.first["id"];
    var res = await db.rawInsert(
        "INSERT Into Thing (name,cost,date,projectWork,note,isCash)"
        " VALUES (?,?,?,?,?,?)",
        [
          obj.name,
          obj.cost,
          obj.date,
          obj.projectWork,
          obj.note,
          obj.isCash,
        ]);
    return res;
  }

  //#################################################################
  //Get (Select) queries

  getProjectByID(int id) async {
    final db = await database;
    var res = await db.query("Project", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Project.fromMap(res.first) : null;
  }

  getPersonByID(int id) async {
    final db = await database;
    var res = await db.query("Person", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Person.fromMap(res.first) : null;
  }

  getDayByID(int id) async {
    final db = await database;
    var res = await db.query("Day", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Day.fromMap(res.first) : null;
  }

  getThingByID(int id) async {
    final db = await database;
    var res = await db.query("Thing", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Thing.fromMap(res.first) : null;
  }

  Future<List<Project>> getAllProjects() async {
    final db = await database;
    var res = await db.query("Project");
    List<Project> list =
        res.isNotEmpty ? res.map((c) => Project.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Person>> getAllPersons() async {
    final db = await database;
    var res = await db.query("Person");
    List<Person> list =
        res.isNotEmpty ? res.map((c) => Person.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Day>> getAllDays() async {
    final db = await database;
    var res = await db.query("Day");
    List<Day> list =
        res.isNotEmpty ? res.map((c) => Day.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Thing>> getAllThings() async {
    final db = await database;
    var res = await db.query("Thing");
    List<Thing> list =
        res.isNotEmpty ? res.map((c) => Thing.fromMap(c)).toList() : [];
    return list;
  }

  //#################################################################
  //Delete (Remove) queries

  deleteProject(int id) async {
    final db = await database;
    return db.delete("Project", where: "id = ?", whereArgs: [id]);
  }

  deletePerson(int id) async {
    final db = await database;
    return db.delete("Person", where: "id = ?", whereArgs: [id]);
  }

  deleteDay(int id) async {
    final db = await database;
    return db.delete("Day", where: "id = ?", whereArgs: [id]);
  }

  deleteThing(int id) async {
    final db = await database;
    return db.delete("Thing", where: "id = ?", whereArgs: [id]);
  }

  deleteAllProjects() async {
    final db = await database;
    db.rawDelete("Delete * from Project");
  }

  deleteAllPersons() async {
    final db = await database;
    db.rawDelete("Delete * from Person");
  }

  deleteAllDays() async {
    final db = await database;
    db.rawDelete("Delete * from Day");
  }

  deleteAllThings() async {
    final db = await database;
    db.rawDelete("Delete * from Thing");
  }
}

//#################################################################
//Update (Modify) queries

// updateUser(User newUser) async {
//   final db = await database;
//   var res = await db.update("User", newUser.toMap(),
//       where: "id = ?", whereArgs: [newUser.IMEI]);
//   return res;
// }
