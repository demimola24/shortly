

enum Environment { DEV, PROD }

class BaseUrl {
  static Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _BaseUrlConfig.debugConstants;
        break;
      case Environment.PROD:
        _config = _BaseUrlConfig.prodConstants;
        break;
    }
  }

  static get BASE_URL {
    return _config[_BaseUrlConfig.BASE_URL];
  }
}

class _BaseUrlConfig{
  static const BASE_URL = 'BaseUrl';

  static Map<String, dynamic> debugConstants = {
    BASE_URL: "https://api.shrtco.de/v2",
  };

  static Map<String, dynamic> prodConstants = {
    BASE_URL: "https://api.shrtco.de/v2/",
  };
}


class ApiUrlConstants {
  //auth
  static apiShortenUrl(String url) => "/shorten?url=$url";

}
