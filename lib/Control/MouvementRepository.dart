abstract class MouvementRepository {

  Future<List> getAllMouvement();
  Future<Map> getMouvementById(int id);
  Future<Map> getMouvementByType(String type);
  Future<int> insertMouvement(Map data);
}