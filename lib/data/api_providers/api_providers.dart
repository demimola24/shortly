import 'dart:async';

import 'package:shrtcode/data/model/reponses/shorten_link_reponse.dart';
import 'package:shrtcode/data/network_manager/network_manager.dart';
import 'package:shrtcode/resources/app_config.dart';

class ApiProvider {

  Future<ShortenLinkResponse> fetchShortUrl(String url) async {
    APIResourceManager networkManager = new APIResourceManager();
    var completer = Completer<ShortenLinkResponse>();
    try {
      final response = await networkManager.networkRequestManager( APIRequestType.GET, ApiUrlConstants.apiShortenUrl(url),);
      var result = ShortenLinkResponse.fromJson(response.result);
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

}
