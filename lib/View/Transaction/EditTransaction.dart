import 'package:expenditure_management/Model/Mouvement.dart';
import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/components/AppBarPage.dart';
import 'package:expenditure_management/components/Drawer.dart';
import 'package:flutter/material.dart';

import 'EditDepense.dart';
import 'EditRevenu.dart';

class EditTransaction extends StatefulWidget{

  RecordModel model;
  Mouvement record;
  DateTime periode;
  EditTransaction(this.model, this.record, this.periode);

  @override
  State<StatefulWidget> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction>{

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBarPage.getAppBar("Modifier transaction"),
        drawer: DrawerPage(widget.model, widget.periode),
        body: widget.record.amount > 0 ? EditRevenu(widget.record, widget.model) : EditDepense(widget.record, widget.model),
      ),
    );;
  }

}

