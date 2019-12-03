import 'package:expenditure_management/Control/CategorieImpl.dart';
import 'package:expenditure_management/Model/Categorie.dart';
import 'package:expenditure_management/Model/Mouvement.dart';
import 'package:expenditure_management/Service/Property.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DepenseParCategorie extends StatelessWidget {
  List<Mouvement> records;
  DateTime periode;

  DepenseParCategorie(this.records, this.periode);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: new charts.BarChart(
        buildSeriesList(records),
        animate: true,
        behaviors: [
          new charts.SeriesLegend(
              position: charts.BehaviorPosition.top,
              outsideJustification: charts.OutsideJustification.end,
            desiredMaxColumns: 6
          ),
          new charts.PanAndZoomBehavior()
        ],
      ),
    );
  }

  List<charts.Series<CategorieSeriesSales, String>> buildSeriesList(List<Mouvement> records) {

    List<CategorieSeriesSales> listSeries = List();
    DateTime date = periode;

    List<Mouvement> m = List.from(records);
    m.retainWhere((item) => periode.isBefore(item.datetime) && item.amount < 0);

    var index;
    m.forEach((item) {
      index = listSeries.indexWhere((element) => element.name == item.categorie);
      if(index >= 0)
        listSeries[index].sales += item.amount.abs();
      else
        listSeries.add(CategorieSeriesSales(item.categorie, item.amount.abs()));
    });

    List<charts.Series<CategorieSeriesSales, String>> categorieSerie = List();

    //for(var i=0; i < listSeries.length; i++){
      categorieSerie.add(
        new charts.Series<CategorieSeriesSales, String>(
//          id: listSeries[i].name,
          id: "catégorie",
          domainFn: (CategorieSeriesSales sales, _) => sales.name,
          measureFn: (CategorieSeriesSales sales, _) => sales.sales,
          colorFn: (CategorieSeriesSales sales, _) =>
              charts.ColorUtil.fromDartColor(COLOR_STATS[2]),
          overlaySeries: true,
          data: listSeries,
        )
      );
//    }

    return categorieSerie;
  }

}

class CategorieSeriesSales {
  String name;
  double sales;

  CategorieSeriesSales(this.name, this.sales);
}