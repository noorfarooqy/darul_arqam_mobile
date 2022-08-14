import 'package:darularqam/models/ColorCodesModel.dart';
import 'package:flutter/material.dart';

customAppBar() {
  return AppBar(
    backgroundColor: ColorCodesModel.swatch1,
    leading: Image(
      image: AssetImage('assets/images/logo2.png'),
      height: 30,
    ),
    title: Text(
      'DAARUL ARQAM',
      style: TextStyle(
        fontFamily: 'Squada',
        color: ColorCodesModel.swatch4,
      ),
    ),
  );
}
