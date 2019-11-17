import 'package:expenditure_management/Control/MouvementImpl.dart';
import 'package:expenditure_management/Model/Mouvement.dart';
import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/Tools/Methods.dart';
import 'package:expenditure_management/Tools/Property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model/scoped_model.dart';

class ListTransaction extends StatefulWidget{

  RecordModel recordModel;
  ListTransaction(this.recordModel);

  @override
  State<StatefulWidget> createState() => _ListTransactionState();
}

class _ListTransactionState extends State<ListTransaction>{

  Mouvement _deletedMouvement;

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScopedModelDescendant<RecordModel>(builder: (context, child, model) {
        if (model.isLoading) {
          return buildLoading;
        } else {
          if (model.records != null) {
            return ListView(
              shrinkWrap: true,
              primary: true,
              children: buildMouvements(model.records),
            );
          } else {
            return buildLoading;
          }
        }
      }),
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

    List<Map> CATEGORIES = List<Map>();
    CATEGORIES.addAll(CATEGORIE_DEPENSE);
    CATEGORIES.addAll(CATEGORIE_REVENU);
    var position;
    List<Widget> mouvements = List();

    for(var index=0; index < records.length; index++){
      position = CATEGORIES.indexWhere((item) => item["name"] == records[index].categorie);
      IconData icon = CATEGORIES[position]["icon"];

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
              //modifier
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
            onTap: () => debugPrint("Modifier"),
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
          onTap: () => debugPrint("list tile"),
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

      mouvements.add(slidable);
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
