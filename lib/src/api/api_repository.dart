// ignore_for_file: body_might_complete_normally_catch_error
import 'package:http/http.dart' as http;

class ApiRepository {
  ApiRepository();

  Future<http.Response> get(String url) {
    return http.get(Uri.parse(url));
  }
}
