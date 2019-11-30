import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/Service/Methods.dart';
import 'package:flutter/material.dart';

class Actuality extends StatefulWidget {
  RecordModel model;
  DateTime periode;
  Actuality(this.model, this.periode);

  @override
  _ActualityState createState() => _ActualityState();
}

class _ActualityState extends State<Actuality> {
  @override
  Widget build(BuildContext context) {
    double soldePrecedent = 0;
    double revenu = 0;
    double depense = 0;

    widget.model.records.forEach((item) {
      if (item.datetime.isBefore(widget.periode)) {
        soldePrecedent += item.amount;
      } else {
        if (item.amount > 0)
          revenu += item.amount;
        else
          depense += item.amount;
      }
    });

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Solde restant",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              Methods.getStringFromDate(widget.periode) +
                  " à " +
                  Methods.getStringFromDate(DateTime.now()),
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 13,
                  color: Colors.grey),
            ),
            Divider(),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Revenu",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Solde précédent",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Dépense",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Solde actuel",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
                SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          Methods.formatDisplayMontant(revenu.toString()),
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          " +",
                          style: TextStyle(color: Colors.green, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          Methods.formatDisplayMontant(
                              soldePrecedent.abs().toString()),
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          " " + (soldePrecedent > 0 ? "+" : "-"),
                          style: TextStyle(
                              color: (soldePrecedent > 0
                                  ? Colors.green
                                  : Colors.red),
                              fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          Methods.formatDisplayMontant(
                              depense.abs().toString()),
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          " -",
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          Methods.formatDisplayMontant(
                              (soldePrecedent + revenu + depense)
                                  .abs()
                                  .toString()),
                          style: TextStyle(
                              fontSize: 18,
                              color: soldePrecedent + revenu + depense > 0
                                  ? Colors.green
                                  : Colors.red),
                        ),
                        Text(
                          " =",
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
