import 'package:flutter/material.dart';

import 'Methods.dart';

double getWidth(BuildContext context) => MediaQuery.of(context).size.width;
double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

Color FIRST_COLOR = Colors.green;
Color SECOND_COLOR = Colors.red;

TextStyle TEXT_STYLE = TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500,);
TextStyle LABEL_STYLE = TextStyle(fontSize: 15, color: Colors.grey);
TextStyle TEXT_STYLE_BUTTON = TextStyle(color: Colors.white);

List<Map> CATEGORIE_DEPENSE = [
  {"name": "Nourriture", "icon": Icons.restaurant_menu},
  {"name": "Boissons", "icon": Icons.local_cafe},
  {"name": "Transport", "icon": Icons.directions_subway},
  {"name": "Loyer", "icon": Icons.hotel},
  {"name": "Vêtement", "icon": Icons.local_offer},
  {"name": "Material", "icon": Icons.widgets},
  {"name": "Développement", "icon": Icons.android},
  {"name": "Personnel", "icon": Icons.person},
  {"name": "Charité", "icon": Icons.tag_faces},
  {"name": "Soins", "icon": Icons.local_hospital},
  {"name": "Voiture", "icon": Icons.drive_eta},
  {"name": "Autres", "icon": Icons.help},
];

List<Map> CATEGORIE_REVENU = [
  {"name": "Salaire", "icon": Icons.monetization_on},
  {"name": "Prêt", "icon": Icons.thumb_up},
  {"name": "Donation", "icon": Icons.redeem},
];

DateTime now = DateTime.now();

Map<String, DateTime> PERIODE_LIST = {
  "Par jour": DateTime(now.year, now.month, now.day, 0, 0, 0),
  "Hebedomadaire": DateTime(now.year, now.month, now.day - now.weekday, 0, 0, 0),
  "Bibedomadaire": DateTime(now.year, now.month, now.day - now.weekday, 0, 0, 0).subtract(Duration(days: 7)),
  "Mensuel": DateTime(now.year, now.month, 1, 0, 0, 0),
  "Trimestriel": Methods.getBeginTrimestre(now),
  "Semestriel": Methods.getBeginSemestre(now),
  "Annuel": DateTime(now.year, 1, 1, 0, 0, 0),
};

List<Color> COLOR_STATS = [
  FIRST_COLOR,
  Colors.deepOrange,
  Color(0xff1b56d4),
  Colors.purple,
  Color(0xff9de134),
  Color(0xfffdbe19),
  Color(0xff434348),
  Color(0xffa6c96a),
  Color(0xff77a1e5),
  Color(0xff288686),
];