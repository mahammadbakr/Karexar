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

import 'package:path/path.dart' as syspaths;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';

class AddPersonScreen extends StatefulWidget {
  @override
  _AddPersonScreenState createState() => _AddPersonScreenState();
}

class _AddPersonScreenState extends State<AddPersonScreen> {
  bool isLoading = false;
  bool isUploaded = false;

  var salaryController = TextEditingController();
  var FNameController = TextEditingController();
  var SNameController = TextEditingController();
  var descriptionController = TextEditingController();

  Map<String, dynamic> dataMap = {
    "firstName": "",
    "secondName": "",
    "salary": 0,
    "description": "",
    "image": "",
  };

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
      appBar: AppBar(
        title: Text(
          "Add Worker",
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
                          dataMap["salary"] = text;
                        },
                        validator: (text) {
                          if (text.length < 4) {
                            return "Salary not valid";
                          } else {
                            return null;
                          }
                        },
                        iconData: Icons.money,
                        hint: "Salary",
                        controller: salaryController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              onChanged: (text) {
                                dataMap["firstName"] = text;
                              },
                              validator: (text) {
                                if (text.length < 4) {
                                  return "First Name not valid";
                                } else {
                                  return null;
                                }
                              },
                              controller: FNameController,
                              showCursor: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                filled: true,
                                fillColor: Color(0xFFF2F3F5),
                                hintStyle: AppTextStyle.regularTitle14,
                                hintText: "First Name",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              onChanged: (text) {
                                dataMap["secondName"] = text;
                              },
                              validator: (text) {
                                if (text.length < 4) {
                                  return "Second Name not valid";
                                } else {
                                  return null;
                                }
                              },
                              controller: SNameController,
                              showCursor: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                filled: true,
                                fillColor: Color(0xFFF2F3F5),
                                hintStyle: AppTextStyle.regularTitle14,
                                hintText: "Second Name",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      MainTextField(
                        onChanged: (text) {
                          dataMap["description"] = text;
                        },
                        validator: (text) {
                          if (text.length < 6) {
                            return "description not valid";
                          } else {
                            return null;
                          }
                        },
                        iconData: Icons.description_outlined,
                        hint: "Description",
                        controller: descriptionController,
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
        DBProvider.db.newPerson(Person(
            salary: int.parse(dataMap["salary"]),
            firstName: dataMap["firstName"],
            secondName: dataMap["secondName"],
            description: dataMap["description"],
            image: dataMap["image"],
        ));

        setState(() {
          salaryController.clear();
          FNameController.clear();
          SNameController.clear();
          descriptionController.clear();
          isUploaded = false;
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
