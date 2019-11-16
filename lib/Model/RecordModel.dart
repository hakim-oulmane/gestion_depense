import 'package:expenditure_management/Control/MouvementImpl.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'Mouvement.dart';

class RecordModel extends Model {

  RecordModel();
  bool _isLoading = false;
  List<Mouvement> _listRecord;

  bool get isLoading => _isLoading;
  List<Mouvement> get records => _listRecord;
  int get lengthRecord => _listRecord.length;

  void loadListRecord() {
    _isLoading = true;
    notifyListeners();
    MouvementImpl().getAllMouvement().then((data) {
      _listRecord = data;
      _isLoading = false;
      notifyListeners();
    });
  }


  static RecordModel of(BuildContext context) =>
      ScopedModel.of<RecordModel>(context);

}