
import 'dart:async';
import 'package:shrtcode/data/api_providers/api_providers.dart';
import 'package:shrtcode/data/database/dao/dao.dart';
import 'package:shrtcode/data/database/database.dart';
import 'package:shrtcode/data/database/entities/entities.dart';
import 'package:shrtcode/data/model/reponses/shorten_link_reponse.dart';

class Repository {
  final apiProvider = ApiProvider();
  AppDatabase database;
  OfflineShortenLinkResponseDao _linkResponseDao;

  initializeDatabase() async{
    if(database==null || _linkResponseDao==null){
      database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      _linkResponseDao = database.offlineShortenLinkResponseDao;
    }
  }

  Future<ShortenLinkResponse> fetchShortUrl(String url) => apiProvider.fetchShortUrl(url);


  //Offline
  Future<List<OfflineShortenLinkResponse>> getAllLocalShortUrls()  async{
    return _linkResponseDao.getAllOfflineShortenLinkResponses();
  }


  Future<int> addOfflineSaleRecord(OfflineShortenLinkResponse record) async {
    return _linkResponseDao.insertOfflineShortenLinkResponse(record);
  }

  Future<void> closeDb() async {
    return database.close();
  }


}