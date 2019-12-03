import 'package:expenditure_management/Control/DBConnect.dart';
import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/Service/Property.dart' as prefix0;
import 'package:expenditure_management/View/Transaction/AddTransaction.dart';
import 'package:expenditure_management/components/SelectPeriode.dart';
import 'package:expenditure_management/components/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:expenditure_management/Service/Property.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
import 'BodyHomePage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fr'), // French
        const Locale('en'), // English
      ],
      debugShowCheckedModeBanner: false,
      title: 'Gestion des dépenses',
      theme: ThemeData(
          primaryColor: FIRST_COLOR,
          backgroundColor: FIRST_COLOR,
          appBarTheme: AppBarTheme(color: FIRST_COLOR),
          buttonTheme: ButtonThemeData(
            buttonColor: FIRST_COLOR,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          ),
          fontFamily: 'Roboto',
          buttonColor: FIRST_COLOR),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  DateTime periode;
  MyHomePage({this.periode});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  RecordModel _recordModel;
  DateTime currentBackPressTime = DateTime.now().subtract(Duration(seconds: 5));
  DateTime _periode;

  @override
  void initState() {
    ///load the list of records
    _recordModel = RecordModel();
    _recordModel.loadListRecord();
    _periode = widget.periode ?? PERIODE_LIST["Hebedomadaire"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: ScopedModel(
          model: _recordModel,
          child: ScopedModelDescendant<RecordModel>(
              builder: (context, child, model) {
                if(model.isLoading)
                  return Scaffold(
                    body: Container(
                      child: buildLoading,
                    ),
                  );

                else {
                  return Scaffold(
                    key: scaffoldKey,
                    //app bar
                    appBar: AppBar(
                      title: Text("Accueil"),
                      centerTitle: true,
                      actions: <Widget>[
                        SelectPeriode(
                          periode: _periode,
                          onChangePeriode: (value) =>
                              setState(() => _periode = value),
                        )
                      ],
                    ),

                    //drawer
                    drawer: DrawerPage(model, _periode),

                    //body
                    body: BodyHomePage(model, _periode),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () =>
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddTransaction(model, _periode))),
                      child: Icon(Icons.add),
                      backgroundColor: Colors.red,
                      //Appuyez à nouveau pour quitter
                      tooltip: "Ajoutez une transaction",
                    ),
                  );
                }
          }),
        ),
      ),
    );
  }

  get buildLoading{
    return Center(
      child: SpinKitCircle(
        color: FIRST_COLOR,
        size: 50.0,
      ),
    );
  }

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      showToast(
          'Appuyez à nouveau pour quitter'); // you can use snackbar too here
      return Future.value(false);
    }

    ///closing database connection
    DBConnect().closeDB();
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  void showToast(String message) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(message),
      duration: Duration(seconds: 2),
    ));
  }
}
