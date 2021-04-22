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
import 'package:kar_administration/Models/Person.dart';
import 'package:kar_administration/Models/Thing.dart';

import 'package:path/path.dart' as syspaths;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';

class AddThingScreen extends StatefulWidget {
  @override
  _AddThingScreenState createState() => _AddThingScreenState();
}

class _AddThingScreenState extends State<AddThingScreen> {
  bool isLoading = false;
  bool isPickedUp = false;
  bool cashValue = true;

  var nameController = TextEditingController();
  var costController = TextEditingController();
  var noteController = TextEditingController();

  Map<String, dynamic> dataMap = {
    "name": "",
    "cost": 0,
    "date": DateTime.now(),
    "projectWork": "",
    "note": "",
    "isCash": 1,
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
          "Add Thing",
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
                        "Fill The Form Below to add a Worker \n",
                        style: AppTextStyle.regularTitle18
                            .copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      MainTextField(
                        onChanged: (text) {
                          dataMap["name"] = text;
                        },
                        validator: (text) {
                          if (text.length < 4) {
                            return "Name not valid";
                          } else {
                            return null;
                          }
                        },
                        iconData: Icons.markunread_mailbox,
                        hint: "Name",
                        controller: nameController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      MainTextField(
                        onChanged: (text) {
                          dataMap["cost"] = text;
                        },
                        validator: (text) {
                          if (text.length < 6) {
                            return "Cost not valid";
                          } else {
                            return null;
                          }
                        },
                        iconData: Icons.attach_money,
                        hint: "Cost",
                        controller: costController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                "cash ?",
                                style: AppTextStyle.regularTitle14
                                    .copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CupertinoSwitch(
                                value: cashValue,
                                onChanged: (value) {
                                  setState(() {
                                    cashValue = value;
                                  });
                                },
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 10,
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
                                    "Date of Birth ",
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
          content: "Your sate is missing ! \n Please select a date ");
    } else {
      try {
        DBProvider.db.newThing(Thing(
          name: dataMap["name"],
          cost: int.parse(dataMap["cost"]),
          note: dataMap["note"],
          date: dataMap["date"].toString(),
          // projectWork: dataMap["projectWork"],
          isCash: cashValue ? 1 : 0,
        ));

        setState(() {
          nameController.clear();
          costController.clear();
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
