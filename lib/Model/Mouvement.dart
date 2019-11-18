import 'Categorie.dart';

class Mouvement {

  int id;
  String categorie;
  double amount;
  String description;
  DateTime datetime;
  bool deleted;

  Mouvement(this.id, this.categorie, this.amount, this.description,
      this.datetime, this.deleted);
  
}