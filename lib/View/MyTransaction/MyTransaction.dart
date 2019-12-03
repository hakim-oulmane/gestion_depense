import 'package:backdrop/backdrop.dart';
import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/Service/Methods.dart';
import 'package:expenditure_management/Service/Property.dart';
import 'package:expenditure_management/View/Home/MyHomepage.dart';
import 'package:expenditure_management/View/MyTransaction/FiltreTransaction.dart';
import 'package:expenditure_management/components/SelectPeriode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:pattern_formatter/date_formatter.dart';
import 'package:scoped_model/scoped_model.dart';

import 'ListTransaction.dart';

class MyTransaction extends StatefulWidget {
  RecordModel model;
  DateTime periode;

  MyTransaction(this.model, this.periode);

  @override
  State<StatefulWidget> createState() => _MyTransactionState();
}

class _MyTransactionState extends State<MyTransaction> {

  DateTime _dateDebut;
  DateTime _dateFin;
  bool isDepenseCheck;
  bool isRevenuCheck;

  @override
  void initState() {
    ///load the list of records
    _dateDebut = widget.periode;
    _dateFin = DateTime.now();
    isDepenseCheck = true;
    isRevenuCheck = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: BackdropScaffold(
        title: Text('Mes transactions'),
        headerHeight: 100,
        iconPosition: BackdropIconPosition.action,
        // Height of front layer when backlayer is shown.
//            headerHeight: 60.0,
        frontLayer: ListTransaction(
            widget.model, widget.periode, _dateDebut, _dateFin, isDepenseCheck, isRevenuCheck),
        backLayer: FilterTransaction(
          dateDebut: _dateDebut,
          dateFin: _dateFin,
          isDepenseCheck: isDepenseCheck,
          isRevenuCheck: isRevenuCheck,
          periode: widget.periode,
          onChangeFilter: (map){
            setState(() {
              _dateDebut = map["dateDebut"];
              _dateFin = map["dateFin"];
              isDepenseCheck = map["depenseCheck"];
              isRevenuCheck = map["revenuCheck"];
            });
          },
        ),
      ),
    );
  }
}
