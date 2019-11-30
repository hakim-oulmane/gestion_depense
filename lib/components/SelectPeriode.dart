import 'package:expenditure_management/Service/Property.dart';
import 'package:flutter/material.dart';

class SelectPeriode extends StatelessWidget {

  final IconData icon;
  final DateTime periode;
  final Function(DateTime) onChangePeriode;

  SelectPeriode({@required this.periode, @required this.onChangePeriode, this.icon = Icons.date_range});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopupMenuButton(
      icon: Icon(icon, color: Colors.white,),
      onSelected: (value) => onChangePeriode(PERIODE_LIST[value]),
      itemBuilder: (context) {
        return PERIODE_LIST.keys.map<PopupMenuItem<String>>((String value){
          return PopupMenuItem(child: Text(value), value: value,);
        }).toList();
      },
    );
  }


}