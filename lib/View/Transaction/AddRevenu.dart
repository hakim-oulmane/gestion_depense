import 'package:flutter/material.dart';

class AddRevenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddRevenuState();

}

class _AddRevenuState extends State<AddRevenu> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          shrinkWrap: true,
          primary: true,
          children: <Widget>[
            Text("Add revenue")
          ],
        ),
      ),
    );
  }

}