import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/Tools/Property.dart';
import 'package:expenditure_management/View/Home/MyHomepage.dart';
import 'package:expenditure_management/components/AppBar.dart';
import 'package:expenditure_management/components/Drawer.dart';
import 'package:flutter/material.dart';

import 'AddDepense.dart';
import 'AddRevenu.dart';

class AddTransaction extends StatefulWidget {
  RecordModel recordModel;
  AddTransaction(this.recordModel);

  @override
  State<StatefulWidget> createState() => _AddTransactionState();

}

class _AddTransactionState extends State<AddTransaction> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBarPage.getAppBar("Nouvelle transaction"),
          drawer: DrawerPage(),
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.black,
            indicatorColor: Color.fromRGBO(54, 0, 0, 1),
            tabs: [
              Tab(
                child: Text("Dépense", style: TextStyle(color: SECOND_COLOR),),
                icon: Icon(Icons.do_not_disturb_on, color: SECOND_COLOR,),
              ),
              Tab(
                child: Text("Revenu", style: TextStyle(color: FIRST_COLOR),),
                icon: Icon(Icons.add_circle, color: FIRST_COLOR,),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              AddDepense(widget.recordModel),
              AddRevenu(widget.recordModel),
            ],
          ),
        ),
      ),
    );
  }
}