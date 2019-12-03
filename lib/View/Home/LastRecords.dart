import 'package:expenditure_management/Control/CategorieImpl.dart';
import 'package:expenditure_management/Model/Categorie.dart';
import 'package:expenditure_management/Model/Mouvement.dart';
import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/Service/Methods.dart';
import 'package:expenditure_management/Service/Property.dart';
import 'package:expenditure_management/View/MyTransaction/MyTransaction.dart';
import 'package:flutter/material.dart';

class LastRecords extends StatefulWidget {
  RecordModel model;
  DateTime periode;

  LastRecords(this.model, this.periode);

  @override
  _LastRecordsState createState() => _LastRecordsState();
}

class _LastRecordsState extends State<LastRecords> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.model.lengthRecord == 0 ?
    Container() : GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyTransaction(widget.model, widget.periode))),
      child: Card(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              "Dix derniers enregistrements",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: buildRecord(widget.model),
            ),
          ],
        ),
      ),
    );
  }

  buildRecord(RecordModel model) {
    var index;
    List<Categorie> _categories = CategorieImpl().getCategories();

    return Column(
        children: model.records.reversed
            .toList()
            .sublist(0, model.lengthRecord > 10 ? 10 : model.lengthRecord)
            .map((Mouvement m) {

      index = _categories.indexWhere((item) => item.name == m.categorie);
      IconData icon = _categories[index].icon;

      return Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            child: CircleAvatar(
              child: Icon(
                icon,
                color: Colors.white,
              ),
              backgroundColor: m.amount > 0 ? FIRST_COLOR : SECOND_COLOR,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    m.categorie,
                    textScaleFactor: 1.2,
                  ),
                  if (m.description != null)
                    Text(
                      m.description,
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  Methods.formatDisplayMontant(m.amount.abs().toString()),
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  m.amount > 0 ? " +" : " -",
                  style: TextStyle(
                      color: m.amount > 0 ? Colors.green : Colors.red,
                      fontSize: 20),
                )
              ],
            ),
          )
        ],
      );
    }).toList());
  }

  get buildLoading {
    return Container(
        child: Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(FIRST_COLOR)),
    ));
  }
}
