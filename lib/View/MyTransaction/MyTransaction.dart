import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/Tools/Property.dart';
import 'package:expenditure_management/View/Home/MyHomepage.dart';
import 'package:expenditure_management/View/Transaction/AddTransaction.dart';
import 'package:expenditure_management/components/AppBar.dart';
import 'package:expenditure_management/components/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'ListTransaction.dart';

class MyTransaction extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MyTransactionState();

}

class _MyTransactionState extends State<MyTransaction> {

  RecordModel _recordModel;

  @override
  void initState() {
    ///load the list of records
    _recordModel = RecordModel();
    _recordModel.loadListRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => MyHomePage())),
      child: SafeArea(
        child: ScopedModel(
          model: _recordModel,
          child: Scaffold(
              appBar: AppBarPage.getAppBar("Mes transactions"),
              drawer: DrawerPage(),
              body: ListTransaction(_recordModel),
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddTransaction(_recordModel))),
                child: Icon(Icons.add, color: Colors.white,),
                backgroundColor: SECOND_COLOR,
              ),
            ),
        ),
      )
    );
  }
}