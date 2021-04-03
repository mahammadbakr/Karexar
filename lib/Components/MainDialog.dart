import 'package:flutter/material.dart';

import '../Constants.dart';

void showMainDialog({BuildContext context, String label, String content}) {
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //this right here
    child: Container(
      height: 300.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              label,
              style: TextStyle(color: ColorConstants.mainAppColor,fontSize: 24),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorConstants.blackAppColor,fontSize: 18),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 50.0)),
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(
                    color: ColorConstants.mainAppColor, fontSize: 18.0),
              ))
        ],
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => errorDialog);
}
