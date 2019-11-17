import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/View/Transaction/AddTransaction.dart';
import 'package:expenditure_management/components/AppBar.dart';
import 'package:expenditure_management/components/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:expenditure_management/Tools/Property.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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

class MyHomePage extends StatefulWidget{

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  RecordModel _recordModel;

  @override
  void initState() {
    ///load the list of records
    _recordModel = RecordModel();
    _recordModel.loadListRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: ScopedModel(
        model: _recordModel,
        child: ScopedModelDescendant<RecordModel>( builder: (context, child, model) {
          return Scaffold(
            //app bar
            appBar: AppBarPage.getAppBar("Accueil"),

            //drawer
            drawer: DrawerPage(),

            //body
            body: BodyHomePage(model),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddTransaction(model))),
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
              tooltip: "Ajoutez une transaction",
            ),
          );
        }),
      ),
    );
  }

}