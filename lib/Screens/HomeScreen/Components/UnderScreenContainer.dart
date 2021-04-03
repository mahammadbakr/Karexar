import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Constants.dart';

class UnderScreenContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10,right: 10),
      color: ColorConstants.mainAppColor,
      child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.delete_forever_rounded,
            color: Colors.white,
          )),
    );
  }
}
