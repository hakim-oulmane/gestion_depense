import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expenditure_management/Model/Mouvement.dart';
import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/Tools/Methods.dart';
import 'package:expenditure_management/Tools/Property.dart';
import 'package:flutter/material.dart';

class PieCharts extends StatefulWidget {

  RecordModel model;
  DateTime periode;
  PieCharts(this.model, this.periode);


  @override
  _PieChartsState createState() => _PieChartsState();
}

class _PieChartsState extends State<PieCharts> {

  final bool animate = true;
  bool isNull = false;

  @override
  Widget build(BuildContext context) {

    List<charts.Series> seriesList = getSeries(widget.model);

    return Stack(
      children: <Widget>[
        Card(
          child: Container(
            height: getWidth(context),
            padding: EdgeInsets.symmetric(vertical: getWidth(context) * 1 / 8),
            child: new charts.PieChart(seriesList,
                animate: animate,
                // Add the legend behavior to the chart to turn on legends.
                // This example shows how to optionally show measure and provide a custom
                // formatter.
                behaviors: [
                  new charts.DatumLegend(
                    // Positions for "start" and "end" will be left and right respectively
                    // for widgets with a build context that has directionality ltr.
                    // For rtl, "start" and "end" will be right and left respectively.
                    // Since this example has directionality of ltr, the legend is
                    // positioned on the right side of the chart.
                    position: charts.BehaviorPosition.bottom,
                    // By default, if the position of the chart is on the left or right of
                    // the chart, [horizontalFirst] is set to false. This means that the
                    // legend entries will grow as new rows first instead of a new column.
                    horizontalFirst: true,
                    desiredMaxColumns: 3,
                    // This defines the padding around each legend entry.
                    cellPadding: new EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                    // Set [showMeasures] to true to display measures in series legend.
                    showMeasures: true,
                    // Configure the measure value to be shown by default in the legend.
                    legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
                    // Optionally provide a measure formatter to format the measure value.
                    // If none is specified the value is formatted as a decimal.
                    measureFormatter: (num value) {
                      return '';
                    },
                  ),
                ],
                // Add an [ArcLabelDecorator] configured to render labels outside of the
                // arc with a leader line.
                //
                // Text style for inside / outside can be controlled independently by
                // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
                //
                // Example configuring different styles for inside/outside:
                //       new charts.ArcLabelDecorator(
                //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
                //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
                defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
                  new charts.ArcLabelDecorator(
                      labelPosition: charts.ArcLabelPosition.auto)
                ])),
          ),
        ),

        isNull ?
        Container(
          height: getWidth(context),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.9)
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(200, 200, 200, 0.4),
                borderRadius: BorderRadius.circular(3.0)
              ),
              child: Text("Il n'y a pas assez d'informations\npour créer ce résumé",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,),
            ),
          ),
        ) : Container()

      ],
    );
  }

  /// Create series
  List<charts.Series<StateMouvement, String>> getSeries(RecordModel model) {

    List<StateMouvement> data = [];

    int index = 0;
    int position;
    List<Mouvement> mouvements = new List.from(model.records);

    mouvements.retainWhere((item) =>
      widget.periode.isBefore(item.datetime) && item.amount < 0);

    if( mouvements.length == 0 ) {
      data = [
        StateMouvement(CATEGORIE_DEPENSE[0]["name"], 25, COLOR_STATS[0]),
        StateMouvement(CATEGORIE_DEPENSE[1]["name"], 25, COLOR_STATS[1]),
        StateMouvement(CATEGORIE_DEPENSE[2]["name"], 25, COLOR_STATS[2]),
        StateMouvement(CATEGORIE_DEPENSE[3]["name"], 25, COLOR_STATS[3]),
        StateMouvement(CATEGORIE_DEPENSE[4]["name"], 25, COLOR_STATS[4]),
        StateMouvement(CATEGORIE_DEPENSE[5]["name"], 25, COLOR_STATS[5]),
      ];
      setState(() => isNull = true);
    }
    else
      mouvements.forEach((Mouvement item){
        position = data.indexWhere((element) => item.categorie == element.categorie);
        if( position >= 0 )
          data[position].amount += item.amount.abs();
        else {
          data.add( StateMouvement(item.categorie, item.amount.abs(), COLOR_STATS[index%9]) );
          index++;
        }
      });

    return [
      new charts.Series<StateMouvement, String>(
        id: 'Categorie',
        domainFn: (StateMouvement sm, _) => sm.categorie,
        measureFn: (StateMouvement sm, _) => sm.amount,
        data: data,
        colorFn: (StateMouvement sm, _) =>
            charts.ColorUtil.fromDartColor(sm.color),
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (StateMouvement row, _) =>
          '${Methods.formatDisplayMontant(row.amount.toString())}',
      )
    ];
  }

}

/// Sample linear data type.
class StateMouvement {
  String categorie;
  double amount;
  Color color;

  StateMouvement(this.categorie, this.amount, this.color);
}


