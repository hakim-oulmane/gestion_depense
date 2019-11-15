import 'package:expenditure_management/View/Transaction/AddTransaction.dart';
import 'package:expenditure_management/components/AppBar.dart';
import 'package:expenditure_management/components/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:expenditure_management/Tools/Property.dart';
import 'BodyHomePage.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        //app bar
        appBar: AppBarPage.getAppBar("Accueil"),

        //drawer
        drawer: DrawerPage(),

        //body
        body: BodyHomePage(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTransaction())),
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
          tooltip: "Ajoutez une transaction",
        ),
      ),
    );
  }

}