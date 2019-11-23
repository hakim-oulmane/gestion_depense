import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/Tools/Property.dart';
import 'package:expenditure_management/View/Transaction/AddTransaction.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'Actuality.dart';
import 'LastRecords.dart';
import 'PieChart.dart';

class BodyHomePage extends StatefulWidget {

  RecordModel recordModel;
  DateTime periode;

  BodyHomePage(this.recordModel, this.periode);

  @override
  _BodyHomePageState createState() => _BodyHomePageState();

}

class _BodyHomePageState extends State<BodyHomePage> {

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ScopedModelDescendant<RecordModel>(builder: (context, child, model) {
          if (model.isLoading) {
            return buildLoading;
          } else {
            if (model.records != null) {
              return ListView(
                shrinkWrap: true,
                primary: true,
                children: <Widget>[
                  SizedBox(height: 20,),
                  Actuality(model, widget.periode),
                  getButtons,
                  PieCharts(model, widget.periode),
                  LastRecords(model, widget.periode),
                  SizedBox(height: 40,),
                ],
              );
            } else {
              return buildLoading;
            }
          }
        }),
      ),
    );
  }

  get getButtons {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

          RaisedButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) =>
                AddTransaction(widget.recordModel, widget.periode, 0))),
            color: Colors.red,
            child: Text(
                "Dépense",
                textScaleFactor: 1.3,
                style: TextStyle(color: Colors.white)
            ),
          ),

          RaisedButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) =>
                AddTransaction(widget.recordModel, widget.periode, 1))),
            color: Colors.green,
            child: Text(
                "Revenu",
                textScaleFactor: 1.3,
                style: TextStyle(color: Colors.white)
            ),
          )

        ],
      ),
    );
  }

  get buildLoading{
    return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(FIRST_COLOR)),
        )
    );
  }
}