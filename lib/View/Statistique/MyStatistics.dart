import 'package:expenditure_management/Model/Mouvement.dart';
import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/View/Home/MyHomepage.dart';
import 'package:expenditure_management/components/AppBarPage.dart';
import 'package:expenditure_management/components/Drawer.dart';

/// Bar chart with default hidden series legend example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

class MyStatics extends StatefulWidget {
  DateTime periode;

  MyStatics(this.periode);

  @override
  _MyStaticsState createState() => _MyStaticsState();
}

class _MyStaticsState extends State<MyStatics> {
  RecordModel model;

  @override
  void initState() {
    model = RecordModel();
    model.loadListRecord();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBarPage.getAppBar("Statistiques"),
        body: ScopedModel(
          model: model,
          child: ScopedModelDescendant<RecordModel>(
              builder: (context, child, model) {
                if (model.records == null)
                  return _buildLoader();
                else
                  return Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                    child: new charts.TimeSeriesChart(
                      buildSeriesList(model.records),
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
              }),
        ),
      ),
    );
  }

  List<charts.Series<TimeSeriesSales, DateTime>> buildSeriesList(
      List<Mouvement> record) {
    List<TimeSeriesSales> depense = List<TimeSeriesSales>();
    List<TimeSeriesSales> revenu = List<TimeSeriesSales>();

    DateTime date = widget.periode;
    bool isDateChange = true;

    while(date.isBefore(DateTime.now())) {
      depense.add(TimeSeriesSales(timeCurrent: date, sales: 0));
      revenu.add(TimeSeriesSales(timeCurrent: date, sales: 0));
      date = date.add(Duration(days: 1));
    }
    List<Mouvement> m = List.from(record);
    m.retainWhere((item) => widget.periode.difference(item.datetime).inDays <= 0);
//    m.forEach((item) {
//      print("${item.categorie} ${item.datetime} ${item.amount}");
//    });

    var index;
    double sumRevenu = 0, sumDepense = 0;

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

    for(int i=1; i < depense.length; i++){
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

  Widget _buildLoader() {
    return SpinKitRotatingCircle(
      color: Colors.green,
      size: 50.0,
    );
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  DateTime timeCurrent;
  double sales;

  TimeSeriesSales({this.timeCurrent, this.sales});
}