import 'package:expenditure_management/Control/MouvementImpl.dart';
import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/Service/Property.dart';
import 'package:expenditure_management/View/Home/MyHomepage.dart';
import 'package:expenditure_management/components/AppBarPage.dart';
import 'package:expenditure_management/components/Drawer.dart';
import 'package:flutter/material.dart';

class Parameter extends StatefulWidget {

  RecordModel model;
  Parameter(this.model);

  @override
  State<StatefulWidget> createState() => _ParameterState();
}

class _ParameterState extends State<Parameter> {

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBarPage.getAppBar("Paramaitre"),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              shrinkWrap: true,
              primary: true,
              children: <Widget>[
                RaisedButton(
                  onPressed: show_confirmation,
                  child: Text("Réinitialiser la base de donnée", style: TEXT_STYLE_BUTTON,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void show_confirmation() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        elevation: 8,
        title: Text("Gestion des dépenses"),
        contentPadding: EdgeInsets.all(24),
        children: <Widget>[
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: <Widget>[
              Text("Vous êtes sur le point de réinitialiser la base de donnée"),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text("Voulez-vous continuer et validez cette opération ?"),
              )
            ],
          ),

          //buttons
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Annuler',
                    style: TextStyle(color: FIRST_COLOR),
                  ),
                ),
                FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop(false);
                    resetDB();
                  },
                  child: Text('Confirmer', style: TextStyle(color: SECOND_COLOR),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void resetDB() {
    Future future = MouvementImpl().resetDB();
    future.timeout(Duration(seconds: 10),onTimeout: () {
      showToast("Echec de l'opération");
    });
    future.then((id) {
      if(id != null && id >= 0) {
        widget.model.records.clear();
        showToast("Base de donnée réinitialisée");
      }
      else
        showToast("Echec de l'opération");
    }, onError: (e) {
      showToast("Echec de l'opération");
    });
  }

  ///display a toast
  void showToast(String message) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(message),
      duration: Duration(seconds: 2),
    ));
  }
}