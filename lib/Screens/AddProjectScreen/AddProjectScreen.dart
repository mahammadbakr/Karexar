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
import 'package:kar_administration/Models/Project.dart';


import 'package:path/path.dart' as syspaths;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';

class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  bool isLoading = false;
  bool isUploaded = false;
  bool isPickedUp = false;

  var nameController = TextEditingController();
  var locationController = TextEditingController();
  var costController = TextEditingController();
  var detailController = TextEditingController();
  var ownerNameController = TextEditingController();
  var ownerNumberController = TextEditingController();

  Map<String, dynamic> dataMap = {
    "name": "",
    "location": "",
    "startDate": DateTime.now(),
    "cost": 0,
    "detail": "",
    "image": "",
    "ownerName": "",
    "ownerNumber": 0,
    "days": "",
    "isActive": 1
  };



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

  final _formKey = GlobalKey<FormState>();

  File _image;
  final picker = ImagePicker();

  Future<void> _takePicture() async {
    final pickedFile = await picker.getImage(
        source: Platform.isAndroid ? ImageSource.camera : ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        isUploaded = true;
      } else {
        print('No image selected.');
      }
    });
    //save in SD Card
    // final  appDir = await getExternalStorageDirectory();
    //save in phone storage
    final appDir = await getApplicationDocumentsDirectory();
    var fileName = syspaths.basename(appDir.path);
    final File localImage = await _image.copy('${appDir.path}/$fileName');
    dataMap["image"] = localImage.path.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
        "Add Project",
        style: AppTextStyle.regularTitle20
            .copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),centerTitle: true,),
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
                        "Please Fill the form to add a new Project \n",
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
                        iconData: Icons.home_work_outlined,
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
                            return "Money not valid";
                          } else {
                            return null;
                          }
                        },
                        iconData: Icons.attach_money,
                        hint: "Money",
                        controller: costController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      MainTextField(
                        onChanged: (text) {
                          dataMap["detail"] = text;
                        },
                        validator: (text) {
                          if (text.length < 6) {
                            return "Detail is not valid";
                          } else {
                            return null;
                          }
                        },
                        iconData: Icons.description_outlined,
                        hint: "Detail",
                        controller: detailController,
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      MainTextField(
                        onChanged: (text) {
                          dataMap["ownerName"] = text;
                        },
                        validator: (text) {
                          if (text.length < 6) {
                            return "Owner Name is not valid";
                          } else {
                            return null;
                          }
                        },
                        iconData: Icons.person_outline,
                        hint: "Owner Name",
                        controller: ownerNameController,
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      MainTextField(
                        onChanged: (text) {
                          dataMap["ownerNumber"] = text;
                        },
                        validator: (text) {
                          if (text.length < 6) {
                            return "Owner Number is not valid";
                          } else {
                            return null;
                          }
                        },
                        iconData: Icons.phone_iphone,
                        hint: "Owner Number",
                        controller: ownerNumberController,
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => _takePicture(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              isUploaded
                                  ? Icon(
                                      Icons.done,
                                      color: ColorConstants.mainAppColor,
                                    )
                                  : SizedBox.shrink(),
                              Row(
                                children: [
                                  isUploaded
                                      ? Row(
                                          children: [
                                            Text(
                                              "(",
                                              style: AppTextStyle.thinTitle14,
                                              textAlign: TextAlign.left,
                                            ),
                                            Image.file(
                                              _image,
                                              height: 20,
                                            ),
                                            Text(
                                              ")",
                                              style: AppTextStyle.thinTitle14,
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Upload a Picture ",
                                    style: AppTextStyle.regularTitle14
                                        .copyWith(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Image.asset(
                                    IconConstants.upload,
                                    height: 20,
                                    color: ColorConstants.blackAppColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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

    if (!isUploaded) {
      showMainDialog(
          context: context,
          label: "Warning !",
          content: "Your picture is Missing ! \n Please Upload a picture ");
    } else {
      try {
        DBProvider.db.newProject(Project(
            name: dataMap["name"],
            location: dataMap["location"],
            cost: int.parse(dataMap["cost"]),
            detail: dataMap["detail"],
            ownerName: dataMap["ownerName"],
            ownerNumber: int.parse(dataMap["ownerNumber"]),
            image: dataMap["image"],
            startDate: dataMap["startDate"].toString(),
            days: dataMap["days"],
            isActive: 1
        ));


        setState(() {
          nameController.clear();
          locationController.clear();
          costController.clear();
          detailController.clear();
          ownerNameController.clear();
          ownerNumberController.clear();
          isUploaded = false;
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
            context: context,
            label: "Warning !",
            content: err.toString());
      }
    }
  }
}
