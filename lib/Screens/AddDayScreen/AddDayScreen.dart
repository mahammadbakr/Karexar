import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kar_administration/Components/MainAppButton.dart';
import 'package:kar_administration/Components/MainDialog.dart';
import 'package:kar_administration/Components/MainTextField.dart';
import 'package:kar_administration/Helpers/Database.dart';
import 'package:kar_administration/Models/Day.dart';
import 'package:kar_administration/Models/Person.dart';
import 'package:kar_administration/Models/Project.dart';

import 'package:path/path.dart' as syspaths;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';

class AddDayScreen extends StatefulWidget {
  @override
  _AddDayScreenState createState() => _AddDayScreenState();
}

class _AddDayScreenState extends State<AddDayScreen> {
  bool isLoading = false;
  bool isPickedUp = false;

  Project currentProject;
  List<Person> personsList;
  var noteController = TextEditingController();

  Map<String, dynamic> dataMap = {
    "persons": "",
    "note": "",
  };

  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now().subtract(Duration(days: 6570));

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920, 8),
        lastDate: DateTime(2016));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dataMap["startDate"] =
            DateFormat('dd-MM-yyyy').format(selectedDate).toString();
        isPickedUp = true;
      });
      print(selectedDate);
      print(isPickedUp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Day",
          style:
              AppTextStyle.regularTitle20.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Text(
                        "Fill The Form Below to add a new Day \n",
                        style: AppTextStyle.regularTitle18
                            .copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      FutureBuilder<List<Project>>(
                        future: DBProvider.db.getAllProjects(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Project>> snapshot) {
                          print(snapshot.hasData);

                          if (snapshot.hasData) {
                            if (snapshot.data.isEmpty) {
                              return Center(
                                  child: Text(
                                    "Projects are Empty !",
                                    style: AppTextStyle.boldTitle20.copyWith(
                                        color: ColorConstants.blackAppColor),
                                  ));
                            }
                            return Row(
                              children: [
                                Text("Select a Project : "),
                                PopupMenuButton<Project>(
                                    initialValue: currentProject == null
                                        ? snapshot.data.first
                                        : currentProject,
                                    child: Text(currentProject == null
                                        ? snapshot.data.first.name
                                        : currentProject.name),
                                    onSelected: (Project value) async {
                                      setState(() {
                                        currentProject = value;
                                      });
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return snapshot.data
                                          .map(
                                            (i) => PopupMenuItem<Project>(
                                                value: i,
                                                child: Text(i.name.toString())),
                                          )
                                          .toList();
                                    }),
                              ],
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                      FutureBuilder<List<Person>>(
                        future: DBProvider.db.getAllPersons(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Person>> snapshot) {
                          print(snapshot.hasData);

                          if (snapshot.hasData) {
                            if (snapshot.data.isEmpty) {
                              return Center(
                                  child: Text(
                                    "Workers are Empty !",
                                    style: AppTextStyle.boldTitle20.copyWith(
                                        color: ColorConstants.blackAppColor),
                                  ));
                            }
                            return Row(
                              children: [
                                Text("Select Workers : "),
                                PopupMenuButton<Person>(
                                    initialValue: personsList == null
                                        ? snapshot.data.first
                                        : personsList.first,
                                    child: Text(personsList == null
                                        ? snapshot.data.first.firstName
                                        : personsList.first.firstName),
                                    onSelected: (Person value) async {
                                      setState(() {
                                        personsList.add(value);
                                      });
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return snapshot.data
                                          .map(
                                            (i) => PopupMenuItem<Person>(
                                            value: i,
                                            child: Text(i.firstName.toString())),
                                      )
                                          .toList();
                                    }),
                              ],
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),


                      SizedBox(
                        height: 15,
                      ),
                      MainTextField(
                        onChanged: (text) {
                          dataMap["note"] = text;
                        },
                        validator: (text) {
                          if (text.length < 6) {
                            return "Note not valid";
                          } else {
                            return null;
                          }
                        },
                        iconData: Icons.description_outlined,
                        hint: "Note",
                        controller: noteController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isPickedUp
                                ? Icon(
                                    Icons.done,
                                    color: ColorConstants.mainAppColor,
                                  )
                                : SizedBox.shrink(),
                            InkWell(
                              onTap: () async {
                                await _selectDate(context);
                              },
                              child: Row(
                                children: [
                                  isPickedUp
                                      ? Text(
                                          "(${DateFormat('dd-MM-yyyy').format(selectedDate)})",
                                          style: AppTextStyle.thinTitle14,
                                          textAlign: TextAlign.left,
                                        )
                                      : SizedBox.shrink(),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Date of Working ",
                                    style: AppTextStyle.regularTitle14
                                        .copyWith(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Image.asset(
                                    IconConstants.date,
                                    height: 20,
                                    color: ColorConstants.blackAppColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MainAppButton(
                        label: "save",
                        onPressed: onSubmit,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Have you a problem? ",
                              style: AppTextStyle.thinTitle12,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                "Help Center",
                                style: AppTextStyle.boldTitle18.copyWith(
                                    color: ColorConstants.mainAppColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    if (!isPickedUp) {
      showMainDialog(
          context: context,
          label: "Warning !",
          content: "Your picture is Missing ! \n Please Select a Date ");
    } else {
      try {
        DBProvider.db.newDay(Day(
          note: dataMap["date"],
          date: selectedDate,
          projectWork: projectToJson(currentProject),
          persons: personListToJson(personsList)
        ));

        setState(() {
          noteController.clear();
          isPickedUp = false;
        });
        showMainDialog(
            context: context,
            label: "Congrats !",
            content: "Registration Success! \n Thank you");
        Timer(Duration(seconds: 2), () {
          Navigator.pushNamed(context, "/home");
        });
      } catch (err) {
        showMainDialog(
            context: context, label: "Warning !", content: err.toString());
      }
    }
  }
}
