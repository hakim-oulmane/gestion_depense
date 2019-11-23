import 'package:flutter/material.dart';

class AppBarPage {

  static Widget getAppBar(String title){
    return AppBar(
      title: Text(title),
      centerTitle: true,
    );
  }

}