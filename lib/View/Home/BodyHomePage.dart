import 'package:flutter/material.dart';

class BodyHomePage extends StatefulWidget {
  @override
  _BodyHomePageState createState() => _BodyHomePageState();

}

class _BodyHomePageState extends State<BodyHomePage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          shrinkWrap: true,
          primary: true,
          children: <Widget>[
            getActuality,
            getButtons,
          ],
        ),
      ),
    );
  }

  get getActuality {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Solde restant", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            ),

            Text("10/11/2019 à 15/11/2019", style: TextStyle(
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
                  children: <Widget>[

                    Text("Revenu",
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
                  children: <Widget>[

                    Row(
                      children: <Widget>[
                        Text("0.00", style: TextStyle(
                            fontSize: 18),),
                        Text(" +", style: TextStyle(
                            color: Colors.green, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Text("4,000.00", style: TextStyle(
                            fontSize: 18),),
                        Text(" -", style: TextStyle(
                            color: Colors.red, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Text("3,000.00", style: TextStyle(
                            fontSize: 18, color: Colors.green),),
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
      padding: EdgeInsets.symmetric(horizontal: 30),
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

}