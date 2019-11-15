import 'package:flutter/material.dart';

class AppBarPage {

  static Widget getAppBar(String title){
    return AppBar(
      title: Text(title),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.20, 0.75],
            colors: <Color>[
              Colors.red,
              Colors.green
            ],
          ),
        ),
      ),
    );
  }

}