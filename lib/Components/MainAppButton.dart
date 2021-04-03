import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';

class MainAppButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  MainAppButton({@required this.label,@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.all(17.0),
        onPressed: onPressed,
        child: Text(
          "Save",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),
        color: ColorConstants.mainAppColor,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0),
            side: BorderSide(color: ColorConstants.mainAppColor)),
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: ColorConstants.mainAppColor),
    );
  }
}
//