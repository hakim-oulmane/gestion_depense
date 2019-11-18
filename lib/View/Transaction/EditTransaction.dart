import 'package:expenditure_management/Model/Mouvement.dart';
import 'package:expenditure_management/components/AppBar.dart';
import 'package:expenditure_management/components/Drawer.dart';
import 'package:flutter/material.dart';

import 'EditDepense.dart';
import 'EditRevenu.dart';

class EditTransaction extends StatefulWidget{

  Mouvement record;
  EditTransaction(this.record);

  @override
  State<StatefulWidget> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction>{

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBarPage.getAppBar("Modifier transaction"),
        drawer: DrawerPage(),
        body: widget.record.amount > 0 ? EditRevenu(widget.record) : EditDepense(widget.record),
      ),
    );;
  }

}

