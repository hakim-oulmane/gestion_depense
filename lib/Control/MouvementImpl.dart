import 'package:expenditure_management/Model/Mouvement.dart';
import 'package:expenditure_management/Tools/Methods.dart';
import 'package:sqflite/sqlite_api.dart';

import 'DBConnect.dart';
import 'MouvementRepository.dart';

class MouvementImpl implements MouvementRepository {

  @override
  Future<List> getAllMouvement() async {
    // TODO: implement getAllMouvement
    Database db = await DBConnect().database;
    List<Map> list = await db.rawQuery('SELECT m.id, m.categorie, c.sign, amount, '
        'description, datetime, deleted FROM mouvement m, categorie c WHERE m.categorie = c.name '
        'ORDER BY year, month, day, hour, minute');

    List<Mouvement> depenses = List();

    for(Map item in list){
      Mouvement object = Mouvement(
          item["id"],
          item["categorie"],
          item["amount"] * (item["sign"] == "-" ? -1 : 1),
          item["description"],
          Methods.getDateTimeFromString(item["datetime"]),
          item["deleted"] == 0 ? false : true
      );
      depenses.add(object);
    }
    return depenses;
  }

  @override
  Future<Map> getMouvementById(int id) {
    // TODO: implement getMouvementById
    return null;
  }

  @override
  Future<Map> getMouvementByType(String type) {
    // TODO: implement getMouvementByType
    return null;
  }

  @override
  Future<int> insertMouvement(Map data) async {
    // TODO: implement insertMouvement
    Database db = await DBConnect().database;

    DateTime dateTime = data["datetime"];
    DateTime beginYear = DateTime(dateTime.year, 1,1,0,0);
    int id;
    // Insert some records in a transaction
    await db.transaction((txn) async {
      id = await txn.rawInsert(
          'INSERT INTO mouvement(categorie, amount, description, datetime, '
              'hour, minute, day, week, month, year) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
          [data["categorie"], data["montant"], data["description"],
          Methods.getStringFromDateTime(dateTime), dateTime.hour,
          dateTime.minute, dateTime.day, (dateTime.difference(beginYear).inDays  ~/ 7),
          dateTime.month, dateTime.year]
      );
    });
    return id;
  }
}