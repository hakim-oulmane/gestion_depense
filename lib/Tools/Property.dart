import 'package:flutter/material.dart';

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