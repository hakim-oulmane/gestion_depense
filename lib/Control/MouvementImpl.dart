import 'package:expenditure_management/Model/Mouvement.dart';
import 'package:expenditure_management/Service/Methods.dart';
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
        'AND deleted = 0 ORDER BY year, month, day, hour, minute');

    List<Mouvement> mouvements = List();

    for(Map item in list){
      Mouvement object = Mouvement(
          item["id"],
          item["categorie"],
          item["amount"] * (item["sign"] == "-" ? -1 : 1),
          item["description"],
          Methods.getDateTimeFromString(item["datetime"]),
          item["deleted"] == 0 ? false : true
      );
      mouvements.add(object);
    }
    return mouvements;
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

  @override
  Future<int> updateMouvement(Map data) async {
    // TODO: implement updateMouvement
    Database db = await DBConnect().database;

    DateTime dateTime = data["datetime"];
    DateTime beginYear = DateTime(dateTime.year, 1,1,0,0);
    int count;
    // Insert some records in a transaction
    await db.transaction((txn) async {
      count = await txn.rawUpdate(
          'UPDATE mouvement SET categorie = ?, amount = ?, description = ?, datetime = ?, '
              'hour = ?, minute = ?, day = ?, week = ?, month = ?, year = ? WHERE id = ?',
          [data["categorie"], data["montant"], data["description"],
          Methods.getStringFromDateTime(dateTime), dateTime.hour,
          dateTime.minute, dateTime.day, (dateTime.difference(beginYear).inDays  ~/ 7),
          dateTime.month, dateTime.year, data["id"]]
      );
    });
    return count;
  }

  @override
  Future<int> deleteMouvement(int id) async {
    // TODO: implement deleteMouvement
    Database db = await DBConnect().database;
    return await db.rawUpdate('UPDATE mouvement SET deleted = 1 WHERE id = ?', [id]);
  }

  @override
  Future<int> cancelDeletedMouvement(int id) async{
    // TODO: implement cancelDeletedMouvement
    Database db = await DBConnect().database;
    return await db.rawUpdate('UPDATE mouvement SET deleted = 0 WHERE id = ?', [id]);
  }

  @override
  Future<int> resetDB() async {
    // TODO: implement resetDB
    Database db = await DBConnect().database;
    return await db.rawDelete('DELETE FROM mouvement');
  }
}