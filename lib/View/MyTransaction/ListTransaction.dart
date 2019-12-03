import 'package:expenditure_management/Control/CategorieImpl.dart';
import 'package:expenditure_management/Control/MouvementImpl.dart';
import 'package:expenditure_management/Model/Categorie.dart';
import 'package:expenditure_management/Model/Mouvement.dart';
import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/Service/Methods.dart';
import 'package:expenditure_management/Service/Property.dart';
import 'package:expenditure_management/View/Transaction/EditTransaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model/scoped_model.dart';

class ListTransaction extends StatefulWidget{

  RecordModel recordModel;
  DateTime periode;
  DateTime _dateDebut;
  DateTime _dateFin;
  bool isDepenseCheck;
  bool isRevenuCheck;

  ListTransaction(this.recordModel, this.periode, this._dateDebut, this._dateFin,
      this.isDepenseCheck, this.isRevenuCheck);

  @override
  State<StatefulWidget> createState() => _ListTransactionState();
}

class _ListTransactionState extends State<ListTransaction>{

  Mouvement _deletedMouvement;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
          shrinkWrap: true,
          primary: true,
          children: buildMouvements(widget.recordModel.records),
        )
    );
  }

  get buildLoading{
    return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(FIRST_COLOR)),
        )
    );
  }

  List<Widget> buildMouvements(List<Mouvement> records) {

    List<Categorie> _categories = CategorieImpl().getCategories();
    var position;
    List<Widget> mouvements = List();

    for( var index=0; index < records.length; index++ ){

      if(widget._dateDebut.isAfter(records[index].datetime) ||
          widget._dateFin.isBefore(records[index].datetime) ||
          (widget.isDepenseCheck == false && records[index].amount < 0) ||
          (widget.isRevenuCheck == false && records[index].amount > 0)
      ) continue;

      position = _categories.indexWhere((item) => item.name == records[index].categorie);
      IconData icon = _categories[position].icon;

      Slidable slidable = Slidable(
        closeOnScroll: true,
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.20,
        key: ValueKey(index),
        dismissal: SlidableDismissal(
          child: SlidableDrawerDismissal(),
          closeOnCanceled: true,
          onWillDismiss: (actionType) async {
            if(actionType == SlideActionType.primary) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditTransaction(widget.recordModel, records[index], widget.periode)));
              return false;
            }
            else
              return deleteMouvement(records, index);
          },
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Modifier',
            color: Colors.blue,
            icon: Icons.edit,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditTransaction(widget.recordModel, records[index], widget.periode))),
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Effacer',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => deleteMouvement(records, index),
          ),
        ],
        child: ListTile(
          leading: CircleAvatar(
              backgroundColor: records[index].amount < 0 ? Colors.red : Colors.green,
              child: Icon( icon, color: Colors.white, size: 30,)
          ),
          title: Text(records[index].categorie),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              records[index].description != null &&  records[index].description != "" ?
              Text("Description: "+ records[index].description, textScaleFactor: 0.8,)
                  : SizedBox(),
              Text( "Date: "+ Methods.getStringFromDateTime(records[index].datetime), textScaleFactor: 0.8,),
            ],
          ),
          trailing: Text(
            "${Methods.formatDisplayMontant(records[index].amount.abs().toString())}",
            style: TextStyle(color: records[index].amount < 0 ? Colors.red : Colors.green),
          ),
          contentPadding:
          EdgeInsets.symmetric(vertical: 0, horizontal: 16),
//              isThreeLine: true,
        ),
      );

      mouvements.insert(0, slidable);
    }

    mouvements.add(SizedBox(height: 40,));
    return mouvements;
  }

  //afficher un message toast
  void showToast(String message) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(message),
      duration: Duration(seconds: 3),
    ));
  }

  Future<bool> deleteMouvement(List<Mouvement> records, int index) async{
    bool resultat = false;
    Future future = MouvementImpl().deleteMouvement(records[index].id);
    future.timeout(Duration(seconds: 5),onTimeout: () {
      showToast("Echec de l'opération");
      resultat = false;
    });
    future.then((result) {
      if (result > 0){
        Scaffold.of(context).showSnackBar( new SnackBar(
          content: Text("Transaction supprimée"),
          duration: Duration(seconds: 3),
          action: SnackBarAction(
              label: "Annuler",
              onPressed: () => cancelDeletedMouvement(records, index)),
        ));
        _deletedMouvement = records[index];
        setState(() => records.removeAt(index));
        resultat = true;
      }
      else {
        showToast("Echec de l'opération");
        resultat = false;
      }
    }, onError: (e) {
      showToast("Une erreur s'est produite");
      resultat = false;
    });
    return resultat;
  }

  cancelDeletedMouvement(List<Mouvement> records, int index) {
    Future future = MouvementImpl().cancelDeletedMouvement(_deletedMouvement.id);
    future.timeout(Duration(seconds: 5),onTimeout: () {
      showToast("Echec de l'opération");
    });
    future.then((result) {
      if(result > 0) {
        setState(() {
          records.insert(index, _deletedMouvement);
        });
      }
    }, onError: (e) {
      Scaffold.of(context).showSnackBar( new SnackBar(
        content: Text("Transaction toujours supprimée"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
            label: "Réessayer",
            onPressed: () => cancelDeletedMouvement(records, index)),
      ));
    });
  }
}
