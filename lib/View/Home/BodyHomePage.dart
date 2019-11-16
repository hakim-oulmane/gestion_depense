import 'package:expenditure_management/Model/Mouvement.dart';
import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/Tools/Methods.dart';
import 'package:expenditure_management/Tools/Property.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BodyHomePage extends StatefulWidget {

  RecordModel recordModel;
  BodyHomePage(this.recordModel);

  @override
  _BodyHomePageState createState() => _BodyHomePageState();

}

class _BodyHomePageState extends State<BodyHomePage> {

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ScopedModelDescendant<RecordModel>(builder: (context, child, model) {
          if (model.isLoading) {
            return buildLoading;
          } else {
            if (model.records != null) {
              return ListView(
                shrinkWrap: true,
                primary: true,
                children: <Widget>[
                  SizedBox(height: 20,),
                  getActuality(model),
                  getButtons,
                  lastRecords(model),
                  SizedBox(height: 40,),
                ],
              );
            } else {
              return buildLoading;
            }
          }
        }),
      ),
    );
  }

  Widget getActuality(RecordModel model) {
    DateTime now = DateTime.now();
    DateTime firstDayWeek = DateTime(now.year, now.month, now.day - now.weekday);

    double soldePrecedent = 0;
    double revenu = 0;
    double depense = 0;

    model.records.forEach((item){
      if(item.datetime.isBefore(firstDayWeek)){
        soldePrecedent += item.amount;
      }
      else{
        if(item.amount > 0)
          revenu += item.amount;
        else
          depense += item.amount;
      }
    });

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Solde restant", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,),
            ),

            Text( Methods.getStringFromDate(firstDayWeek) +" à "+ Methods.getStringFromDate(now), style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 13,
                color: Colors.grey
            ),
            ),

            Divider(),

            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    Text("Revenu",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 5,),

                    Text("Solde précédent",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 5,),

                    Text("Dépense",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 5,),
                    Text("Solde actuel",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18),
                    )

                  ],
                ),

                SizedBox(
                  width: 50,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    Row(
                      children: <Widget>[
                        Text(Methods.formatDisplayMontant(revenu.toString()), style: TextStyle(
                            fontSize: 18),),
                        Text(" +", style: TextStyle(
                            color: Colors.green, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Text(Methods.formatDisplayMontant(soldePrecedent.abs().toString()), style: TextStyle(
                            fontSize: 18),),
                        Text(" "+ (soldePrecedent > 0 ? "+" : "-"), style: TextStyle(
                            color: (soldePrecedent > 0 ? Colors.green : Colors.red), fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Text(Methods.formatDisplayMontant(depense.abs().toString()), style: TextStyle(
                            fontSize: 18),),
                        Text(" -", style: TextStyle(
                            color: Colors.red, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Text(Methods.formatDisplayMontant((soldePrecedent+revenu+depense).abs().toString()), style: TextStyle(
                            fontSize: 18, color: soldePrecedent+revenu+depense > 0 ? Colors.green : Colors.red),),
                        Text(" =", style: TextStyle(
                            color: Colors.blue, fontSize: 18),
                        ),
                      ],
                    ),

                  ],
                ),

              ],
            ),


          ],
        ),
      ),
    );
  }

  get getButtons {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

          RaisedButton(
            onPressed: () => debugPrint("dépense"),
            color: Colors.red,
            child: Text(
                "Dépense",
                textScaleFactor: 1.3,
                style: TextStyle(color: Colors.white)
            ),
          ),

          RaisedButton(
            onPressed: () => debugPrint("Revenu"),
            color: Colors.green,
            child: Text(
                "Revenu",
                textScaleFactor: 1.3,
                style: TextStyle(color: Colors.white)
            ),
          )

        ],
      ),
    );
  }

  Widget lastRecords(RecordModel model){
    return Card(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          Text("Dix derniers enregistrements", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: buildRecord(model),
          ),
        ],
      ),
    );
  }

  buildRecord(RecordModel model) {
    var index;
    return Column(
      children:
        model.records.reversed.toList().sublist(0, model.lengthRecord > 20 ? 20 : model.lengthRecord)
          .map((Mouvement m){

        List<Map> CATEGORIES = List<Map>();
        CATEGORIES.addAll(CATEGORIE_DEPENSE);
        CATEGORIES.addAll(CATEGORIE_REVENU);

        index = CATEGORIES.indexWhere((item) => item["name"] == m.categorie);
        IconData icon = CATEGORIES[index]["icon"];

        return Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: CircleAvatar(
                child: Icon(icon, color: Colors.white,),
                backgroundColor: m.amount > 0 ? FIRST_COLOR : SECOND_COLOR,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(m.categorie, textScaleFactor: 1.2,),
                    if(m.description != null)
                      Text(m.description, style: TextStyle(fontSize: 13, color: Colors.grey),)
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(Methods.formatDisplayMontant(m.amount.abs().toString()), style: TextStyle(fontSize: 16),),
                  Text( m.amount > 0 ? " +" : " -",
                    style: TextStyle(color: m.amount > 0 ? Colors.green : Colors.red, fontSize: 20),
                  )
                ],
              ),
            )
          ],
        );
      }).toList()
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
}