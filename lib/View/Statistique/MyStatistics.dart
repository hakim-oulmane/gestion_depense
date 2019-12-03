import 'package:expenditure_management/Components/SelectPeriode.dart';
import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/Service/Property.dart';

/// Bar chart with default hidden series legend example
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';

import 'DepenseParCategorie.dart';
import 'EvolutionChart.dart';

class MyStatics extends StatefulWidget {
  RecordModel model;
  DateTime periode;

  MyStatics(this.model, this.periode);

  @override
  _MyStaticsState createState() => _MyStaticsState();
}

class _MyStaticsState extends State<MyStatics> {
  RecordModel model;

  @override
  void initState() {
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
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Statistique"),
            centerTitle: true,
            actions: <Widget>[
              SelectPeriode(
                periode: widget.periode,
                onChangePeriode: (value)=> setState(() => widget.periode = value),
              )
            ],
          ),
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.black,
            indicatorColor: Color.fromRGBO(54, 0, 0, 1),
            tabs: [
              Tab(
                child: Text("Évolution", style: TextStyle(color: SECOND_COLOR),),
                icon: Icon(Icons.trending_up, color: SECOND_COLOR,),
              ),
              Tab(
                child: Text("Dépense par catégorie", style: TextStyle(color: FIRST_COLOR),),
                icon: Icon(Icons.insert_chart, color: FIRST_COLOR,),
              ),
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              EvolutionChart(widget.model.records, widget.periode),
              DepenseParCategorie(widget.model.records, widget.periode)
            ],
          )
        ),
      ),
    );
  }



  Widget _buildLoader() {
    return SpinKitRotatingCircle(
      color: Colors.green,
      size: 50.0,
    );
  }
}