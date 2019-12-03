import 'package:expenditure_management/Model/RecordModel.dart';
import 'package:expenditure_management/View/Home/MyHomepage.dart';
import 'package:expenditure_management/View/MyTransaction/MyTransaction.dart';
import 'package:expenditure_management/View/Paramaitre/Parameter.dart';
import 'package:expenditure_management/View/Statistique/MyStatistics.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  DateTime periode;
  RecordModel model;

  DrawerPage(this.model, this.periode);

  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240.0,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            Image(
              height: 230,
              width: double.infinity,
              fit: BoxFit.cover,
              image: AssetImage("assets/logo.png"),
            ),
            ListTile(
              title: Text("Accueil"),
              leading: Icon(
                Icons.home,
                color: Colors.black54,
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            periode: widget.periode,
                          ))),
            ),
            ListTile(
              title: Text("Mes transactions"),
              leading: Icon(
                Icons.local_atm,
                color: Colors.black54,
              ),
              onTap: (){
                Navigator.of(context).pop(false);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyTransaction(widget.model, widget.periode)));
              },
            ),
            ListTile(
              title: Text("Statistiques"),
              leading: Icon(
                Icons.insert_chart,
                color: Colors.black54,
              ),
              onTap: (){
                Navigator.of(context).pop(false);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyStatics(widget.model, widget.periode)));
              },
            ),
            ListTile(
              title: Text("Paramètre"),
              leading: Icon(
                Icons.settings,
                color: Colors.black54,
              ),
              onTap: (){
                Navigator.of(context).pop(false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Parameter(widget.model)));
              }
            ),
            ListTile(
              title: Text(
                "À propos",
              ),
              leading: Icon(
                Icons.info,
                color: Colors.black54,
              ),
              onTap: () => debugPrint("propos"),
            ),
          ],
        ),
      ),
    );
  }
}
