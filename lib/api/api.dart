import 'package:http/http.dart' as http;

const baseurl = "https://fakestoreapi.com/";

class API {
  static Future<http.Response> get(uri) async {
    String url = baseurl + uri;
    return await http.get(Uri.parse(url));
  }
}
