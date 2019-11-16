import 'package:expenditure_management/Model/Categorie.dart';
import 'package:sqflite/sqlite_api.dart';

import 'CategorieRepository.dart';
import 'DBConnect.dart';

class CategorieImpl implements CategorieRepository{

  @override
  Future<List> getAllCategorie() async {
    // TODO: implement getAllCategorie
    Database db = await DBConnect().database;
    List<Map> list = await db.rawQuery('SELECT * FROM categorie');

    List<Categorie> categories = new List();
    for(Map item in list){
      Categorie object = new Categorie(
          item["name"],
          item["sign"] == "-" ? false : true);
      categories.add(object);
    }
    return categories;
  }

  @override
  Future<Map> getCategorieById(int id) {
    // TODO: implement getCategorieById
    return null;
  }

  @override
  Future<bool> insertCategorie(Categorie categorie) {
    // TODO: implement insertCategorie
    return null;
  }

}