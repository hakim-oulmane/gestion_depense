import 'package:expenditure_management/Model/Categorie.dart';
import 'package:expenditure_management/Service/Property.dart';
import 'package:sqflite/sqlite_api.dart';

import 'CategorieRepository.dart';
import 'DBConnect.dart';

class CategorieImpl implements CategorieRepository{

  static List<Categorie> categories;

  List<Categorie> getCategories(){
    if(categories == null){
      Future futute = getAllCategorie();
      futute.then((result){
        categories = result;
      });
    }
    return categories;
  }

  @override
  Future<List> getAllCategorie() async {
    // TODO: implement getAllCategorie
    Database db = await DBConnect().database;
    List<Map> list = await db.rawQuery('SELECT * FROM categorie');

    List<Categorie> categorie = new List();
    for(Map item in list){
      Categorie object = new Categorie(
        item["name"],
        item["sign"] == "-" ? false : true,
        ICONS_CATEGORIE[item["icon"]]
      );
      categorie.add(object);
    }
    return categorie;
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