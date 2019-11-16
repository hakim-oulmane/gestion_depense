
import 'package:expenditure_management/Tools/Property.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends  State<DrawerPage>{

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240.0,
      child: Drawer(
        child: ListView(
          children: <Widget>[

            Container(
              width: double.infinity,
              height: 130,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Gestion", style: TextStyle(color: Colors.white, fontSize: 20),),
                  Text("dépenses & revenus", style: TextStyle(color: Colors.white, fontSize: 20),)
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.20, 0.75],
                  colors: <Color>[
                    Colors.green,
                    Colors.red,
                  ],
                ),
              ),
            ),

            ListTile(
              title: Text("Accueil"),
              leading: Icon(Icons.home),
              onTap: () => debugPrint("Accueil"),
            ),
            ListTile(
              title: Text("Mes revenus"),
              leading: Icon(Icons.account_balance_wallet, color: FIRST_COLOR,),
              onTap: () => debugPrint("revenus"),
            ),
            ListTile(
              title: Text("Mes dépenses"),
              leading: Icon(Icons.local_atm, color: SECOND_COLOR,),
              onTap: () => debugPrint("dépenses"),
            ),
            ListTile(
              title: Text("Statistiques"),
              leading: Icon(Icons.insert_chart),
              onTap: () => debugPrint("Statistiques"),
            ),
            ListTile(
              title: Text("Paramètre"),
              leading: Icon(Icons.settings),
              onTap: () => debugPrint("Paramètre"),
            ),
            ListTile(
              title: Text("À propos",),
              leading: Icon(Icons.info),
              onTap: () => debugPrint("propos"),
            ),

          ],
        ),
      ),
    );
  }
  
}