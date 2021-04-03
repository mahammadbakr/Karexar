import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';

class MainTextField extends StatelessWidget {
  Function onChanged;
  Function validator;
  IconData iconData;
  String hint;
  TextEditingController controller;

  MainTextField(
      {this.onChanged, this.validator, this.iconData, this.hint,this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: onChanged,
        validator: validator,
        controller: controller,
        showCursor: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          prefixIcon: Icon(
            iconData,
            color: Color(0xFF666666),
            size: 20,
          ),
          fillColor: Color(0xFFF2F3F5),
          hintStyle: AppTextStyle.regularTitle14,
          hintText: hint,
        ));
  }
}
