import 'package:flutter/material.dart';

import 'Methods.dart';

double getWidth(BuildContext context) => MediaQuery.of(context).size.width;
double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

const Color FIRST_COLOR = Colors.green;
const Color SECOND_COLOR = Colors.red;

const TextStyle TEXT_STYLE = TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500,);
const TextStyle LABEL_STYLE = TextStyle(fontSize: 15, color: Colors.grey);
const TextStyle TEXT_STYLE_BUTTON = TextStyle(color: Colors.white);

const Map<String, IconData> ICONS_CATEGORIE = {
  "restaurant_menu": Icons.restaurant_menu,
  "local_cafe": Icons.local_cafe,
  "directions_subway": Icons.directions_subway,
  "hotel": Icons.hotel,
  "local_offer": Icons.local_offer,
  "widgets": Icons.widgets,
  "android": Icons.android,
  "person": Icons.person,
  "tag_faces": Icons.tag_faces,
  "local_hospital": Icons.local_hospital,
  "drive_eta": Icons.drive_eta,
  "help": Icons.help,
  "monetization_on": Icons.monetization_on,
  "thumb_up": Icons.thumb_up,
  "redeem": Icons.redeem,
};

DateTime now = DateTime.now();

final Map<String, DateTime> PERIODE_LIST = {
  "Par jour": DateTime(now.year, now.month, now.day, 0, 0, 0),
  "Hebedomadaire": DateTime(now.year, now.month, now.day - (now.weekday % 7), 0, 0, 0),
  "Bibedomadaire": DateTime(now.year, now.month, now.day - (now.weekday % 7), 0, 0, 0).subtract(Duration(days: 7)),
  "Mensuel": DateTime(now.year, now.month, 1, 0, 0, 0),
  "Trimestriel": Methods.getBeginTrimestre(now),
  "Semestriel": Methods.getBeginSemestre(now),
  "Annuel": DateTime(now.year, 1, 1, 0, 0, 0),
};

const List<Color> COLOR_STATS = [
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