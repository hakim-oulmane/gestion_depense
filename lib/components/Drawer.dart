
import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/View/Home/MyHomepage.dart';
import 'package:expenditure_management/View/MyTransaction/MyTransaction.dart';
import 'package:expenditure_management/View/Paramaitre/Parameter.dart';
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
              leading: Icon(Icons.home, color: Colors.black54,),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage())),
            ),
            ListTile(
              title: Text("Mes transactions"),
              leading: Icon(Icons.local_atm, color: Colors.black54,),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyTransaction())),
            ),
            ListTile(
              title: Text("Statistiques"),
              leading: Icon(Icons.insert_chart, color: Colors.brown,),
              onTap: () => debugPrint("Statistiques"),
            ),
            ListTile(
              title: Text("Paramètre"),
              leading: Icon(Icons.settings, color: Colors.brown,),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Parameter())),
            ),
            ListTile(
              title: Text("À propos",),
              leading: Icon(Icons.info, color: Colors.brown,),
              onTap: () => debugPrint("propos"),
            ),

          ],
        ),
      ),
    );
  }
  
}