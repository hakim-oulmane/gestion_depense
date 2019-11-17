abstract class MouvementRepository {

  Future<List> getAllMouvement();
  Future<int> insertMouvement(Map data);
  Future<int> deleteMouvement(int id);
  Future<int> cancelDeletedMouvement(int id);
  Future<int> resetDB();
}