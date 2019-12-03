import 'package:expenditure_management/Model/Mouvement.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class EvolutionChart extends StatelessWidget {
  List<Mouvement> records;
  DateTime periode;

  EvolutionChart(this.records, this.periode);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: new charts.TimeSeriesChart(
        buildSeriesList(records),
        animate: true,
        // Custom renderer configuration for the point series.
        customSeriesRenderers: [
          new charts.SymbolAnnotationRendererConfig(
            // ID used to link series to this renderer.
              customRendererId: 'customSymbolAnnotation')
        ],
        // Optionally pass in a [DateTimeFactory] used by the chart. The factory
        // should create the same type of [DateTime] as the data provided. If none
        // specified, the default creates local date time.
        dateTimeFactory: const charts.LocalDateTimeFactory(),
        behaviors: [
          new charts.SeriesLegend(
              position: charts.BehaviorPosition.top,
              outsideJustification: charts.OutsideJustification.end
          )
        ],
      ),
    );
  }

  List<charts.Series<TimeSeriesSales, DateTime>> buildSeriesList(
      List<Mouvement> record) {
    List<TimeSeriesSales> depense = List<TimeSeriesSales>();
    List<TimeSeriesSales> revenu = List<TimeSeriesSales>();

    DateTime date = periode;
    bool isDateChange = true;

    while(date.isBefore(DateTime.now())) {
      depense.add(TimeSeriesSales(timeCurrent: date, sales: 0));
      revenu.add(TimeSeriesSales(timeCurrent: date, sales: 0));
      date = date.add(Duration(days: 1));
    }
    List<Mouvement> m = List.from(record);
    m.retainWhere((item) => periode.isBefore(item.datetime));

    var index;

    m.forEach((item) {
      if (item.amount > 0) {
        index = revenu.indexWhere((element) => element.timeCurrent.difference(item.datetime).inDays == 0);
        revenu[index].sales += item.amount;
      }
      else {
        index = depense.indexWhere((element) => element.timeCurrent.difference(item.datetime).inDays == 0);
        depense[index].sales += item.amount.abs();
      }
    });

    for(var i=1; i < depense.length; i++){
      depense[i].sales += depense[i-1].sales;
      revenu[i].sales += revenu[i-1].sales;
    }

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Dépense',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.timeCurrent,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: depense,
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Revenu',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.timeCurrent,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: revenu,
      ),
    ];
  }

}

/// Sample time series data type.
class TimeSeriesSales {
  DateTime timeCurrent;
  double sales;

  TimeSeriesSales({this.timeCurrent, this.sales});
}