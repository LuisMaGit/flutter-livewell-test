abstract class StatusCode {
  static const success = 200;
}

abstract class NetworkHeaders {
  static Map<String, String> authorization(String value) {
    return {'Authorization': value};
  }
}
