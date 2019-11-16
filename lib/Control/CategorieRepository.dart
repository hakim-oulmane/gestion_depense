import 'package:expenditure_management/Model/Categorie.dart';

abstract class CategorieRepository {

  Future<List> getAllCategorie();
  Future<Map> getCategorieById(int id);
  Future<bool> insertCategorie(Categorie categorie);

}